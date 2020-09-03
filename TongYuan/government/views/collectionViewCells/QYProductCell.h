//
//  QYProductCell.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/16.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYProductCell : UICollectionViewCell

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *nameLabel;

- (instancetype)initWithFrame:(CGRect)frame;
@end
