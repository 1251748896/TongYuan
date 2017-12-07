//
//  WYJHGuideView.h
//  xinhaosiIOT
//
//  Created by apple on 2017/9/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GuideFinshBlock)(void);

@interface WYJHGuideView : UIScrollView

@property (nonatomic, copy) GuideFinshBlock finish;

+ (BOOL)needShowGuidePageFinish:(void(^)(void))finishAnimation;

@end
