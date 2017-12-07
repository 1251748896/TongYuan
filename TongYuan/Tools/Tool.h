//
//  Tool.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const USERTOKENKEY = @"userToken";

@interface Tool : NSObject

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, copy) NSString *token;

+ (instancetype)tool ;
+ (UIColor *)tinColor;
+ (void)showLoginVc:(void (^)(BOOL isLogin))dismiss;;
- (void)deleUserInfo;
@end
