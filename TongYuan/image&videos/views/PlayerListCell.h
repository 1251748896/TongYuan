//
//  PlayerListCell.h
//  TongYuan
//
//  Created by apple on 2017/12/24.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZGLVideoPlyer.h"

@interface PlayerListCell : UICollectionViewCell

@property (nonatomic) UILabel *nameLabel;

@property (nonatomic) UIImageView *imageView ;

@property (nonatomic, copy) NSString *videoUrl ;

- (instancetype)initWithFrame:(CGRect)frame;
@end
