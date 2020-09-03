//
//  QYDetailProductModel.h
//  TongYuan
//
//  Created by apple on 2017/12/24.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseModel.h"

@interface QYDetailProductModel : BaseModel


@property (nonatomic, copy) NSString *ProductID;
@property (nonatomic, copy) NSString *EnterpriseID;
@property (nonatomic, copy) NSString *ProductTypeID;
@property (nonatomic, copy) NSString *ProductUnitID;
@property (nonatomic, copy) NSString *ProductName;
@property (nonatomic, copy) NSString *Brand;
@property (nonatomic, copy) NSString *Weight;
@property (nonatomic, copy) NSString *Place;
@property (nonatomic) NSDictionary *ProductDescription;
@property (nonatomic, copy) NSString *DefualtPic;

@end
