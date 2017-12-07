//
//  Tool.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "Tool.h"
#import "LoginViewController.h"
@implementation Tool


+ (instancetype)tool
{
    static Tool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        instance.token = @"";
    });
    return instance;
}

- (void)deleUserInfo {
    self.isLogin = NO;
    self.token = @"";
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERTOKENKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (UIColor *)tinColor {
    return UIColorFromRGB(0x0064c2);
}

+ (void)showLoginVc:(void (^)(BOOL))dismiss {
//    [[self windowView].rootViewController presentViewController:[[LoginViewController alloc] init]];
}
//w
+ (UIWindow *)windowView {
    return [[[UIApplication sharedApplication] delegate] window];
}

@end
