//
//  QYDetailViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/20.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "QYDetailViewController.h"
#import "QYBannerModel.h" // benner
#import "EnterpriseListModel.h" // 企业基本信息
#import "DescribeModel.h"

#import "CircleBannerView.h"
#import "QYDescrbeTableCell.h"



static NSString *const describeCellIdtfer = @"describeCellIdtfer";
static NSString *const operateDataCellIdtfer = @"operateDataCellIdtfer";
static NSString *const productCellIdtfer = @"productCellIdtfer";

@interface QYDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CircleBannerViewDelegate,QYDescrbeTableCellDelegate>
{
    UIView *_navView;
    UIButton *_backBtn;
    UILabel *_titleLabel;
    
    NSMutableArray *_bannerArr;
}
@property (nonatomic) UITableView *tableView;
@property (nonatomic) CircleBannerView *bannerView;
@property (nonatomic) NSMutableArray *dataArray;//产品列表
@property (nonatomic, assign) NSInteger page ;

@property (nonatomic) NSMutableArray *descrbiArr ;
@end

@implementation QYDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _descrbiArr = [NSMutableArray arrayWithCapacity:4];
    [self setNavView];
    [self initializeDataSource];
    [self initializeUserInterface];
}

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
    WeakObj(self)
    // banner(获取企业图片接口)
    
    NSString *qyPicUrl = [NSString stringWithFormat:@"%@api/EnterprisePic/GetEnterprisePic",BASEURL];
    NSDictionary *picParam = @{@"companyID":_CompanyID,@"take":@"3"};
    [NetManager getWithURL:qyPicUrl params:picParam animation:YES success:^(id obj) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:5];
            for (NSDictionary *d in obj) {
                QYBannerModel *model = [[QYBannerModel alloc] initWithDictionary:d];
                [tempArr addObject:model.ThumbnailPath];
            }
            weakself.bannerView.imageArray = tempArr;
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    //获取企业基本信息
    NSString *companyInfoUrl = [NSString stringWithFormat:@"%@api/Enterprise/GetEnterprise/%@",BASEURL,_CompanyID];
    [NetManager getWithURL:companyInfoUrl params:nil animation:YES success:^(id obj) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            EnterpriseListModel *model = [[EnterpriseListModel alloc] initWithDictionary:obj];
            
            NSLog(@"ScopeOfBusiness = %@",model.ScopeOfBusiness);
            
            
            NSArray *desArr = @[@{@"title":@"公司简介",@"destring":model.Description},
                                @{@"title":@"主营业务",@"destring":model.MainBusiness},
                                @{@"title":@"经营范围",@"destring":model.ScopeOfBusiness},
                                @{@"title":@"企业地址",@"destring":model.CompanyAdress}
                                ];
            //技术推广服务软件开发信息系统集成服务信息技术咨询服务健康管理养生、健康、保健咨询服务（不得从事医疗诊治活动）教育咨询服务商品批发与零售。
            for (NSDictionary *d in desArr) {
                DescribeModel *model = [[DescribeModel alloc] initWithDictionary:d];
                
                [_descrbiArr addObject:model];
            }
            [weakself calculateData:desArr];
            
            [weakself.tableView reloadData];
            
        }
    } failure:^(NSError *error) {
        
    }];
    return ;
    
    // 企业对产品list
    NSString *productUrl = [NSString stringWithFormat:@"%@api/Product/GetProductPageList",BASEURL];
    NSDictionary *productParam = @{@"enterpriseID":_CompanyID,
                                   @"productTypeID":_productId,
                                   @"pageNo":@(_page),
                                   @"pageSize":pageSize,
                                   @"searchKey":@""
                                   };
    
    [NetManager getWithURL:productUrl params:productParam animation:YES success:^(id obj) {
        NSLog(@"pppp = %@",obj);
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
        
        cellH = titleH + 10 + rect.size.height + 10;
        
        //判断需不需要显示 “查看详情” 按钮
        CGFloat textRowH = 16.707031;
        //计算cell的全部文字的高度
        cellH = topLineH + titleH + 10 + rect.size.height + 10;
        CGFloat cellSimpleCellH = 0.0;
        
        CGFloat describeSimpleLabelH = 0;
        CGFloat describeDetailLabelH = rect.size.height;
        if (rect.size.height >= textRowH*5) {
            // 5排字及以上
            model.showBtn = @"1";
            describeSimpleLabelH = textRowH * 4;
            cellSimpleCellH = topLineH + titleH + 10 + describeSimpleLabelH + bottomBtnH;
            cellH += bottomBtnH;
            
        } else {
            //不足5排字
            model.showBtn = @"0";
            cellSimpleCellH = cellH;
            describeSimpleLabelH = describeDetailLabelH;
        }
        
        model.describeSimpleLabelH = [NSString stringWithFormat:@"%f",describeSimpleLabelH];
        model.describeDetailLabelH = [NSString stringWithFormat:@"%f",describeDetailLabelH];
        model.desCellH = [NSString stringWithFormat:@"%f",cellSimpleCellH];
        model.desDetailCellH = [NSString stringWithFormat:@"%f",cellH];
        model.showing = @"0";
    }
}

- (void)initializeUserInterface {
    CGFloat h = 200.0/375.0 * SCREEN_WIDTH+45;
    _bannerView = [[CircleBannerView alloc] init];
    _bannerView.banneDdelegate = self;
    _bannerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, h);
    _bannerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = _bannerView;
    
    WeakObj(self)
    //1.上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself initializeDataSource];
    }];
    // 2.下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 1;
        [weakself initializeDataSource];
    }];
    [self.view sendSubviewToBack:_tableView];
}

- (void)mainBannerClickIndex:(NSInteger)btnIndx indx:(NSInteger)indxxx {
    
}

- (void)changeCellStatus:(QYDescrbeTableCell *)cell indnxPath:(NSIndexPath *)indexPath {
    cell.detailLabel.text = nil;
    
    DescribeModel *model = self.descrbiArr[indexPath.item];
    model.showing = [NSString stringWithFormat:@"%d",cell.showing];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        DescribeModel *model = self.descrbiArr[indexPath.item];
        if ([model.showing boolValue]) {
            /*
             model.showing = YES
             说明文字肯定超过 5排
             */
            return [model.desDetailCellH floatValue];
        } else {
            return [model.desCellH floatValue];
        }
    } else if (indexPath.section == 1) {
        return 120.0;
    }
    
    return 160.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _descrbiArr.count;
    } else if (section == 1) {
        return 1;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        QYDescrbeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:describeCellIdtfer];
        
        if (!cell) {
            cell = [[QYDescrbeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:describeCellIdtfer];
        }
        
        DescribeModel *model = self.descrbiArr[indexPath.row];
        
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setCellvalue:model];
        
        return cell;
        
    }
    
    
    
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)+20) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
