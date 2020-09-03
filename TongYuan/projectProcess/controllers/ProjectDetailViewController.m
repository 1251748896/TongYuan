//
//  ProjectDetailViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/17.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "ProjectDetailViewController.h"
#import "MediumListViewController.h"

@interface ProjectDetailViewController ()<UIWebViewDelegate>

@property (nonatomic) UILabel *titlelabel;
@property (nonatomic) UIWebView *webView ;

@end

@implementation ProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"项目详情";
    
    self.view.backgroundColor = [Tool gayBgColor];
    
    
    _titlelabel = [[UILabel alloc] init];
    _titlelabel.textColor = UIColorFromRGB(0x333333);
    _titlelabel.font = [UIFont systemFontOfSize:18];
    _titlelabel.numberOfLines = 0;
    _titlelabel.text = _ProjectName;
    _titlelabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titlelabel];
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-20);
    }];
    
    UIView *lin = [[UIView alloc] init];
    lin.backgroundColor = [Tool gayLineColor];
    [self.view addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(1.0);
        make.top.equalTo(_titlelabel.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left);
    }];
    
    UILabel *processLable = [[UILabel alloc] init];
    processLable.text = @"项目形象进度";
    processLable.textColor = UIColorFromRGB(0x333333);
    processLable.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:processLable];
    [processLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(lin.mas_bottom).offset(10);
    }];
    
    CGFloat btnW = (SCREEN_WIDTH-40*2 - 20) / 2.0;
    CGFloat btnH = 44;
//    UIButton *centerBtn = nil;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(processLable.mas_bottom).offset(10);
        make.height.mas_equalTo(btnH+26);
        make.width.mas_equalTo(SCREEN_WIDTH-20);
    }];
    
    NSArray *arr = @[@"项目图片",@"项目小视频"];
    for (int i=0; i<arr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.borderColor = [Tool blueColor].CGColor;
        button.layer.borderWidth = 1.0;
        [button setBackgroundImage:[Tool imageWithColor:[Tool gayBgColor]] forState:UIControlStateHighlighted];
        button.tag = 10 + i;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[Tool blueColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 3.0; button.clipsToBounds = YES;
        [view addSubview:button];
        if (i == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(view.mas_top).offset(13);
                make.right.equalTo(self.view.mas_centerX).offset(-5);
                make.height.mas_equalTo(btnH);
                make.width.mas_equalTo(btnW);
            }];
            
        } else if (i == 1) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(view.mas_top).offset(13);
                make.left.equalTo(self.view.mas_centerX).offset(5);
                make.height.mas_equalTo(btnH);
                make.width.mas_equalTo(btnW);
            }];
        }
    }
    
    _webView = [[UIWebView alloc] init];
    _webView.backgroundColor = [Tool gayBgColor];
    _webView.delegate = self;
    
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(view.mas_bottom).offset(10);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    NSString *url = [NSString stringWithFormat:@"%@Projects/ProjectInfomation?userCookie=%@&id=%@",BASEURL,[Tool getUserCookie],_ProjectID];
    NSLog(@"url = %@",url);
    NSURL *URLLL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URLLL];
    [_webView loadRequest:request];
}

- (void)buttonClick:(UIButton *)button {
    
    MediumListViewController *vc = [[MediumListViewController alloc] init];
    vc.ProjectID = self.ProjectID;
    vc.isImage = button.tag == 10 ;
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
