//
//  YQLandStateViewController.m
//  TongYuan
//
//  Created by apple on 2017/12/7.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "YQLandStateViewController.h"
#import "ProjectUseLandListController.h"
@interface YQLandStateViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *usingLandBtn;
@property (weak, nonatomic) IBOutlet UIButton *hollowLandBtn;
@property (weak, nonatomic) IBOutlet UIImageView *usingImgv;
@property (weak, nonatomic) IBOutlet UIImageView *hollowImgv;
@property (weak, nonatomic) IBOutlet UILabel *usingLabel;
@property (weak, nonatomic) IBOutlet UILabel *hollowLabel;

@end

@implementation YQLandStateViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [Tool gayBgColor];
    self.webView.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 230);
    
    NSString *url = [NSString stringWithFormat:@"%@lands/Index",BASEURL];
    NSURL *uurl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:uurl];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scrollView.bounces=NO;
    [self.webView loadRequest:request];
    
    CGFloat bianOffset = SCREEN_WIDTH/4.0;
    self.navigationItem.title = @"园区土地情况";

    [self.usingImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_left).offset(bianOffset);
        make.top.equalTo(self.webView.mas_bottom).offset(40);
    }];
    
    [self.hollowImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_right).offset(-bianOffset);
        make.centerY.equalTo(self.usingImgv.mas_centerY);
    }];
    
    [self.usingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.usingImgv.mas_centerX);
        make.top.equalTo(self.usingImgv.mas_bottom).offset(20);
    }];
    
    [self.hollowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hollowImgv.mas_centerX);
        make.centerY.equalTo(self.usingLabel.mas_centerY);
    }];
    
    CGFloat wd = 20;
    CGFloat btnB = 80;
    [self.usingLandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usingImgv.mas_top).offset(-wd);
        make.bottom.equalTo(self.usingLabel.mas_bottom).offset(wd);
        make.width.mas_equalTo(btnB);
        make.centerX.equalTo(self.usingImgv.mas_centerX);
    }];
    
    [self.usingLandBtn setBackgroundImage:[Tool imageWithColor:[Tool gayLineColor]] forState:UIControlStateHighlighted];
    [self.hollowLandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_right).offset(-bianOffset);
        make.centerY.equalTo(self.usingLandBtn.mas_centerY);
        make.width.equalTo(self.usingLandBtn.mas_width);
        make.height.equalTo(self.usingLandBtn.mas_height);
    }];
    [self.hollowLandBtn setBackgroundImage:[Tool imageWithColor:[Tool gayLineColor]] forState:UIControlStateHighlighted];
}
- (IBAction)usingLandBtnClick:(id)sender {
    ProjectUseLandListController *vc = [[ProjectUseLandListController alloc] init];
    vc.projectUseLand = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)hollowLandBtnClick:(id)sender {
    ProjectUseLandListController *vc = [[ProjectUseLandListController alloc] init];
    vc.projectUseLand = NO;
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
