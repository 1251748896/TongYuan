//
//  ProductModel.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/17.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseModel.h"

@interface ProductModel : BaseModel

@property (nonatomic, copy) NSString *POrder;
@property (nonatomic, copy) NSString *PTypeID;
@property (nonatomic, copy) NSString *PTypeName;
@property (nonatomic, copy) NSString *ProductCount;
@property (nonatomic, copy) NSString *ProductTypeID;
@property (nonatomic, copy) NSString *ProductTypeIcon;
@property (nonatomic, copy) NSString *ProductTypeName;

@property (nonatomic, copy) NSString *DefualtPic; // 默认图片
@property (nonatomic, copy) NSString *DefualtThumbPic; // 默认缩略图

//二级
@property (nonatomic, copy) NSString *ParkID;

@end
