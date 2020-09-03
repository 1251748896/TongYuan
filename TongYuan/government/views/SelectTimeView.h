//
//  SelectTimeView.h
//  ZhuShangDai
//
//  Created by Mac on 16/7/20.
//  Copyright © 2016年 Mac. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol SelectTimeViewDelegate <NSObject>

@optional
-(void)didFinishPickView:(NSString*)date;

@end



@interface SelectTimeView : UIView

@property (nonatomic, copy) NSString *province;
@property(nonatomic,strong)NSDate *curDate;
@property(nonatomic,weak)id<SelectTimeViewDelegate>delegate;

@end

