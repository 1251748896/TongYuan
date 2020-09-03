//
//  ChangePswController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/11.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "ChangePswController.h"

@interface ChangePswController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UILabel *chanLabel;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UILabel *oldPswLabel;
@property (weak, nonatomic) IBOutlet UITextField *oldPswTF;
@property (weak, nonatomic) IBOutlet UILabel *newpswLabel;
@property (weak, nonatomic) IBOutlet UITextField *newpswTF;
@property (weak, nonatomic) IBOutlet UITextField *newpswTF_2;
@property (weak, nonatomic) IBOutlet UILabel *promitLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation ChangePswController

- (IBAction)submitBtnClick:(id)sender {
    if (_oldPswTF.text == nil || _oldPswTF.text.length == 0) {
        [UIAlertView showAlertViewWithMessage:@"请输入旧密码"];
        return;
    }
    if (_newpswTF.text == nil || _newpswTF.text.length == 0) {
        [UIAlertView showAlertViewWithMessage:@"请输入新密码"];
        return;
    }
    if (_newpswTF_2.text == nil || _newpswTF_2.text.length == 0) {
        [UIAlertView showAlertViewWithMessage:@"请确认新密码"];
        return;
    }
    
    if ([_newpswTF_2.text isEqualToString:_newpswTF.text] == NO) {
        [UIAlertView showAlertViewWithMessage:@"两次密码输入不一致"];
        return;
    }
    WeakObj(self)
    NSString *url = [NSString stringWithFormat:@"%@api/Secrity/UpdatePassWord",BASEURL];
    NSDictionary *param = @{@"OldPassword":_oldPswTF.text,
                            @"NewPassword":_newpswTF.text};
    [NetManager postWithURL:url params:param animation:YES success:^(id obj) {
        NSLog(@"修改密码的回调:%@",obj);
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            
            if ([obj[@"IsSuccessed"] boolValue]) {
                [Tool startAnimationWithMessage:@"修改成功" showTime:2.0 onView:weakself.view];
                [weakself refreshToken:obj];
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)refreshToken:(NSDictionary *)onfo {
    NSString *url = [NSString stringWithFormat:@"%@/Auth/Token",BASEURL];
    NSDictionary *param = @{@"grant_type":@"password",@"username":[Tool getIphoneNum],@"password":_newpswTF.text};
    WeakObj(self)
    //login
    [NetManager postWithURL:url params:param animation:YES success:^(id obj) {
        [weakself saveUserInfo:obj];
    } failure:^(NSError *error) {
        UIAlertView *aletView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"刷新失败，请重新登录" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [aletView show];
    }];
}

- (void)saveUserInfo:(id)onfo {
    
    if ([onfo isKindOfClass:[NSDictionary class]] == NO) {
        return;
    }
    
    NSDictionary *d = (NSDictionary *)onfo;
    NSString *access_token = d[@"access_token"];
    NSString *userCookie = [NSString stringWithFormat:@"%@",d[@"cookie"]];
    
    [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:USERTOKENKEY];
    [[NSUserDefaults standardUserDefaults] setObject:userCookie forKey:USERCOOKIE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [Tool tool].isLogin = YES;
    [Tool tool].token = access_token;
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"修改密码";
    
    [self setViewFrame];
    
    [self setViewProperties];
    
    [self setTFrightImage];
}

- (void)setViewFrame {
    CGFloat left = 15.0;
    CGFloat topH = 44.0;
    _scroll.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.view.bounds));
    CGFloat chanLabelH = 25.0;
    _chanLabel.frame = CGRectMake(left, topH/2.0 - chanLabelH/2.0, 100, chanLabelH);
    CGFloat linH = 1.0;
    _line.frame = CGRectMake(0, topH-linH, SCREEN_WIDTH, linH);
    _oldPswLabel.frame = CGRectMake(left, CGRectGetMaxY(_line.frame)+16, 100, 20);
    CGFloat tfWidth = SCREEN_WIDTH-left*2;
    CGFloat tfHeight = 36;
    _oldPswTF.frame = CGRectMake(left, CGRectGetMaxY(_oldPswLabel.frame)+5, tfWidth, tfHeight);
    _newpswLabel.frame = CGRectMake(left, CGRectGetMaxY(_oldPswTF.frame)+16, 100, 20);
    _newpswTF.frame = CGRectMake(left, CGRectGetMaxY(_newpswLabel.frame)+5, tfWidth, tfHeight);
    _newpswTF_2.frame = CGRectMake(left, CGRectGetMaxY(_newpswTF.frame)+11, tfWidth, tfHeight);
    _promitLabel.frame = CGRectMake(left, CGRectGetMaxY(_newpswTF_2.frame)+11, tfWidth, 17);
    CGFloat bottomBtnH = 40.0;
    _submitBtn.frame = CGRectMake(left, CGRectGetMaxY(_promitLabel.frame)+30, tfWidth, bottomBtnH);
}

- (void)setViewProperties {
    _scroll.backgroundColor = [Tool gayBgColor];
    _line.backgroundColor = [Tool gayLineColor];
    
    
    CGFloat cor = 3.0;
    
//    CGFloat linH = 1.0;
//    _oldPswTF.layer.borderWidth = linH;
    _oldPswTF.backgroundColor = [UIColor whiteColor];
    _oldPswTF.secureTextEntry = YES;
    _oldPswTF.layer.cornerRadius = cor;
    _oldPswTF.layer.masksToBounds = YES;
    
//    _oldPswTF.layer.borderColor = [Tool gayLineColor].CGColor;
//    _newpswTF.layer.borderWidth = linH;
//    _newpswTF.layer.borderColor = [Tool gayLineColor].CGColor;
//    _newpswTF_2.layer.borderWidth = linH;
//    _newpswTF_2.layer.borderColor = [Tool gayLineColor].CGColor;
    _newpswTF_2.backgroundColor = [UIColor whiteColor];
    _newpswTF_2.secureTextEntry = YES;
    _newpswTF_2.layer.cornerRadius = cor;
    _newpswTF_2.layer.masksToBounds = YES;
    
    
    _newpswTF.backgroundColor = [UIColor whiteColor];
    _newpswTF.secureTextEntry = YES;
    _newpswTF.layer.cornerRadius = cor;
    _newpswTF.layer.masksToBounds = YES;
    
    [_submitBtn setBackgroundImage:[Tool imageWithColor:[Tool blueColor]] forState:UIControlStateNormal];
    _submitBtn.layer.cornerRadius = 8.0;
    _submitBtn.layer.masksToBounds = YES;
}

- (void)setTFrightImage {
    
    _oldPswTF.rightView = [self getTFRightItem];
    _oldPswTF.rightViewMode = UITextFieldViewModeAlways;
    _oldPswTF.leftView = [self getTFLeftItem];
    _oldPswTF.leftViewMode = UITextFieldViewModeAlways;
    
    _newpswTF.rightView = [self getTFRightItem];
    _newpswTF.rightViewMode = UITextFieldViewModeAlways;
    _newpswTF.leftView = [self getTFLeftItem];
    _newpswTF.leftViewMode = UITextFieldViewModeAlways;
    
    _newpswTF_2.rightView = [self getTFRightItem];
    _newpswTF_2.rightViewMode = UITextFieldViewModeAlways;
    _newpswTF_2.leftView = [self getTFLeftItem];
    _newpswTF_2.leftViewMode = UITextFieldViewModeAlways;
}

- (UIView *)getTFLeftItem {
    UIView *leftItem = [[UIView alloc] init];
    leftItem.backgroundColor = [UIColor clearColor];
    leftItem.bounds = CGRectMake(0, 0, 10, 30);
    return leftItem;
}

- (UIButton *)getTFRightItem {
    
    static int xx = 10;
    UIButton * rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem addTarget:self action:@selector(showPswBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightItem.bounds = CGRectMake(0, 0, 30, 30);
    rightItem.tag = xx;
    [rightItem setImage:[self getShowPswImage] forState:UIControlStateSelected];
    [rightItem setImage:[self gethiddenPswImage] forState:UIControlStateNormal];
     xx ++ ;
    return rightItem;
}

- (UIImage *)getShowPswImage {
    UIImage *showPswImage = [UIImage imageNamed:@"home-my-account_eyes_current"];
    return showPswImage;
}
- (UIImage *)gethiddenPswImage {
    UIImage *hiddenPswImage = [UIImage imageNamed:@"home-my-account_eyes_acquiescence"];
    return hiddenPswImage;
}
- (void)showPswBtnClick:(UIButton *)button {
    button.selected = !button.selected;
    BOOL show = button.selected == NO;
    if (button.tag == 10) {
        _oldPswTF.secureTextEntry = show ;
    } else if (button.tag == 11) {
        _newpswTF.secureTextEntry = show ;
    } else if (button.tag == 12) {
        _newpswTF_2.secureTextEntry = show;
    }
    
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
