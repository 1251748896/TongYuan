//
//  J_GuideView.h
//  TongYuan
//
//  Created by 姜波 on 2018/1/13.
//  Copyright © 2018年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface J_GuideView : UIView
@property (nonatomic, copy) void(^finish)(void) ;


@property (nonatomic) NSArray *imageArr;

- (void)setShowImageDataArr:(NSArray *)imageUrlArr;

@end
