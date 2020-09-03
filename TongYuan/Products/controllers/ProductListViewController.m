//
//  ProductListViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/17.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "ProductListViewController.h"
#import "GovermentListCell.h"
#import "ProductDetailModel.h"
static NSString *const cellIdentifier = @"cell";
@interface ProductListViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_topBtnArr;
    NSInteger _orderType ;

}
@property (nonatomic) UIView *topBg;
@property (nonatomic) UIView *conditionView;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic) NSMutableArray *dataArray ;

@property (nonatomic) UITextField *searchTF;
@property (nonatomic, copy) NSString *lastSearchKey ;
@end

@implementation ProductListViewController

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    SearchViewController *vc = [[SearchViewController alloc] init];
    WeakObj(self)
    vc.searchResult = ^(NSString *searchKey) {
        weakself.page = 1;
        weakself.searchKey = searchKey;
        weakself.searchTF.text = searchKey;
        [weakself initializeDataSource];
    };
    vc.type = SearchTypeProductList ;
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"产品列表";
    if (_productTypeId == nil) {
        _productTypeId = @"";
    }
    _topBtnArr = [NSMutableArray arrayWithCapacity:4];
    _page = 1;
    if (_orderType == 0) {
        _orderType = 1 ;
    }
    if (_searchKey == nil) {
        _searchKey = @"";
    }
    
    _dataArray = [NSMutableArray arrayWithCapacity:20];
    _topBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 56)];
    _topBg.backgroundColor = [Tool gayBgColor];
    [self.view addSubview:_topBg];
    
    _conditionView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topBg.frame), SCREEN_WIDTH, 40)];
    _conditionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_conditionView];
    
    [self baseUI];
    [self initializeDataSource];
}

- (void)initializeDataSource {
    
    if (_searchKey == nil) {
        _searchKey = @"";
    }
    
    if (_lastSearchKey == nil) {
        _lastSearchKey = @"";
    }
    
    if ([_searchKey isEqualToString:_lastSearchKey] == NO) {
        _lastSearchKey = _searchKey ;
        _page = 1;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@api/Product/GetProductPageList",BASEURL];
    NSDictionary *param = @{@"enterpriseID":@"0",
                            @"productTypeID":_productTypeId,
                            @"pageNo":@(_page),
                            @"pageSize":pageSize,
                            @"orderType":@(_orderType),
                            @"isAsc":@"true",
                            @"searchKey":_searchKey
                            };
    WeakObj(self)
    
    [NetManager getWithURL:url params:param animation:YES success:^(id obj) {
        
        [weakself.collectionView.mj_header endRefreshing];
        [weakself.collectionView.mj_footer endRefreshing];
        if (_page <= 1) {
            [weakself.dataArray removeAllObjects];
        }
        
        weakself.page ++;
        if ([obj[@"Lists"] isKindOfClass:[NSArray class]]) {
            NSArray *arr = obj[@"Lists"];
            for (NSDictionary *d in obj[@"Lists"]) {
                ProductDetailModel *model = [[ProductDetailModel alloc] initWithDictionary:d];
                [weakself.dataArray addObject:model];
            }
            weakself.collectionView.mj_footer.hidden = (arr.count < 20);
        }
        
        if (weakself.dataArray.count) {
            [weakself showPromitLabel:NO];
        } else {
            [weakself showPromitLabel:YES];
        }
        
        [weakself.collectionView reloadData];
    } failure:^(NSError *error) {
        [weakself.collectionView.mj_header endRefreshing];
        [weakself.collectionView.mj_footer endRefreshing];
        if (_page <= 1) {
            [weakself.dataArray removeAllObjects];
        }
        [weakself.collectionView reloadData];
    }];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GovermentListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    ProductDetailModel *model = self.dataArray[indexPath.item];
    NSURL *URLLLL = [NSURL URLWithString:model.DefualtThumbPic];
    [cell.imageView sd_setImageWithURL:URLLLL placeholderImage:[Tool getBigPlaceholderImage]];
    cell.nameLabel.text = model.ProductName;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailModel *model = self.dataArray[indexPath.item];
    NSString *webUrl = [NSString stringWithFormat:@"%@Products/Index/%@",BASEURL,model.ProductID];
    WebViewController *vc = [[WebViewController alloc] initWithUrl:webUrl];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)baseUI {
    
    CGFloat textfieldX = 12.0;
    CGFloat textfieldY = 12.0;
    UIImage *searchImage = [Tool textfieldSearchIconImage];
    UIImageView *imgv_icon = [[UIImageView alloc] init];
    imgv_icon.image = searchImage;
    imgv_icon.bounds = CGRectMake(0, 0, 20, 20);
    imgv_icon.contentMode = UIViewContentModeLeft;
    _searchTF = [[UITextField alloc] init];
    _searchTF.borderStyle = UITextBorderStyleRoundedRect;
    _searchTF.frame = CGRectMake(textfieldX, textfieldY, SCREEN_WIDTH-textfieldX*2, 30);
    _searchTF.delegate = self;
    _searchTF.text = _searchKey;
    _searchTF.placeholder = SearchTFPlaceholderTextProductList;
    _searchTF.font = [UIFont systemFontOfSize:13];
    _searchTF.rightView = imgv_icon;
    _searchTF.rightViewMode = UITextFieldViewModeAlways ;
    [self.topBg addSubview:_searchTF];
    
    self.conditionView.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"综合",@"产量"];
    CGFloat btnW = SCREEN_WIDTH / arr.count;
    CGFloat btnH = CGRectGetHeight(self.conditionView.bounds);
    
    int selectedIndx = 0;
    
    for (int i=0; i<arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(i*btnW, 0, btnW, btnH);
        [button setTitleColor:[Tool blueColor] forState:UIControlStateSelected];
        button.selected = i == selectedIndx;
        [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [button setBackgroundImage:[Tool imageWithColor:[Tool gayLineColor]] forState:UIControlStateHighlighted];
        button.tag = 200 + i;
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topBtnArr addObject:button];
        [self.conditionView addSubview:button];
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH/2.0, 160);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 96, SCREEN_WIDTH, SCREENH_HEIGHT-(64+56+40)) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[GovermentListCell class] forCellWithReuseIdentifier:cellIdentifier];
    WeakObj(self)
    //1.上拉加载
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself initializeDataSource];
    }];
    // 2.下拉刷新
    self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 1;
        [weakself initializeDataSource];
    }];
}

- (void)buttonClick:(UIButton *)button {
    if (button.selected) return;
    button.selected = !button.selected;
    for (UIButton *b in _topBtnArr) {
        if (b.selected && b != button) {
            b.selected = !b.selected;
            break;
        }
    }
    
    _page = 1;
//    _searchTF.text = @"";
//    _searchKey = @"";
    
    _orderType = button.tag - 200 + 1;
    [self initializeDataSource];
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
