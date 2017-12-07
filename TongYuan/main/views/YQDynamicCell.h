//
//  YQDynamicCell.h
//  TongYuan
//
//  Created by apple on 2017/12/7.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQDynamicCell : UITableViewCell

@property (nonatomic) UIImageView *imgv;
@property (nonatomic) UILabel *contentlabel;
@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) UILabel *readCountLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
