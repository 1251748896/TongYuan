//
//  ImageListViewController.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/18.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseViewController.h"

@interface ImageListViewController : BaseViewController
@property (nonatomic, copy) NSString *ProjectID;
- (instancetype)initProjectId:(NSString *)projectId;
@end
