//
//  BaseViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航的中间标题的字体大小和颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]};
    //设置顶部导航条的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    //让self.view随着导航一起上下,让view不会被导航遮挡.
    self.navigationController.navigationBar.translucent = NO;
    
    //判断是否需要显示 左上角的 “返回” 按钮
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(processBackBarButtonItem)];
    self.navigationItem.backBarButtonItem = backBarButtonItem;
    //设置系统自带返回icon的主色调
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)processBackBarButtonItem {
    
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
