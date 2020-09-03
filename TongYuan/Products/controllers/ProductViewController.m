//
//  ProductViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/17.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *_navBtnArr ;
    UIView *_topLine;
}
@property (nonatomic) UIScrollView *navScroll ;
@property (nonatomic) UIView *btnFalgLine;

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) NSMutableArray *dataArray;

@property (nonatomic) NSMutableArray *deatilArray;

@property (nonatomic, copy) NSString *searchKey;

@end

@implementation ProductViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _searchKey = @"";
    _ProductTypeID = @"";
    
    _secondEnterpriseTypeID = @"";
    _navBtnArr = [NSMutableArray arrayWithCapacity:11];
    _dataArray = [NSMutableArray arrayWithCapacity:6];
    _deatilArray = [NSMutableArray arrayWithCapacity:6];
    self.navigationItem.title = @"企业产品";
    self.view.backgroundColor = [Tool gayBgColor];
    
    [self initializeDataSource];
}

- (void)initializeDataSource {
    WeakObj(self)
    NSString *url = [NSString stringWithFormat:@"%@api/Product/GetTopProductTypeList",BASEURL];
    [NetManager getWithURL:url params:@{} animation:YES success:^(id obj) {
        
        if ([obj isKindOfClass:[NSArray class]]) {
            for (NSDictionary *d in obj) {
                ProductModel *model = [[ProductModel alloc] initWithDictionary:d];
                [weakself.dataArray addObject:model];
            }
            if (weakself.dataArray.count) {
                [weakself initializeUserInterface];
            }
        }
    } failure:^(NSError *error) {
        [UIAlertView showAlertViewWithMessage:@"数据加载失败，请检查网络或返回后重试"];
    }];
}

- (void)initializeUserInterface {
    
    /*
     * 左边
     */
    
    CGFloat textfieldX = 12.0;
    CGFloat textfieldY = 12.0;
    UIImage *searchImage = [Tool textfieldSearchIconImage];
    UIImageView *imgv_icon = [[UIImageView alloc] init];
    imgv_icon.image = searchImage;
    imgv_icon.bounds = CGRectMake(0, 0, 20, 20);
    imgv_icon.contentMode = UIViewContentModeLeft;
    UITextField *searchTF = [[UITextField alloc] init];
    searchTF.borderStyle = UITextBorderStyleRoundedRect;
    searchTF.frame = CGRectMake(textfieldX, textfieldY, SCREEN_WIDTH-textfieldX*2, 30);
    searchTF.delegate = self;
    searchTF.placeholder = SearchTFPlaceholderTextProductList;
    searchTF.font = [UIFont systemFontOfSize:13];
    searchTF.rightView = imgv_icon;
    searchTF.rightViewMode = UITextFieldViewModeAlways ;
    [self.view addSubview:searchTF];
    
    CGFloat scrollW = 120.0;
    _navScroll = [[UIScrollView alloc] init];
    _navScroll.backgroundColor = [UIColor whiteColor];
    _navScroll.frame = CGRectMake(0, CGRectGetMaxY(searchTF.frame)+textfieldY, scrollW, SCREENH_HEIGHT-64-49-44);
    _navScroll.delegate = self;
    _navScroll.showsVerticalScrollIndicator = NO;
    _navScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_navScroll];
    
    CGFloat linH = 1.0;
    CGFloat btnX = 0.0;
    CGFloat btnY = linH;
    CGFloat btnW = scrollW;
    CGFloat btnH = 40.0;
    _navScroll.contentSize = CGSizeMake(0, self.dataArray.count*(linH+btnH)+5);
    
    int selectedIndx = 0;
    CGRect selectedBtnRect = CGRectZero;
    
    UIView *lin1 = [[UIView alloc] init];
    lin1.backgroundColor = [Tool gayLineColor];
    lin1.frame = CGRectMake(btnX, 0, btnW, linH/1.5);
    [_navScroll addSubview:lin1];
    _topLine = lin1 ;
    
    for (int i=0; i<self.dataArray.count; i++) {
        
        ProductModel *model = self.dataArray[i];
        if (i == selectedIndx) {
            _ProductTypeID = model.ProductTypeID ;
            _currentType = model.ProductTypeName;
            [self getDetail];
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(btnX, btnY+i*(btnH+linH), btnW, btnH);
        button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        button.selected = i == selectedIndx;
        if (button.selected) {
            selectedBtnRect = button.frame ;
        }
        [button setBackgroundImage:[Tool imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button setBackgroundImage:[Tool imageWithColor:self.view.backgroundColor] forState:UIControlStateSelected];
        button.tag = 300 + i;
        [button setTitleColor:UIColorFromRGB(0x404040) forState:UIControlStateNormal];
        [button setTitleColor:[Tool blueColor] forState:UIControlStateSelected];
        [button setTitle:model.ProductTypeName forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showDetailInfo:) forControlEvents:UIControlEventTouchUpInside];
        [_navScroll addSubview:button];
        [_navBtnArr addObject:button];
        
        UIView *lineee = [[UIView alloc] init];
        lineee.backgroundColor = self.view.backgroundColor;
        lineee.frame = CGRectMake(btnX, CGRectGetMaxY(button.frame), btnW, linH);
        [_navScroll addSubview:lineee];
    }
    
    _btnFalgLine = [[UIView alloc] init];
    _btnFalgLine.frame = CGRectMake(selectedBtnRect.origin.x+0.5, selectedBtnRect.origin.y, 2.0, selectedBtnRect.size.height);
    _btnFalgLine.backgroundColor = [Tool blueColor];
    [_navScroll addSubview:_btnFalgLine];
    
    /*
     * 右边
     */
    ProductModel *model = self.dataArray[selectedIndx];
    NSString *imgUrl = model.ProductTypeIcon;
    
    CGFloat imgvX = CGRectGetMaxX(_navScroll.frame)+10.0;
    CGFloat imgvY = CGRectGetMinY(_navScroll.frame) + textfieldY;
    CGFloat imgvW = SCREEN_WIDTH-imgvX-10.0;
    CGFloat imgvH = 110.0/255.0 * imgvW;
    _imageView = [[UIImageView alloc] init];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[Tool getBigPlaceholderImage]];
    _imageView.frame = CGRectMake(imgvX, imgvY, imgvW, imgvH);
    _imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_imageView];
    
    UILabel *owerLabel = [UILabel new];
    owerLabel.font = [UIFont systemFontOfSize:14];
    owerLabel.textColor = UIColorFromRGB(0x999999);
    owerLabel.text = _currentType;
    [self.view addSubview:owerLabel];
    [owerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_imageView.mas_centerX);
        make.top.equalTo(_imageView.mas_bottom).offset(15);
    }];
    _currentTypeLabel = owerLabel ;
    for (int i=0; i<2; i++) {
        UIView *linee = [[UIView alloc] init];
        linee.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:linee];
        if (i == 0) {
            [linee mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(owerLabel.mas_centerY);
                make.height.mas_equalTo(1.0);
                make.width.mas_equalTo(SCREEN_WIDTH/7.7);
                make.right.equalTo(owerLabel.mas_left).offset(-10);
            }];
        } else if (i == 1) {
            [linee mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(owerLabel.mas_centerY);
                make.height.mas_equalTo(1.0);
                make.width.mas_equalTo(SCREEN_WIDTH/7.7);
                make.left.equalTo(owerLabel.mas_right).offset(10);
            }];
        }
    }
    
    CGFloat kindScrollX = imgvX;
    CGFloat kindScrollY = CGRectGetMaxY(_imageView.frame) + 40.0;;
    CGFloat kindScrollW = SCREEN_WIDTH-kindScrollX-textfieldX;
    CGFloat kindScrollH = SCREENH_HEIGHT-kindScrollY-49-64;
    
    _kindScroll = [[UIScrollView alloc] init];
    _kindScroll.backgroundColor = [UIColor clearColor];
    _kindScroll.frame = CGRectMake(kindScrollX, kindScrollY, kindScrollW, kindScrollH);
    _kindScroll.delegate = self;
    _kindScroll.showsVerticalScrollIndicator = NO;
    _kindScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_kindScroll];
}

- (void)showDetailInfo:(UIButton *)sender {
    if (sender.selected) return;
    
    BOOL show = sender.tag == 300;
    _topLine.hidden = !show;
    
    sender.selected = !sender.selected;
    for (UIButton *b in _navBtnArr) {
        if (b.selected && b != sender) {
            b.selected = !b.selected;
            break;
        }
    }
    CGRect tempRect = _btnFalgLine.frame;
    tempRect.origin.y = sender.frame.origin.y;
    [UIView animateWithDuration:0.25 animations:^{
        _btnFalgLine.frame = tempRect;
    }];
    
    ProductModel *model = _dataArray[sender.tag - 300];
    NSURL *URLLLLL = [NSURL URLWithString:model.ProductTypeIcon];
    [_imageView sd_setImageWithURL:URLLLLL placeholderImage:[Tool getBigPlaceholderImage]];
    /*
     * 根据button.tag拿到EnterpriseTypeID
     */
    _ProductTypeID = model.ProductTypeID ;
    _currentType = sender.titleLabel.text ;
    _currentTypeLabel.text = _currentType ;
    
    [self getDetail];
}

- (void)getDetail {
    if (_deatilArray.count) {
        [_deatilArray removeAllObjects];
    }
    NSString *url = [NSString stringWithFormat:@"%@api/Product/GetSecondProductTypeList",BASEURL];
    NSDictionary *param = @{@"productTypeID":_ProductTypeID};
    WeakObj(self)
    [NetManager getWithURL:url params:param animation:YES success:^(id obj) {
        
        if ([obj isKindOfClass:[NSArray class]]) {
            for (NSDictionary *d in obj) {
                ProductModel *model = [[ProductModel alloc] initWithDictionary:d];
                [weakself.deatilArray addObject:model];
            }
            [weakself detailView];
        }
    } failure:^(NSError *error) {
        [weakself detailView];
    }];
}

- (void)detailView {
    
    for (UIView *v in _kindScroll.subviews) {
        [v removeFromSuperview];
    }
    
    CGFloat textfieldX = 12.0;
    
    CGFloat labelW = (CGRectGetWidth(_kindScroll.bounds) - textfieldX*3) / 2.0;
    CGFloat labelH = 40.0;
    CGFloat labelY = 0;
    CGFloat labelX = 0;
    
    for (int i=0; i<self.deatilArray.count; i++) {
        ProductModel *model = self.deatilArray[i];
        NSString *companyCount = model.ProductCount;
        companyCount = [NSString stringWithFormat:@"%@个/种",companyCount];
        NSString *companyType = model.ProductTypeName;
        NSString *tex = [NSString stringWithFormat:@"%@%@",companyType,companyCount];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:tex];
        NSRange range = [tex rangeOfString:companyCount];
        [attr addAttribute:NSForegroundColorAttributeName value:[Tool blueColor] range:range];
        UILabel *detal = [UILabel new];
        detal.font = [UIFont systemFontOfSize:14];
        detal.textColor = UIColorFromRGB(0x666666);
        detal.textAlignment = NSTextAlignmentCenter;
        detal.attributedText = attr;
        detal.userInteractionEnabled = YES;
        detal.tag = 100 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelGesture:)];
        [detal addGestureRecognizer:tap];
        detal.backgroundColor = [UIColor whiteColor];
        detal.layer.cornerRadius = 2.0;
        detal.layer.masksToBounds = YES;
        detal.numberOfLines = 0;
        detal.frame = CGRectMake(labelX+(i%2)*(labelW+textfieldX), labelY+(i/2)*(labelH+textfieldX), labelW, labelH);
        
        [_kindScroll addSubview:detal];
    }
    
    NSInteger rowss = self.deatilArray.count/2;
    NSInteger yushu = self.deatilArray.count%2;
    if (yushu == 1) {
        rowss += 1;
    }
    CGFloat containSizeH = rowss * (labelH+textfieldX);
    _kindScroll.contentSize = CGSizeMake(100, containSizeH);
}

- (void)labelGesture:(UITapGestureRecognizer *)tap {
    
//    NSInteger indx = tap.view.tag - 100;
//    ProductModel *model = self.deatilArray[indx];
    
    ProductListViewController *vc = [[ProductListViewController alloc] init];
    vc.productTypeId = _ProductTypeID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushToProductList {
    
    ProductListViewController *vc = [[ProductListViewController alloc] init];
    vc.productTypeId = _ProductTypeID;
    vc.searchKey = _searchKey;
    [self.navigationController pushViewController:vc animated:YES];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    SearchViewController *vc = [[SearchViewController alloc] init];
    WeakObj(self)
    vc.searchResult = ^(NSString *searchKey) {
        weakself.searchKey = searchKey;
        [weakself pushToProductList];
    };
    vc.type = SearchTypeProductList;
    [self.navigationController pushViewController:vc animated:NO];
    
    return NO;
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
