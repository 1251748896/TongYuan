//
//  EnterpriseDataListController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/15.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "EnterpriseDataListController.h"

@interface EnterpriseDataListController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic) UITextField *searchTF;
@property (nonatomic, copy) NSString *lastSearchKey ;
@end

@implementation EnterpriseDataListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"企业生产经营数据";
    if (_searchKey == nil) {
        _searchKey = @"";
    }
    if (_lastSearchKey == nil) {
        _lastSearchKey = @"";
    }
    _page = 1;
    [self initializeUserInterface];
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
    
    WeakObj(self)
    NSString *urrll = [NSString stringWithFormat:@"%@api/Tax/CompanyOutput",BASEURL];
    NSDictionary *parammm = @{@"pageNo":@(_page),@"pageSize":pageSize};
    NSLog(@"kklklk = %@",parammm);
    [NetManager getWithURL:urrll params:parammm animation:YES success:^(id obj) {
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        if (_page <= 1) {
            [weakself.dataArray removeAllObjects];
        }
        weakself.page ++ ;
        if ([obj[@"Lists"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *d in obj[@"Lists"]) {
                EnterpriseDataListModel *model = [[EnterpriseDataListModel alloc] initWithDictionary:d];
                [weakself.dataArray addObject:model];
            }
        }
        [weakself.tableView reloadData];
        
    } failure:^(NSError *error) {
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        if (_page <= 1) {
            [weakself.dataArray removeAllObjects];
        }
        [weakself.tableView reloadData];
    }];
    
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
    _searchTF.delegate = self;
    _searchTF.placeholder = SearchTFPlaceholderTextProductEngageData;
    _searchTF.font = [UIFont systemFontOfSize:13];
    _searchTF.rightView = imgv_icon;
    _searchTF.rightViewMode = UITextFieldViewModeAlways ;
    [self.view addSubview:_searchTF];
    
    
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    EnterpriseDataListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[EnterpriseDataListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    EnterpriseDataListModel *model = self.dataArray[indexPath.row];
    WeakObj(self)
    cell.enterpriseNameLabel.text = model.CompanyName;
    cell.modell = model;
    cell.buttonClickEvent = ^(NSInteger btnTag) {
        NSString *webUrl = @"";
        if (btnTag == 0) {
            webUrl = [NSString stringWithFormat:@"%@Taxs/CompanyOutput/%@",BASEURL,model.CompanyID];
        } else if (btnTag == 1) {
            webUrl = [NSString stringWithFormat:@"%@Taxs/CompanyTax/%@",BASEURL,model.CompanyID];
        }
        WebViewController *vc = [[WebViewController alloc] initWithUrl:webUrl];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    
    [self.navigationController pushViewController:vc animated:NO];
    
    return NO;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, (12+30+12), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64-(12+30+12)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 10 + 12+30+12+1+15+40;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [Tool gayBgColor];
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
