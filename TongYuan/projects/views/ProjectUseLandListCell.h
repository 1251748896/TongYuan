//
//  ProjectUseLandListCell.h
//  TongYuan
//
//  Created by apple on 2017/12/8.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectUseLandListModel.h"
@interface ProjectUseLandListCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setCellValueWithModel:(ProjectUseLandListModel *)modell type:(BOOL)pjLand ;

@end
