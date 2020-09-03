//
//  CircleView.h
//  xinhaosiIOT
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

@property (nonatomic, assign) CGFloat percent;
@property (nonatomic, strong) UIColor *highLightColor;

@property (nonatomic, copy) NSString *percentStr;

@end
