//
//  LoginViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic) UIButton *savePswBtn;

@property (weak, nonatomic) IBOutlet UIImageView *bgImgv;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *nameIconImgv;
@property (weak, nonatomic) IBOutlet UIImageView *pswIconImgv;
@property (weak, nonatomic) IBOutlet UIImageView *logoImgv;
@property (weak, nonatomic) IBOutlet UIImageView *companyNameImgv;

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
    [self.view sendSubviewToBack:self.bgImgv];
    CGFloat logoTop = 120.0/667.0 * SCREENH_HEIGHT ;
    [self.logoImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(logoTop);
    }];
    /*
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImgv.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    self.companyLabel.textColor = [Tool blueColor];
    [self.EnglishNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.companyLabel.mas_bottom).offset(3);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.companyLabel.mas_width);
    }];
    self.EnglishNameLabel.textColor = self.companyLabel.textColor;
    */
    [self.companyNameImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImgv.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH*0.8);
        make.height.mas_equalTo(40);
    }];
    
    CGFloat iconWidth = 50.0;
    [self.nameIconImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(iconWidth);
        make.height.mas_equalTo(iconWidth);
    }];
    self.nameIconImgv.contentMode = UIViewContentModeCenter;
    self.nameIconImgv.backgroundColor = UIColorFromRGB(0x5187b4);
    
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameIconImgv.mas_right).offset(0);
        make.centerY.equalTo(self.nameIconImgv.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(self.nameIconImgv.mas_height);
    }];
    self.nameTF.leftViewMode = UITextFieldViewModeAlways;
    self.nameTF.backgroundColor = [UIColorFromRGB(0x3079ae) colorWithAlphaComponent:0.5];
    self.nameTF.textColor = UIColorFromRGB(0x92acc8);
    self.nameTF.keyboardType = UIKeyboardTypeDefault;
    self.nameTF.text = [Tool getIphoneNum];
    
    [self.pswIconImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameIconImgv.mas_left);
        make.top.equalTo(self.nameIconImgv.mas_bottom).offset(1.0);
        make.width.equalTo(self.nameIconImgv.mas_width);
        make.height.equalTo(self.nameIconImgv.mas_height);
    }];
    self.pswIconImgv.contentMode = UIViewContentModeCenter;
    self.pswIconImgv.backgroundColor = self.nameIconImgv.backgroundColor;
    
    [self.pswTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameTF.mas_left);
        make.centerY.equalTo(self.pswIconImgv.mas_centerY);
        make.right.equalTo(self.nameTF.mas_right);
        make.height.equalTo(self.nameTF.mas_height);
    }];
    self.pswTF.leftViewMode = self.nameTF.leftViewMode;
    self.pswTF.textColor = self.nameTF.textColor;
    self.pswTF.backgroundColor = self.nameTF.backgroundColor;
    self.pswTF.secureTextEntry = YES;
    self.pswTF.text = [Tool getPasswd];
    
    for (int i=0; i<2; i++) {
        UIView *pl = [[UIView alloc] init];
        pl.backgroundColor = [UIColor clearColor];
        pl.bounds = CGRectMake(0, 0, 15, iconWidth);
        if (i == 0) {
            _nameTF.leftView = pl;
        } else {
            _pswTF.leftView = pl;
        }
    }
    
    [self.savePswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pswTF.mas_left);
        make.top.equalTo(_pswTF.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    
    NSString *localPasswd = [[NSUserDefaults standardUserDefaults] objectForKey:USERPASSWORD];
    if ([localPasswd isKindOfClass:[NSString class]]) {
        if (localPasswd.length > 0) {
            self.savePswBtn.selected = YES;
        }
    }
    
    [self.savePswBtn setImage:[UIImage imageNamed:@"circle_big.png"] forState:UIControlStateNormal];
    [self.savePswBtn setImage:[UIImage imageNamed:@"throwWay.png"] forState:UIControlStateSelected];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(self.savePswBtn.mas_bottom).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(49.0);
    }];
    _loginBtn.layer.cornerRadius = 10.0;
    _loginBtn.layer.masksToBounds = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)loginBtnClick:(id)sender {
    NSString *url = [NSString stringWithFormat:@"%@/Auth/Token",BASEURL];
    
    if (_nameTF.text.length == 0 || _pswTF.text.length == 0) {
        return;
    }
    NSDictionary *param = @{@"grant_type":@"password",@"username":_nameTF.text,@"password":_pswTF.text};
    WeakObj(self)
    [NetManager postWithURL:url params:param animation:YES success:^(id obj) {
        
        [weakself saveUserInfo:obj];
        [Tool tool].rootVC.selectedIndex = 0;
        [weakself dismissViewControllerAnimated:YES completion:^{
            if (_dismiss) {
                _dismiss(YES);
            }
        }];
        
    } failure:^(NSError *error) {
        UIAlertView *aletView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"登录失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [aletView show];
    }];
}

- (void)savePasswd {
    _savePswBtn.selected = !_savePswBtn.selected;
}

- (void)saveUserInfo:(id)onfo {
    
    if ([onfo isKindOfClass:[NSDictionary class]] == NO) {
        return;
    }
    
    NSDictionary *d = (NSDictionary *)onfo;
    NSString *access_token = d[@"access_token"];
    NSString *iphoneNum = _nameTF.text;
    NSString *userPasswd = _pswTF.text ;
    NSString *userCookie = [NSString stringWithFormat:@"%@",d[@"cookie"]];
    
    [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:USERTOKENKEY];
    [[NSUserDefaults standardUserDefaults] setObject:iphoneNum forKey:USERIPHONENUMBER];
    if (_savePswBtn.selected == YES) {
        [[NSUserDefaults standardUserDefaults] setObject:userPasswd forKey:USERPASSWORD];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERPASSWORD];
    }
    [[NSUserDefaults standardUserDefaults] setObject:userCookie forKey:USERCOOKIE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [Tool tool].isLogin = YES;
    [Tool tool].token = access_token;
}

- (UIButton *)savePswBtn {
    if (!_savePswBtn) {
        _savePswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_savePswBtn setTitle:@"   记住密码" forState:UIControlStateNormal];
        [_savePswBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _savePswBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_savePswBtn addTarget:self action:@selector(savePasswd) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_savePswBtn];
    }
    return _savePswBtn;
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
