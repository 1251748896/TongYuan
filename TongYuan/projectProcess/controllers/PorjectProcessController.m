//
//  PorjectProcessController.m
//  TongYuan
//
//  Created by apple on 2017/12/10.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "PorjectProcessController.h"
#import "ProjectProcessListCell.h"
#import "PorjectProcessListModel.h"
@interface PorjectProcessController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *_btnArr;//保存筛选按钮
    CGFloat screen_width;
    CGFloat screen_height;
}

@property (nonatomic) MenusViewController *menusVc ;
@property (nonatomic) NSMutableDictionary *searchParam ;

@property (nonatomic) BOOL showing ;

@property (weak, nonatomic) IBOutlet UIView *topBg ;
@property (weak, nonatomic) IBOutlet UIView *btnBg ;
@property (weak, nonatomic) IBOutlet UITableView *tableView ;
@property (nonatomic) NSMutableArray *dataArray ;
@property (nonatomic, assign) NSInteger page ;
@property (nonatomic, assign) NSInteger orderType ;
@property (nonatomic) UITextField *searchTF ;
@property (nonatomic, copy) NSString *lastSearchKey ;

@property (nonatomic, assign) BOOL pageToZero;


@end

@implementation PorjectProcessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_searchKey == nil) {
        _searchKey = @"";
    }
    if (_lastSearchKey == nil) {
        _lastSearchKey = @"";
    }
    _page = 1;
    _btnArr = [NSMutableArray arrayWithCapacity:4];
    _dataArray = [NSMutableArray arrayWithCapacity:20];
    self.view.backgroundColor = [Tool gayBgColor];
    self.navigationItem.title = @"项目进度";
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    
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
    _searchTF.placeholder = SearchTFPlaceholderTextProjectProjress;
    _searchTF.delegate = self;
    _searchTF.text = _searchKey;
    _searchTF.font = [UIFont systemFontOfSize:13];
    _searchTF.rightView = imgv_icon;
    _searchTF.rightViewMode = UITextFieldViewModeAlways ;
    [self.topBg addSubview:_searchTF];
    
    self.btnBg.backgroundColor = UIColorFromRGB(0xf1f8fe);
    NSArray *arr = @[@"综合",@"进度",@"投资额",@"筛选"];
    CGFloat btnW = SCREEN_WIDTH / arr.count;
    CGFloat btnH = CGRectGetHeight(self.btnBg.bounds);
    
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
        [self.btnBg addSubview:button];
        [_btnArr addObject:button];
    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
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
    screen_width = CGRectGetWidth(self.view.bounds);
    screen_height = CGRectGetHeight(self.view.bounds);
    _menusVc = [[MenusViewController alloc] init];
    _menusVc.view.frame = CGRectMake(screen_width, 0, screen_width, screen_height);
   
    _menusVc.removeSearchView = ^(id obj) {
        [weakself showAndClose];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            weakself.searchParam = [NSMutableDictionary dictionaryWithDictionary:obj];
            weakself.page = 1;
            [weakself initializeDataSource];
        }
    };
    
    [self addChildViewController:_menusVc];
    [self.view addSubview:_menusVc.view];
}

- (void)showAndClose {
    if (_showing == YES) {
        _menusVc.view.frame = CGRectMake(screen_width, 0, screen_width, screen_height);
        _showing = !_showing;
        return;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        if (_showing == NO) {
            _menusVc.view.frame = CGRectMake(0, 0, screen_width, screen_height);
        }
    }];
    _showing = !_showing;
}

- (void)buttonClick:(UIButton *)btn {
    /*
     * 排序类型 1、综合 2、进度 3、投资额
     */
    
    if (btn.tag == 203) {
        [self showAndClose];
        return;
    }
    if (btn.selected) return;
    btn.selected = !btn.selected;
    for (UIButton *b in _btnArr) {
        if (b.selected && b != btn) {
            b.selected = !b.selected;
            break;
        }
    }
    _page = 1;
    _orderType = btn.tag - 200 + 1;
    [_searchParam setObject:@(_orderType) forKey:@"orderType"];
    [self initializeDataSource];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    SearchViewController *vc = [[SearchViewController alloc] init];
    WeakObj(self)
    vc.searchResult = ^(NSString *searchKey) {
        weakself.page = 1;
        weakself.searchKey = searchKey;
        weakself.searchTF.text = searchKey;
        [weakself initializeDataSource];
    };
    vc.type = SearchTypeProjectProjress ;
    
    [self.navigationController pushViewController:vc animated:NO];
    
    return NO;
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
    // api/Project/GetProjectItemsPageList ----> 不含筛选字段
    // api/Project/GetProjectProcessItemsPageList ----> 包含筛选字段
    NSString *url = [NSString stringWithFormat:@"%@api/Project/GetProjectItemsPageList",BASEURL];
    NSMutableDictionary *param = @{@"pageNo":@(_page),
                            @"pageSize":pageSize,
                            @"orderType":@(_orderType),
                            @"projectLandType":@(_projectLandType),
                            @"projectStatus":@(_projectStatus),
                            @"minAreaCovered":@"",
                            @"maxAreaCovered":@"",
                            @"minTotalInvestment":@"",
                            @"maxTotalInvestment":@"",
                            @"searchKey":_searchKey,
                            }.mutableCopy;
    
    if (_searchParam) {
        [param addEntriesFromDictionary:_searchParam];
    }
    
    WeakObj(self)
    
    [NetManager getWithURL:url params:param animation:YES success:^(id obj) {
        if (_page <= 1) {
            [weakself.dataArray removeAllObjects];
        }
        
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        
        weakself.page ++ ;
        if ([obj isKindOfClass:[NSDictionary class]]) {
            if ([obj[@"Lists"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = obj[@"Lists"];
                for (NSDictionary *d in obj[@"Lists"]) {
                    PorjectProcessListModel *model = [[PorjectProcessListModel alloc] initWithDictionary:d];
                    [weakself.dataArray addObject:model];
                }
                
                if (arr.count < 20) {
                    weakself.tableView.mj_footer.hidden = YES;
                } else {
                    weakself.tableView.mj_footer.hidden = NO;
                }
            }
        }
        
        if (weakself.dataArray.count == 0) {
            [weakself showPromitLabel:YES];
        } else {
            [weakself showPromitLabel:NO];
        }
        
        [weakself.tableView reloadData];
    } failure:^(NSError *error) {
        if (_page <= 1) {
            [weakself.dataArray removeAllObjects];
        }
        [weakself.tableView reloadData];
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PorjectProcessListModel *model = self.dataArray[indexPath.row];
    ProjectDetailViewController *vc = [[ProjectDetailViewController alloc] init];
    vc.ProjectName = model.ProjectName;
    vc.ProjectID = model.ProjectID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    ProjectProcessListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ProjectProcessListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    PorjectProcessListModel *model = self.dataArray[indexPath.row];
    [cell setCellValueWithModel:model];
    
    return cell;
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
