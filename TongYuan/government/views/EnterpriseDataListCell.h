//
//  EnterpriseDataListCell.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/15.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnterpriseDataListModel.h"
@interface EnterpriseDataListCell : UITableViewCell


@property (nonatomic) UILabel *enterpriseNameLabel;
@property (nonatomic) EnterpriseDataListModel *modell;
@property (nonatomic, copy) void(^buttonClickEvent)(NSInteger btnTag);

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
