//
//  ProductDetailModel.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/17.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseModel.h"

@interface ProductDetailModel : BaseModel

@property (nonatomic, copy) NSString *ProductID;
@property (nonatomic, copy) NSString *EnterpriseID;
@property (nonatomic, copy) NSString *ProductTypeID;
@property (nonatomic, copy) NSString *ProductUnitID;
@property (nonatomic, copy) NSString *ProductName;
@property (nonatomic, copy) NSString *ProductUnitName;
@property (nonatomic, copy) NSString *EnterpriseName;
@property (nonatomic, copy) NSString *SalesTerritory;
@property (nonatomic, copy) NSString *DefualtThumbPic;
@property (nonatomic, copy) NSString *ParkID;
@property (nonatomic, copy) NSString *ParkName;
@property (nonatomic, copy) NSString *DefualtPic;
@property (nonatomic, copy) NSString *ProductTypeName;

@property (nonatomic) NSArray *ProductAttr;
@property (nonatomic) NSDictionary *ProductDescription;


@end
