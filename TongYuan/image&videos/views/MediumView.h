//
//  MediumView.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/19.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MediumViewDelegate<NSObject>
@optional
- (void)buttonIndex:(NSInteger)index;
- (void)showFunctionView;
- (void)currentDescribeStr:(NSString *)str ;

@end


@interface MediumView : UIView
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, weak) id<MediumViewDelegate>delegate;
@end
