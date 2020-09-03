//
//  MainViewController.m
//  TongYuan
//
//  Created by apple on 2017/12/7.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "CircleBannerView.h"
#import "ButtonTableCell.h"
#import "YQDynamicCell.h"
#import "MainModel.h"

#import "YQLandStateViewController.h"
#import "PorjectProcessController.h"
#import "YQDataViewController.h"
#import "WebViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,ButtonTableCellDelegate,CircleBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) CircleBannerView *bannerView;
@property (nonatomic) NSArray *bannerModels;
@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) NSMutableArray *imageArray;
@end

@implementation MainViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    _dataArray = [NSMutableArray arrayWithCapacity:20];
    _imageArray = [NSMutableArray arrayWithCapacity:5];
    _bannerModels = [NSArray array];
    self.navigationController.navigationBarHidden = YES;
    CGFloat bannerH = 200.0/375.0 * SCREEN_WIDTH;
    _bannerView = [[CircleBannerView alloc] init];
    _bannerView.banneDdelegate = self;
    _bannerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, bannerH);
    _bannerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = _bannerView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    NSString *userToken = [Tool getToken];
    if (userToken && userToken.length) {
        [Tool tool].isLogin = YES;
        [Tool tool].token = userToken;
        
        [self initializeDataSource];
        [self initializeUserInterface];
        
    } else {
        [self showLogin];
    }
}

- (void)mainBannerClickIndex:(NSInteger)btnIndx indx:(NSInteger)indxxx {
    
    MainModel *mod = self.bannerModels[indxxx];
    NSString *url = [NSString stringWithFormat:@"%@News/About/%@",BASEURL,mod.article_id];
    
    WebViewController *vc = [[WebViewController alloc] initWithUrl:url];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initializeDataSource {
    
    WeakObj(self)
    StrongObj(weakself)
    // banner
    NSString *url = [NSString stringWithFormat:@"%@api/New/about",BASEURL];
    NSDictionary *param = @{@"number":@"4"};
    [NetManager getWithURL:url params:param animation:YES success:^(id obj) {
        if ([obj[@"Lists"] isKindOfClass:[NSArray class]]) {
            NSMutableArray *tem = [NSMutableArray arrayWithCapacity:4];
            for (NSDictionary *d in obj[@"Lists"]) {
                MainModel *model = [[MainModel alloc] initWithDictionary:d];
                if (model) {
                    [tem addObject:model];
                }
            }
            strongweakself.bannerModels = tem;
            NSMutableArray *urls = [NSMutableArray arrayWithCapacity:5];
            NSMutableArray *tits = [NSMutableArray arrayWithCapacity:5];
            for (MainModel *m in tem) {
                [urls addObject:m.img_url];
                [tits addObject:m.title];
            }
            strongweakself.bannerView.titleArr = tits;
            strongweakself.bannerView.imageArray = urls;
        }
    } failure:^(NSError *error) {
        
    }];
    
    //list
    NSString *url_news = [NSString stringWithFormat:@"%@api/New/HomeNewest",BASEURL];
    NSDictionary *newsParam = @{@"number":@"2"};
    [NetManager getWithURL:url_news params:newsParam animation:YES success:^(id obj) {
        for (NSDictionary *d in obj[@"Lists"]) {
            MainModel *model = [[MainModel alloc] initWithDictionary:d];
            if (model) {
                [strongweakself.dataArray addObject:model];
            }
        }
        [strongweakself.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)initializeUserInterface {
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 250.0 + 25;
    }
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *btnCellIdtfer = @"btncell";
        ButtonTableCell *btnCell = [tableView dequeueReusableCellWithIdentifier:btnCellIdtfer];
        if (btnCell == nil) {
            btnCell = [[ButtonTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:btnCellIdtfer];
        }
        btnCell.delegate = self;
        return btnCell;
    }
    
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
    [cell_yq.imgv sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"plisholder_main_banner"]];
    cell_yq.contentlabel.text = str ;
    cell_yq.timeLabel.text = time ;
    cell_yq.readCountLabel.text = readCount ;
    return cell_yq;
}

- (void)mainClickIndex:(NSInteger)btnIndx {
    
    /*
     0:园区土地, 1:项目进度, 2:园区生产经营数据
     3:园区企业, 4:企业生产经营数据, 5:企业产业分类税值分析, 6:企业产品
     7:更多园区动态
     */
    UIViewController *vc = nil;
    
    if (btnIndx == 0) {
        vc = [[YQLandStateViewController alloc] init];
    } else if (btnIndx == 1) {
        vc = [[PorjectProcessController alloc] init];
    } else if (btnIndx == 2) {
        vc = [[YQDataViewController alloc] init];
    } else if (btnIndx == 3) {
//        vc = [[GovernmentViewController alloc] init];
    } else if (btnIndx == 4) {
        vc = [[EnterpriseDataListController alloc] init];
    } else if (btnIndx == 5) {
        vc = [[GovZZRevenueAnalyseController alloc] init];
    } else if (btnIndx == 6) {
        vc = [[ProductViewController alloc] init];
    } else if (btnIndx == 7) {
        vc = [[YQDynamicController alloc] init];
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [Tool tool].rootVC.selectedIndex = 2;
    }
 
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MainModel *model = self.dataArray[indexPath.row];
    NSString *url = [NSString stringWithFormat:@"%@News/Index/%@",BASEURL,model.article_id];
    WebViewController *vc = [[WebViewController alloc] initWithUrl:url];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showLogin {
    WeakObj(self)
    [self presentViewController:[[LoginViewController alloc] initWith:^(BOOL succeed) {
        [weakself initializeDataSource];
    }] animated:YES completion:nil];
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
