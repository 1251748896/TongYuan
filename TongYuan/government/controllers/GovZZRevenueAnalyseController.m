//
//  GovZZRevenueAnalyseController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/13.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "GovZZRevenueAnalyseController.h"

@interface GovZZRevenueAnalyseController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;

@end

@implementation GovZZRevenueAnalyseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"企业新经济类型税值分析";
    
    _dataArray = [NSMutableArray arrayWithCapacity:10];
    
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    WeakObj(self)
    NSString *url = [NSString stringWithFormat:@"%@api/Tax/CompanyType",BASEURL];
    [NetManager getWithURL:url params:nil animation:YES success:^(id obj) {
        [weakself.tableView.mj_header endRefreshing];
//        [weakself.tableView.mj_footer endRefreshing];
//        if (weakself.page <= 1) {
//            [weakself.dataArray removeAllObjects];
//        }
//        weakself.page ++ ;
        [weakself.dataArray removeAllObjects];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            if ([obj[@"Lists"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *d in obj[@"Lists"]) {
                    GovZZSModel *model = [[GovZZSModel alloc] initWithDictionary:d];
                    [weakself.dataArray addObject:model];
                }
                [weakself.tableView reloadData];
            }
        }
    } failure:^(NSError *error) {
//        if (weakself.page <= 1) {
//            [weakself.dataArray removeAllObjects];
//        }
//        [weakself.tableView.mj_header endRefreshing];
//        [weakself.tableView.mj_footer endRefreshing];
    }];
}


- (void)initializeUserInterface {
    
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    WeakObj(self)
    //1.上拉加载
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakself initializeDataSource];
//    }];
    // 2.下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        weakself.page = 1;
        [weakself initializeDataSource];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    ZZSListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZZSListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    GovZZSModel *model = self.dataArray[indexPath.row];
    UIColor *color = indexPath.row%2 == 0?[Tool gayBgColor]:[UIColor whiteColor];
    cell.contentView.backgroundColor = color;
    UIImage *plImage = [Tool getBigPlaceholderImage];
    NSURL *URLLL = [NSURL URLWithString:model.CompantTypeIcon];
    [cell.imgv sd_setImageWithURL:URLLL placeholderImage:plImage];
    cell.texLabel.text = model.CompanyTypeName;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44.0);
    view.backgroundColor = [UIColor whiteColor];
    UILabel *labe = [[UILabel alloc] init];
    labe.textColor =UIColorFromRGB(0x333333);
    labe.font = [UIFont systemFontOfSize:17];
    [view addSubview:labe];
    [labe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(10);
        make.centerY.equalTo(view.mas_centerY);
    }];
    
    labe.text = @"主导产业";
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GovZZSModel *model = self.dataArray[indexPath.row];
    NSString *url = [NSString stringWithFormat:@"%@Taxs/Tax/%@",BASEURL,model.CompanyTypeID];
    WebViewController *vc = [[WebViewController alloc] initWithUrl:url];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 80;
        _tableView.sectionHeaderHeight = 50;
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
