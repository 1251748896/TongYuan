//
//  MainModel.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/10.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseModel.h"

@interface MainModel : BaseModel

@property (nonatomic ,copy) NSString *article_id;
@property (nonatomic ,copy) NSString *click;
@property (nonatomic ,copy) NSString *img_url;
@property (nonatomic ,copy) NSString *remark;
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *update_time;

@end
