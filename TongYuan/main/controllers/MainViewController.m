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
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,ButtonTableCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) CircleBannerView *bannerView;

@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) NSMutableArray *imageArray;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArray = [NSMutableArray arrayWithCapacity:10];
    _imageArray = [NSMutableArray arrayWithCapacity:5];
    self.navigationController.navigationBarHidden = YES;
    CGFloat bannerH = 200.0/375.0 * SCREEN_WIDTH;
    _bannerView = [[CircleBannerView alloc] init];
    _bannerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, bannerH);
    _bannerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = _bannerView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    NSString *userToken = [defau objectForKey:USERTOKENKEY];
    if (userToken && userToken.length) {
        [Tool tool].isLogin = YES;
        [Tool tool].token = userToken;
        
        [self initializeDataSource];
        [self initializeUserInterface];
        
    } else {
        [self showLogin];
    }
}

- (void)initializeDataSource {
    
    
    [_imageArray addObject:@"http://pic4.nipic.com/20091217/3885730_124701000519_2.jpg"];
    [_imageArray addObject:@"http://pic.58pic.com/58pic/13/74/51/99d58PIC6vm_1024.jpg"];
    [_imageArray addObject:@"http://img07.tooopen.com/images/20170316/tooopen_sy_201956178977.jpg"];
    [_imageArray addObject:@"http://down1.sucaitianxia.com/psd02/psd169/psds32264.jpg"];
    
    _bannerView.imageArray = _imageArray;
  
    [self.dataArray addObject:@{@"img":@"http://pic4.nipic.com/20091217/3885730_124701000519_2.jpg",@"content":@"二手房二等分地方v感觉到发送v第三方v重新v发GV老地方据水电费v了生理功能开发的是管理开始的发V领但是发了个地方酸辣粉绿色的率水电费格拉苏蒂法律是曹改了发不发告诉对方V领的历史广播电视发",@"time":@"时间：2017-12-08",@"readCount":@"阅读次数：6"}];
    [self.dataArray addObject:@{@"img":@"http://pic4.nipic.com/20091217/3885730_124701000519_2.jpg",@"content":@"二手房二等分地方v感觉到发送v第三方v重新v发GV老地方据水电费v了生",@"time":@"时间：2017-12-08",@"readCount":@"阅读次数：7"}];
    [self.dataArray addObject:@{@"img":@"http://pic4.nipic.com/20091217/3885730_124701000519_2.jpg",@"content":@"二手房二等分地方v感觉到发送v第三方v重新v发GV老地方据水电费v了生理功能开发的是管理开始的发V领但是发了个地方酸辣粉绿色的率水电费格拉苏蒂法律是曹改了发不发告诉对方V领的历史广播电视发二手房二等分地方v感觉到发送v第三方v重新v发GV老地方据水电费v了生理功能开发的是管理开始的发V领但是发了个地方酸辣粉绿色的率水电费格拉苏蒂法律是曹改了发不发告诉对方V领的历史广播电视发",@"time":@"时间：2017-12-08",@"readCount":@"阅读次数：8"}];
    [self.dataArray addObject:@{@"img":@"http://pic4.nipic.com/20091217/3885730_124701000519_2.jpg",@"content":@"二手房二",@"time":@"时间：2017-12-08",@"readCount":@"阅读次数：1000"}];
    
    [self.tableView reloadData];
}

- (void)initializeUserInterface {
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 510.0/2.0 + 25;
    }
    //计算高度
    
    NSDictionary *d = self.dataArray[indexPath.row];
    NSString *str = d[@"content"];
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
    NSDictionary *d = self.dataArray[indexPath.row];
    NSString *imgUrl = d[@"img"];
    NSString *str = d[@"content"];
    NSString *time = d[@"time"];
    NSString *readCount = d[@"readCount"];
    [cell_yq.imgv sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"plisholder_main_banner"]];
    cell_yq.contentlabel.text = str ;
    cell_yq.timeLabel.text = time;
    cell_yq.readCountLabel.text = readCount;
    return cell_yq;
}

- (void)mainClickIndex:(NSInteger)btnIndx {
    
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
