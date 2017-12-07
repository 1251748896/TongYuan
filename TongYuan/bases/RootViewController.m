//
//  RootViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "RootViewController.h"
#import "UserCenterViewController.h"
#import "GovernmentViewController.h"
#import "MainViewController.h"
#import "ProjectViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self showMain];
}

- (void)showMain {
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    UINavigationController *goverNav = [[UINavigationController alloc] initWithRootViewController:[[GovernmentViewController alloc] init]];
    UINavigationController *proNav = [[UINavigationController alloc] initWithRootViewController:[[ProjectViewController alloc] init]];
    UINavigationController *userNav = [[UINavigationController alloc] initWithRootViewController:[[UserCenterViewController alloc] init]];
    self.viewControllers = @[mainNav, goverNav, proNav, userNav];
    //底部tabBar的颜色
    self.tabBar.tintColor = [UIColor clearColor];
    NSArray * array = @[@"mainNormal.png",@"manageMoneyNormal.png",@"personalNormal.png",@"moreNormal.png"];
    NSArray * selectedArray = @[@"mainHigh.png",@"manageMoneyHigh.png",@"personalHigh.png",@"moreHigh.png"];
    NSArray * titleArr = @[@"首页",@"企业",@"项目",@"我的"];
    NSArray *arrays = self.viewControllers;
    for (int i = 0; i < arrays.count; i ++) {
        UINavigationController * nav = arrays[i];
        UIImage * image = [UIImage imageNamed:array[i]];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * selectedImage = [UIImage imageNamed:selectedArray[i]];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem * item =  [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"%@",titleArr[i]] image:image selectedImage:selectedImage];
        //设置tabBarItem选中状态和普通状态的颜色
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x448bfc)} forState:UIControlStateSelected];
        
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.0 alpha:1.0]} forState:UIControlStateNormal];
        nav.tabBarItem = item;
    }
    
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
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
