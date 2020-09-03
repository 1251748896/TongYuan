//
//  UIAlertView+ZSD.m
//  ZhuShangDai
//
//  Created by Mac on 16/12/22.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "UIAlertView+ZSD.h"

@implementation UIAlertView (ZSD)

+ (void)showAlertViewWithMessage:(NSString *)message {
    if (![self sharedAlertView].visible) {
        [[self sharedAlertView] setMessage:message];
        [[self sharedAlertView] show];
    } else {
        [[self sharedAlertView] setMessage:message];
    }
}

+ (UIAlertView *)sharedAlertView
{
    static UIAlertView *theUtility = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theUtility = [[self alloc] initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    });
    return theUtility;
}

@end
