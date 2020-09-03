//
//  UserCenterViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "UserCenterViewController.h"

#import "UserInfoModel.h"


@interface UserCenterViewController ()<UIAlertViewDelegate>

@property (nonatomic) UserInfoModel *modell;

@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *aliasNameLabel;

@property (nonatomic ,strong) UITextField *pswTF;
@property (nonatomic, strong) UITextField *iphoneNumTF;
@property (nonatomic) UILabel *iphoneLabel ;

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [Tool gayBgColor];
    self.navigationItem.title = @"我的账号";
    
    [self initializeDataSource];
    
    CGFloat topBgH = 80.0/375.0 * SCREEN_WIDTH ;
    UIView *topBg = [[UIView alloc] init];
    topBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, topBgH);
    topBg.backgroundColor = [Tool gayBgColor];
    [self.view addSubview:topBg];
    
    
    UIImage *logo_image = [UIImage imageNamed:@"logo_name_usercenter"];
    CGFloat imgW = logo_image.size.width ;
    CGFloat imgH = logo_image.size.height ;
    
    
    
    UIImageView *imgv_logo = [[UIImageView alloc] init];
    imgv_logo.image = logo_image ;
    [topBg addSubview:imgv_logo];
    [imgv_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(topBg.mas_centerY);
        make.width.mas_equalTo(imgW*0.75);
        make.height.mas_equalTo(imgH*0.75);
    }];
    
    
    UIView *userInfoBg = [[UIView alloc] init];
    userInfoBg.frame = CGRectMake(0, CGRectGetMaxY(topBg.frame), SCREEN_WIDTH, topBgH);
    userInfoBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:userInfoBg];
    UIImageView *imgv_user = [[UIImageView alloc] init];
    imgv_user.image = [UIImage imageNamed:@"home-my-account_headportrait"];
    [userInfoBg addSubview:imgv_user];
    [imgv_user mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.centerY.equalTo(userInfoBg.mas_centerY);
    }];
    
    UILabel *namelab = [[UILabel alloc] init];
    namelab.font = [UIFont systemFontOfSize:14];
    namelab.textColor = UIColorFromRGB(0x333333);
    namelab.text = @"用户名";
    [userInfoBg addSubview:namelab];
    [namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imgv_user.mas_centerY).offset(-2);
        make.left.equalTo(imgv_user.mas_right).offset(10);
    }];
    _nameLabel = namelab;
    
    UILabel *aliasNameLab = [[UILabel alloc] init];
    aliasNameLab.font = [UIFont systemFontOfSize:10];
    aliasNameLab.textColor = UIColorFromRGB(0x999999);
    aliasNameLab.text = @"用户别名";
    [userInfoBg addSubview:aliasNameLab];
    [aliasNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgv_user.mas_centerY).offset(2);
        make.left.equalTo(namelab.mas_left);
    }];
    _aliasNameLabel = aliasNameLab;
    
    UIView *baseInfoTopBg = [[UIView alloc] init];
    baseInfoTopBg.frame = CGRectMake(0, CGRectGetMaxY(userInfoBg.frame), SCREEN_WIDTH, topBgH*0.7);
    baseInfoTopBg.backgroundColor = [Tool gayBgColor];
    [self.view addSubview:baseInfoTopBg];
    UILabel *baseInfoTitleLab = [[UILabel alloc] init];
    baseInfoTitleLab.font = [UIFont systemFontOfSize:13];
    baseInfoTitleLab.textColor = UIColorFromRGB(0x999999);
    baseInfoTitleLab.text = @"基本信息";
    [baseInfoTopBg addSubview:baseInfoTitleLab];
    [baseInfoTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(baseInfoTopBg.mas_centerY);
        make.left.equalTo(self.view.mas_left).offset(15);
    }];
    
    //输入框
    UIView *textfieldBg = [[UIView alloc] init];
    textfieldBg.frame = CGRectMake(0, CGRectGetMaxY(baseInfoTopBg.frame), SCREEN_WIDTH, 100);
    textfieldBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textfieldBg];
    
    CGFloat iconCenterY = 46.0 / 2.0 ;
    UIImage *pswIocnImage = [UIImage imageNamed:@"home-my-account_accountpassword"];
    UIImageView *imgv_psw_icon = [[UIImageView alloc] init];
    imgv_psw_icon.image = pswIocnImage;
    [textfieldBg addSubview:imgv_psw_icon];
    [imgv_psw_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.centerY.equalTo(textfieldBg.mas_centerY).offset(-iconCenterY);
    }];
    
    UITextField *passwdTF = [[UITextField alloc] init];
    passwdTF.text = @"账号密码";
    passwdTF.enabled = NO;
    passwdTF.font = [UIFont systemFontOfSize:13];
    [textfieldBg addSubview:passwdTF];
    passwdTF.backgroundColor = [UIColor clearColor];
    [passwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(-20);
        make.width.mas_equalTo(SCREEN_WIDTH*0.60);
        make.height.mas_equalTo(45);
        make.centerY.equalTo(imgv_psw_icon.mas_centerY);
    }];
    _pswTF = passwdTF;
    
    UIImage *rightIocnImage = [Tool getTYArrowheadImage:TYGayArrowheadDirectionRight];
    UIImageView *imgv_more_icon = [[UIImageView alloc] init];
    imgv_more_icon.image = rightIocnImage;
    [textfieldBg addSubview:imgv_more_icon];
    [imgv_more_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.centerY.equalTo(imgv_psw_icon.mas_centerY);
    }];
    
    UIButton *chaneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chaneBtn setTitle:@"修改" forState:UIControlStateNormal];
    chaneBtn.backgroundColor = [UIColor whiteColor];
    [chaneBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    chaneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [chaneBtn addTarget:self action:@selector(chaneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chaneBtn];
    [chaneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgv_psw_icon.mas_centerY);
        make.width.mas_equalTo(50);
        make.height.equalTo(passwdTF.mas_height);
        make.right.equalTo(imgv_more_icon.mas_left).offset(-5);
    }];
    
    //分割线
    UIView *lin = [[UIView alloc] init];
    lin.frame = CGRectMake(0, 49.5, SCREEN_WIDTH, 1.0);
    lin.backgroundColor = [Tool gayLineColor];
    [textfieldBg addSubview:lin];
    
    //手机号
    UIImage *iphoneIocnImage = [UIImage imageNamed:@"home-my-account_mobilenumber"];
    UIImageView *imgv_iphone_icon = [[UIImageView alloc] init];
    imgv_iphone_icon.image = iphoneIocnImage;
    [textfieldBg addSubview:imgv_iphone_icon];
    [imgv_iphone_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgv_psw_icon.mas_centerX);
        make.centerY.equalTo(textfieldBg.mas_centerY).offset(iconCenterY);
    }];
    
    UITextField *iphNumTF = [[UITextField alloc] init];
    iphNumTF.text = @"手机号码";
    iphNumTF.font = passwdTF.font;
    iphNumTF.enabled = NO;
    [textfieldBg addSubview:iphNumTF];
    iphNumTF.backgroundColor = passwdTF.backgroundColor;
    [iphNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwdTF.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH*0.4);
        make.height.equalTo(passwdTF.mas_height);
        make.centerY.equalTo(imgv_iphone_icon.mas_centerY);
    }];
    _iphoneNumTF = iphNumTF;
    
    UIImage *rightIocnImage_iphone = [Tool getTYArrowheadImage:TYGayArrowheadDirectionRight];
    UIImageView *imgv_more_icon_iphone = [[UIImageView alloc] init];
    imgv_more_icon_iphone.image = rightIocnImage_iphone;
    [textfieldBg addSubview:imgv_more_icon_iphone];
    [imgv_more_icon_iphone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imgv_more_icon.mas_right);
        make.centerY.equalTo(imgv_iphone_icon.mas_centerY);
    }];
    
    UILabel *iphoneLabe = [[UILabel alloc] init];
    iphoneLabe.font = [UIFont systemFontOfSize:14];
    iphoneLabe.textColor =UIColorFromRGB(0x999999);
    iphoneLabe.text = @"";
    [textfieldBg addSubview:iphoneLabe];
    [iphoneLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgv_iphone_icon.mas_centerY);
        make.height.equalTo(passwdTF.mas_height);
        make.right.equalTo(chaneBtn.mas_right);
    }];
    _iphoneLabel = iphoneLabe ;
    
    UIButton *outloginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [outloginBtn setTitle:@"退出" forState:UIControlStateNormal];
    outloginBtn.backgroundColor = [UIColor whiteColor];
    [outloginBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    outloginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [outloginBtn addTarget:self action:@selector(outloginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outloginBtn];
    [outloginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textfieldBg.mas_bottom).offset(40);
        make.height.mas_equalTo(44.0);
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
    }];
    outloginBtn.layer.cornerRadius = 44.0/2.0;
    outloginBtn.layer.masksToBounds = YES;
}

- (void)initializeDataSource {
    NSString *url = [NSString stringWithFormat:@"%@api/Users/GetUsers",BASEURL];
    WeakObj(self)
    
    [NetManager getWithURL:url params:nil animation:YES success:^(id obj) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            weakself.modell = [[UserInfoModel alloc] initWithDictionary:obj];
            weakself.nameLabel.text = _modell.EmployeeName;
            weakself.aliasNameLabel.text = _modell.Account;
            weakself.iphoneLabel.text = _modell.Telephone;
        }
    } failure:^(NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"数据获取失败，请检查网络或重试!" delegate:weakself cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
        [alertView show];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self initializeDataSource];
    }
}

- (void)chaneBtnClick {
    //修改密码
    ChangePswController *vc = [[ChangePswController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)outloginBtnClick {
    [Tool showLoginVc:^(BOOL isLogin) {
        
    }];
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
