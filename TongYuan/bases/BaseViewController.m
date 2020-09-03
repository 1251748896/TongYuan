//
//  BaseViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic) UILabel *promitLabel;
@end

@implementation BaseViewController

- (UILabel *)promitLabel {
    if (!_promitLabel) {
        _promitLabel = [[UILabel alloc] init];
        _promitLabel.text = @"暂无相关信息";
        _promitLabel.hidden = YES;
        _promitLabel.center = CGPointMake(SCREEN_WIDTH/2.0, SCREENH_HEIGHT/2.0);
        _promitLabel.font = [UIFont systemFontOfSize:15];
        _promitLabel.textColor = UIColorFromRGB(0x666666);
        [self.view addSubview:_promitLabel];
    }
    return _promitLabel;
}

- (void)showPromitLabel:(BOOL)show {
    if (show) {
        self.promitLabel.hidden = NO;
        [self.view bringSubviewToFront:self.promitLabel];
    } else {
        self.promitLabel.hidden = YES;
        [self.view sendSubviewToBack:self.promitLabel];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航的中间标题的字体大小和颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[Tool blueColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    //设置顶部导航条的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    //让self.view随着导航一起上下,让view不会被导航遮挡.
    self.navigationController.navigationBar.translucent = NO;
    
    //判断是否需要显示 左上角的 “返回” 按钮
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[Tool getTYArrowheadImage:TYBlueArrowheadDirectionLeft] style:UIBarButtonItemStylePlain target:self action:@selector(processBackBarButtonItem)];
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(processBackBarButtonItem)];
    //processBackBarButtonItem
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    //设置系统自带返回icon的主色调
    self.navigationController.navigationBar.tintColor = [Tool blueColor];
}

- (void)processBackBarButtonItem {
    if (self.navigationController) {
        NSString *curVcName = [NSString stringWithUTF8String:object_getClassName(self)];
        
        if ([curVcName isEqualToString:@"SearchViewController"]) {
            [self.navigationController popViewControllerAnimated:NO];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    if (self.navigationController.viewControllers.count >= 2) {
        
        if (self.tabBarController.tabBar.hidden == NO) {
            
            [UIView animateWithDuration:0.3 animations:^{
                self.tabBarController.tabBar.center = CGPointMake(self.tabBarController.tabBar.center.x, CGRectGetHeight([UIScreen mainScreen].bounds) + CGRectGetHeight(self.tabBarController.tabBar.frame) / 2);
            }completion:^(BOOL finished) {
                self.tabBarController.tabBar.hidden = YES;
            }];
        }
    } else {
        
        self.navigationItem.leftBarButtonItem = nil;
        
        self.tabBarController.tabBar.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.tabBarController.tabBar.center = CGPointMake(self.tabBarController.tabBar.center.x, CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetHeight(self.tabBarController.tabBar.frame) / 2);
        }completion:^(BOOL finished) {
            
        }];
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
