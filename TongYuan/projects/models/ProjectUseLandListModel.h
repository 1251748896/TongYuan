//
//  ProjectUseLandListModel.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/12.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseModel.h"

@interface ProjectUseLandListModel : BaseModel

//项目用地
@property (nonatomic, copy) NSString *Area;
@property (nonatomic, copy) NSString *PBID;
@property (nonatomic, copy) NSString *Project_All_Name;
@property (nonatomic, copy) NSString *Project_Name;
@property (nonatomic, copy) NSString *SupplyTime;
//空地
@property (nonatomic, copy) NSString *Space_Land_ID;
@property (nonatomic, copy) NSString *Land_Name;
@property (nonatomic, copy) NSString *Land_Located;
@property (nonatomic, copy) NSString *Land_UseName;

@end
