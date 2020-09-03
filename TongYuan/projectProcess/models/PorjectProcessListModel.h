//
//  PorjectProcessListModel.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/14.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseModel.h"

@interface PorjectProcessListModel : BaseModel

@property (nonatomic, copy) NSString *ProjectID;
@property (nonatomic, copy) NSString *ProjectName;
@property (nonatomic, copy) NSString *ThisNodeName;
@property (nonatomic, copy) NSString *SigningTime;
@property (nonatomic, copy) NSString *ProgressPercent;
@end
