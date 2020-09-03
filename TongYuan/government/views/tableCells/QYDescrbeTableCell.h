//
//  QYDescrbeTableCell.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/20.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DescribeModel.h"
@class QYDescrbeTableCell;

@protocol QYDescrbeTableCellDelegate<NSObject>
@optional
- (void)changeCellStatus:(QYDescrbeTableCell *)cell indnxPath:(NSIndexPath *)indexPath ;

@end
@interface QYDescrbeTableCell : UITableViewCell
{
    UILabel *_titleLabel;
    UIButton *button;
}

@property (nonatomic, weak) id<QYDescrbeTableCellDelegate>delegate;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) UILabel *detailLabel;
@property (nonatomic, assign) BOOL showing;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
- (void)setCellvalue:(DescribeModel *)modell;
@end
