//
//  ButtonTableCell.h
//  TongYuan
//
//  Created by apple on 2017/12/7.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonTableCellDelegate<NSObject>
/*
 0:园区土地, 1:项目进度, 2:园区生产经营数据
 3:园区企业, 4:企业生产经营数据, 5:企业产业分类税值分析, 6:企业产品
 7:更多园区动态
 */
- (void)mainClickIndex:(NSInteger)btnIndx;
@end
@interface ButtonTableCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property (nonatomic, weak) id<ButtonTableCellDelegate>delegate;
@end
