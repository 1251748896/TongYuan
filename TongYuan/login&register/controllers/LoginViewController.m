//
//  LoginViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImgv;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *nameIconImgv;
@property (weak, nonatomic) IBOutlet UIImageView *pswIconImgv;
@property (weak, nonatomic) IBOutlet UIImageView *logoImgv;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *EnglishNameLabel;

@end

@implementation LoginViewController
- (instancetype)initWith:(void (^)(BOOL))dismiss
{
    self = [super init];
    if (self) {
        _dismiss = dismiss;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
    CGFloat logoTop = 120.0/667.0 * SCREENH_HEIGHT ;
    [self.logoImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(logoTop);
    }];
    
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImgv.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.EnglishNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.companyLabel.mas_bottom).offset(3);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.companyLabel.mas_width);
    }];
    
    CGFloat iconWidth = 40.0;
    [self.nameIconImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(self.companyLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(iconWidth);
        make.height.mas_equalTo(iconWidth);
    }];
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameIconImgv.mas_right).offset(5);
        make.centerY.equalTo(self.nameIconImgv.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(self.nameIconImgv.mas_height);
    }];
    
    [self.pswIconImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameIconImgv.mas_left);
        make.top.equalTo(self.nameIconImgv.mas_bottom).offset(5);
        make.width.equalTo(self.nameIconImgv.mas_width);
        make.height.equalTo(self.nameIconImgv.mas_height);
    }];
    [self.pswTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameTF.mas_left);
        make.centerY.equalTo(self.pswIconImgv.mas_centerY);
        make.right.equalTo(self.nameTF.mas_right);
        make.height.equalTo(self.nameTF.mas_height);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(self.pswTF.mas_bottom).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(49.0);
    }];
}

- (IBAction)loginBtnClick:(id)sender {
    
    NSString *token = @"qwertyuiop123";
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:USERTOKENKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [Tool tool].isLogin = YES;
    [Tool tool].token = token;
    [self dismissViewControllerAnimated:YES completion:^{
        if (_dismiss) {
            _dismiss(YES);
        }
    }];
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
