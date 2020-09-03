//
//  EnterpriseDetailViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/16.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "EnterpriseDetailViewController.h"
#import "QYDetailBannerView.h"
#import "DescribeCell.h"
#import "OperateDataCell.h"
#import "QYProductCell.h"

#import "QYBannerModel.h" // benner
#import "EnterpriseListModel.h" // 企业基本信息
#import "QYDetailProductModel.h" // 企业产品

static NSString *const bannerCellIdtfer = @"bannerCellIdtfer";
static NSString *const describeCellIdtfer = @"describeCellIdtfer";
static NSString *const operateDataCellIdtfer = @"operateDataCellIdtfer";
static NSString *const productCellIdtfer = @"productCellIdtfer";

@interface EnterpriseDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DescribeCellDelegate>
{
    UIView *_navView;
    UIButton *_backBtn;
    UILabel *_titleLabel;
    
    NSMutableArray *_bannerArr;
    
}
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page ;

@property (nonatomic) NSMutableArray *bannerArr;
@property (nonatomic) NSMutableArray *descrbiArr ;

@property (nonatomic, copy) NSString *companyName;



@end

@implementation EnterpriseDetailViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavView {
    CGFloat navHeight = 64.0;
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, navHeight)];
    _navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navView];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 50, navHeight);
    _backBtn.backgroundColor = [UIColor clearColor];
    [_backBtn setImage:[Tool getTYArrowheadImage:TYBlueArrowheadDirectionLeft] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_backBtn];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"企业";
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.bounds = CGRectMake(0, 0, 80, navHeight);
    _titleLabel.center = CGPointMake(SCREEN_WIDTH/2.0, navHeight/2.0);
    _titleLabel.font = [UIFont systemFontOfSize:22];
    _titleLabel.textColor = [Tool blueColor];
    [_navView addSubview:_titleLabel];
}

- (void)initializeDataSource {
    [self getBannersInfo];
    [self getCompanyInfo];
    [self getProducts];
}

- (void)getBannersInfo {
    WeakObj(self)
    // banner(获取企业图片接口)
    
    NSString *qyPicUrl = [NSString stringWithFormat:@"%@api/EnterprisePic/GetEnterprisePic",BASEURL];
    NSDictionary *picParam = @{@"companyID":_CompanyID,@"take":@"3"};
    [NetManager getWithURL:qyPicUrl params:picParam animation:YES success:^(id obj) {
        if ([obj isKindOfClass:[NSArray class]]) {
            for (NSDictionary *d in obj) {
                QYBannerModel *model = [[QYBannerModel alloc] initWithDictionary:d];
                [weakself.bannerArr addObject:model.ThumbnailPath];
            }
        }
        NSIndexPath *indxPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [weakself.collectionView reloadItemsAtIndexPaths:@[indxPath]];
    } failure:^(NSError *error) {
        
    }];
}

- (void)getCompanyInfo {
    WeakObj(self)
    //获取企业基本信息
    NSString *companyInfoUrl = [NSString stringWithFormat:@"%@api/Enterprise/GetEnterprise/%@",BASEURL,_CompanyID];
    [NetManager getWithURL:companyInfoUrl params:nil animation:YES success:^(id obj) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            EnterpriseListModel *model = [[EnterpriseListModel alloc] initWithDictionary:obj];
            NSArray *desArr = @[@{@"title":@"公司简介",@"destring":model.Description},
                                @{@"title":@"主营业务",@"destring":model.MainBusiness},
                                @{@"title":@"经营范围",@"destring":model.ScopeOfBusiness},
                                @{@"title":@"企业地址",@"destring":model.CompanyAdress}
                                ];
            
            weakself.companyName = model.CompanyName;
            
            for (NSDictionary *d in desArr) {
                DescribeModel *model = [[DescribeModel alloc] initWithDictionary:d];
                
                [_descrbiArr addObject:model];
            }
            [weakself calculateData:desArr];
            
            [weakself.collectionView reloadData];
            
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)getProducts {
    
    if (_CompanyID.length == 0) {
        _CompanyID = @"0";
    }
    
    WeakObj(self)
    // 企业的产品
    NSString *productUrl = [NSString stringWithFormat:@"%@api/Product/GetProductPageList",BASEURL];
    NSDictionary *productParam = @{@"enterpriseID":_CompanyID,
                                   @"productTypeID":@"0",
                                   @"pageNo":@(_page),
                                   @"pageSize":pageSize,
                                   @"searchKey":@""
                                   };
    
    NSLog(@"productParam = %@",productParam);
    
    [NetManager getWithURL:productUrl params:productParam animation:YES success:^(id obj) {
        NSLog(@"listtttt = %@",obj);
        
        if ([obj[@"Lists"] isKindOfClass:[NSArray class]]) {
            NSArray *productArr = obj[@"Lists"];
            for (NSDictionary *d in productArr) {
                QYDetailProductModel *model = [[QYDetailProductModel alloc] initWithDictionary:d];
                [weakself.dataArray addObject:model];
            }
        }
        
        [weakself.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)calculateData:(NSArray *)desArr {
    
    for (int i=0; i<desArr.count; i++) {
        
        CGFloat cellH = 60; // 预估一个数
        CGFloat topLineH = 10.0;
        CGFloat titleH = 10 * 2 + 20; // 标题部分
        CGFloat bottomBtnH = 30;
        DescribeModel *model = _descrbiArr[i];
        
        NSString *tempStr = [NSString stringWithFormat:@"%@",model.destring];
        
        CGRect rect = [tempStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-22, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        
        //不展开文字的高度
        CGFloat describeSimpleLabelH = 0;
        //展开文字的最大高度
        CGFloat describeDetailLabelH = rect.size.height;
        
        //判断需不需要显示 “查看详情” 按钮
        CGFloat textRowH = 16.707031;
        //不展开文字的cell高度
        CGFloat cellSimpleCellH = 0.0;
        
        if (rect.size.height >= textRowH*5) {
            // 5排字及以上
            model.showBtn = @"1";
            
            describeSimpleLabelH = textRowH * 4;
            
            cellSimpleCellH = topLineH + titleH + 10 + textRowH * 4 + 10 + bottomBtnH;
            //cell的最大高度
            cellH = topLineH + titleH + 10 + rect.size.height + 10 + bottomBtnH;
            
        } else {
            //不足5排字
            model.showBtn = @"0";
            
            cellSimpleCellH = topLineH + titleH + 10 + rect.size.height + 10;
            cellH = topLineH + titleH + 10 + rect.size.height + 10;
            
            describeSimpleLabelH = rect.size.height;
        }
        
        model.describeSimpleLabelH = [NSString stringWithFormat:@"%f",describeSimpleLabelH];
        model.describeDetailLabelH = [NSString stringWithFormat:@"%f",describeDetailLabelH];
        model.desCellH = [NSString stringWithFormat:@"%f",cellSimpleCellH];
        model.desDetailCellH = [NSString stringWithFormat:@"%f",cellH];
        model.showing = @"0";
    }
}

- (void)setCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH/2.0, 160);
//    layout.headerReferenceSize=CGSizeMake(self.view.frame.size.width, 250); //设置
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREENH_HEIGHT+20) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
//    _collectionView.header
    // banner
//    [_collectionView registerClass:[QYDetailBannerView class ]   forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:bannerCellIdtfer];
    [_collectionView registerClass:[QYDetailBannerView class] forCellWithReuseIdentifier:bannerCellIdtfer];
    // 描述
    [_collectionView registerClass:[DescribeCell class] forCellWithReuseIdentifier:describeCellIdtfer];
    [_collectionView registerClass:[OperateDataCell class] forCellWithReuseIdentifier:operateDataCellIdtfer];
    [_collectionView registerClass:[QYProductCell class] forCellWithReuseIdentifier:productCellIdtfer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_CompanyID == nil) {
        _CompanyID = @"";
    }
    if (_ProductionTypeID == nil) {
        _ProductionTypeID = @"";
    }
    _page = 1 ;
    _dataArray = [NSMutableArray arrayWithCapacity:20];
    _descrbiArr = [NSMutableArray arrayWithCapacity:5];
    _bannerArr = [NSMutableArray arrayWithCapacity:5];
    // 导航
    [self setCollectionView];
    [self setNavView];
    [self initializeDataSource];
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        QYDetailProductModel *model = self.dataArray[indexPath.item];
        NSString *url = [NSString stringWithFormat:@"%@Products/Index/%@",BASEURL,model.ProductID];
        WebViewController *vc = [[WebViewController alloc] initWithUrl:url];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return _descrbiArr.count;
    } else if (section == 2) {
        return 1;
    }
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CGFloat h = 200.0/375.0 * SCREEN_WIDTH+45;
        return CGSizeMake(CGRectGetWidth(self.view.bounds), h);
    } else if (indexPath.section == 1) {
        DescribeModel *model = self.descrbiArr[indexPath.item];
        if ([model.showing boolValue]) {
            /*
             model.showing = YES
             说明文字肯定超过 5排
             */
            return CGSizeMake(SCREEN_WIDTH, [model.desDetailCellH floatValue]);
        } else {
            return CGSizeMake(SCREEN_WIDTH, [model.desCellH floatValue]);
        }
    } else if (indexPath.section == 2) {
        return CGSizeMake(CGRectGetWidth(self.view.bounds), 120);
    }
    return CGSizeMake(CGRectGetWidth(self.view.bounds)/2.0, 160.0);
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)changeCellStatus:(DescribeCell *)cell indnxPath:(NSIndexPath *)indexPath {
    cell.detailLabel.text = nil;
    
    DescribeModel *model = self.descrbiArr[indexPath.item];
    model.showing = [NSString stringWithFormat:@"%d",cell.showing];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QYDetailBannerView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bannerCellIdtfer forIndexPath:indexPath];
        
        [cell setImageArr:_bannerArr companyName:_companyName];
        return cell;
    } else if (indexPath.section == 1) {
        DescribeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:describeCellIdtfer forIndexPath:indexPath];
        DescribeModel *model = self.descrbiArr[indexPath.item];
        [cell setCellvalue:model];
        
        cell.delegate = self;
        cell.indexPath = indexPath;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        return cell;
    } else if (indexPath.section == 2) {
        OperateDataCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:operateDataCellIdtfer forIndexPath:indexPath];
        
        WeakObj(self)
        cell.buttonClickEvent = ^(NSInteger btnTag) {
            NSString *webUrl = @"";
            if (btnTag == 0) {
                webUrl = [NSString stringWithFormat:@"%@Taxs/CompanyOutput/%@",BASEURL,weakself.CompanyID];
            } else if (btnTag == 1) {
                webUrl = [NSString stringWithFormat:@"%@Taxs/CompanyTax/%@",BASEURL,weakself.CompanyID];
            }
            
            WebViewController *vc = [[WebViewController alloc] initWithUrl:webUrl];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    } else if (indexPath.section == 3) {
        QYProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:productCellIdtfer forIndexPath:indexPath];
        
        QYDetailProductModel *model = self.dataArray[indexPath.item];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.DefualtPic] placeholderImage:[Tool getBigPlaceholderImage]];
        cell.nameLabel.text = model.ProductName;
        return cell;
    }
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:productCellIdtfer forIndexPath:indexPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
