//
//  ProjectProcessListCell.h
//  TongYuan
//
//  Created by apple on 2017/12/10.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PorjectProcessListModel.h"

@interface ProjectProcessListCell : UITableViewCell

- (void)setCellValueWithModel:(PorjectProcessListModel *)modell;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;

@end
