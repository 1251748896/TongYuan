//
//  GovermentListCell.h
//  TongYuan
//
//  Created by apple on 2017/12/9.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnterpriseListModel.h"
@interface GovermentListCell : UICollectionViewCell

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *nameLabel;

- (instancetype)initWithFrame:(CGRect)frame;
@end
