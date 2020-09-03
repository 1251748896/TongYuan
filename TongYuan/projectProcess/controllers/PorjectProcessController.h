//
//  PorjectProcessController.h
//  TongYuan
//
//  Created by apple on 2017/12/10.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseViewController.h"

#import "ProjectDetailViewController.h"

@interface PorjectProcessController : BaseViewController
/*
 *征地型类型 1:征地型 6、非征地型
 */
@property (nonatomic ,assign) NSInteger projectLandType;
/*
 * 项目状态 1、待建 2、在建 3、竣工验收
 */
@property (nonatomic, assign) NSInteger projectStatus;

@property (nonatomic, copy) NSString *searchKey;

@end
