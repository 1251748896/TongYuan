//
//  YQDynamicController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/13.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "YQDynamicController.h"
#import "MainModel.h"
#import "YQDynamicCell.h"
@interface YQDynamicController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation YQDynamicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"园区动态";
    _currentPage = 1;
    [self initializeDataSource];
    [self initializeUserInterface];
}


- (void)initializeDataSource {
    WeakObj(self)
    StrongObj(weakself)
    //list
    NSString *url_news = [NSString stringWithFormat:@"%@api/New/List",BASEURL];
    NSDictionary *newsParam = @{@"pageNo":@(_currentPage),
                                @"pageSize":pageSize,
                                @"searchKey":@""
                                };
    [NetManager getWithURL:url_news params:newsParam animation:YES success:^(id obj) {
        
        [strongweakself.tableView.mj_header endRefreshing];
        [strongweakself.tableView.mj_footer endRefreshing];
        if (_currentPage <= 1) {
            [weakself.dataArray removeAllObjects];
        }
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            if ([obj[@"Lists"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *d in obj[@"Lists"]) {
                    MainModel *model = [[MainModel alloc] initWithDictionary:d];
                    [strongweakself.dataArray addObject:model];
                }
            }
            if (obj[@"TotalCount"] != nil && ![obj[@"TotalCount"] isKindOfClass:[NSNull class]]) {
                NSInteger maxPage = [obj[@"TotalCount"] integerValue];
                if (maxPage == weakself.dataArray.count) {
//                    weakself.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                    strongweakself.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                } else {
                    weakself.currentPage ++ ;
                }
            }
        }
        
        [strongweakself.tableView reloadData];
    } failure:^(NSError *error) {
        [strongweakself.tableView.mj_header endRefreshing];
        [strongweakself.tableView.mj_footer endRefreshing];
        if (_currentPage <= 1) {
            [weakself.dataArray removeAllObjects];
        }
        [strongweakself.tableView reloadData];
    }];
}


- (void)initializeUserInterface {
    
    WeakObj(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.currentPage = 1;
        [weakself initializeDataSource];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself initializeDataSource];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //计算高度
    MainModel *model = self.dataArray[indexPath.row];
    NSString *str = model.title;
    CGRect rt = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    CGFloat top = 10.0; CGFloat bian = 12.0;
    CGFloat imgvH = (375.0/2.0/355.0) * (SCREEN_WIDTH-2*bian);
    CGFloat jiange = 10.0;
    
    CGFloat bottomH = 35.0;
    
    return top + imgvH + jiange + rt.size.height + bottomH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *yqCellIdtfer = @"yqcell";
    YQDynamicCell *cell_yq = [tableView dequeueReusableCellWithIdentifier:yqCellIdtfer];
    if (cell_yq == nil) {
        cell_yq = [[YQDynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:yqCellIdtfer];
    }
    MainModel *model = self.dataArray[indexPath.row];
    NSString *imgUrl = [NSString stringWithFormat:@"%@",model.img_url];
    NSString *str = model.title;
    NSString *time = model.update_time;
    NSString *readCount = [NSString stringWithFormat:@"阅读次数：%@",model.click];
    [cell_yq.imgv sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[Tool getBigPlaceholderImage]];
    cell_yq.contentlabel.text = str ;
    cell_yq.timeLabel.text = time ;
    cell_yq.readCountLabel.text = readCount ;
    return cell_yq;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MainModel *model = self.dataArray[indexPath.row];
    NSString *webUrl = [NSString stringWithFormat:@"%@News/Index/%@",BASEURL,model.article_id];
    WebViewController *vc = [[WebViewController alloc] initWithUrl:webUrl];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
