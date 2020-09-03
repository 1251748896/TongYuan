//
//  ProjectUseLandListController.m
//  TongYuan
//
//  Created by apple on 2017/12/8.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "ProjectUseLandListController.h"
#import "ProjectUseLandListCell.h"
@interface ProjectUseLandListController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topBg;
@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic) UITextField *searchTF;
@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic, copy) NSString *lastSearchKey ;
@end

@implementation ProjectUseLandListController

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    SearchViewController *vc = [[SearchViewController alloc] init];
    WeakObj(self)
    vc.searchResult = ^(NSString *searchKey) {
        weakself.page = 1;
        weakself.searchKey = searchKey;
        weakself.searchTF.text = searchKey;
        [weakself getData];
    };
    
    if (_projectUseLand) {
        
        vc.type = SearchTypeLandName;
    } else {
        
        vc.type = SearchTypeSpaceLand;
    }
    
    [self.navigationController pushViewController:vc animated:NO];
    
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"项目用地";
    _page = 1;
    _dataArray = [NSMutableArray arrayWithCapacity:20];
    if (_searchKey == nil) {
        _searchKey = @"";
    }
    if (_lastSearchKey == nil) {
        _lastSearchKey = @"";
    }
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
    if (_projectUseLand) {
        _searchTF.placeholder = SearchTFPlaceholderTextLandName;
    } else {
        _searchTF.placeholder = SearchTFPlaceholderTextSpaceLand;
    }
    _searchTF.font = [UIFont systemFontOfSize:13];
    _searchTF.rightView = imgv_icon;
    _searchTF.rightViewMode = UITextFieldViewModeAlways ;
    [self.topBg addSubview:_searchTF];
    
    
    self.topBg.backgroundColor = [Tool gayBgColor];
    _dataArray = [NSMutableArray arrayWithCapacity:20];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    WeakObj(self)
    //1.上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself getData];
    }];
    // 2.下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 1;
        [weakself getData];
    }];
    [self getData];
}

- (void)getData {
    WeakObj(self)
    NSString *url = nil;
    
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
    
    NSDictionary *d = @{@"pageNo":@(_page),@"pageSize":pageSize,@"searchKey":_searchKey};
    
//    NSString *paraString = [NSString stringWithFormat:@"?pageNo=%zd&pageSize=%@&searchKey=%@",_page,pageSize,_searchKey];
    
    if (_projectUseLand) {
        url = [NSString stringWithFormat:@"%@api/land/ProjectLand",BASEURL];
    } else {
        url = [NSString stringWithFormat:@"%@api/land/SpaceLand",BASEURL];
    }
    
//    url = [NSString stringWithFormat:@"%@%@",url,paraString];
    
    [NetManager getWithURL:url params:d animation:YES success:^(id obj) {
        if ([obj[@"Lists"] isKindOfClass:[NSArray class]]) {
            
            if (weakself.page <= 1) {
                [weakself.dataArray removeAllObjects];
            }
            [weakself.tableView.mj_header endRefreshing];
            [weakself.tableView.mj_footer endRefreshing];
            weakself.page ++ ;
            NSArray *listArr = obj[@"Lists"];
            for (NSDictionary *d in listArr) {
                ProjectUseLandListModel *m = [[ProjectUseLandListModel alloc] initWithDictionary:d];
                [weakself.dataArray addObject:m];
            }
            
            if (listArr.count < 20) {
                weakself.tableView.mj_footer.hidden = YES;
            } else {
                weakself.tableView.mj_footer.hidden = NO;
            }
            
            [weakself.tableView reloadData];
        }
    } failure:^(NSError *error) {
        if (weakself.page <= 1) {
            [weakself.dataArray removeAllObjects];
            [weakself.tableView reloadData];
        }
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellItfer = @"cell";
    ProjectUseLandListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellItfer];
    if (cell == nil) {
        cell = [[ProjectUseLandListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellItfer];
    }
    ProjectUseLandListModel *m = self.dataArray[indexPath.row];
    [cell setCellValueWithModel:m type:_projectUseLand] ;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProjectUseLandListModel *mod = self.dataArray[indexPath.row];
    
    NSString *hStr = nil;
    NSString *webId = nil;
    if (_projectUseLand) {
        hStr = @"lands/PJDetail/";
        webId = mod.PBID;
    } else {
        hStr = @"lands/SLDetail/";
        webId = mod.Space_Land_ID;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BASEURL,hStr,webId];
    WebViewController *vc = [[WebViewController alloc] initWithUrl:url];
    [self.navigationController pushViewController:vc animated:YES];
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
