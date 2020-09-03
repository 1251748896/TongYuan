//
//  OperateDataCell.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/16.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperateDataCell : UICollectionViewCell

@property (nonatomic, copy) void(^buttonClickEvent)(NSInteger btnTag);

- (instancetype)initWithFrame:(CGRect)frame;
@end
