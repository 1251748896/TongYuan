//
//  DescribeCell.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/16.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DescribeModel.h"

@class DescribeCell;

@protocol DescribeCellDelegate<NSObject>
@optional
- (void)changeCellStatus:(DescribeCell *)cell indnxPath:(NSIndexPath *)indexPath ;

@end

@interface DescribeCell : UICollectionViewCell
{
    UILabel *_titleLabel;
    UIButton *button;
}

//@property (nonatomic, copy) void(^ShowDescribeText)(void) ;

@property (nonatomic, weak) id<DescribeCellDelegate>delegate;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) UILabel *detailLabel;
@property (nonatomic, assign) BOOL showing;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setCellvalue:(DescribeModel *)modell;

@end

