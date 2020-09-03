//
//  ZZSListTableViewCell.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/13.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZSListTableViewCell : UITableViewCell

@property (nonatomic) UIImageView *imgv;
@property (nonatomic) UILabel *texLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
