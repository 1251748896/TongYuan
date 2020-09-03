//
//  EnterpriseListModel.h
//  TongYuan
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseModel.h"

@interface EnterpriseListModel : BaseModel

@property (nonatomic, copy) NSString *RegistrationTime;//注册时间

@property (nonatomic, copy) NSString *CreditCode;
@property (nonatomic, copy) NSString *LegalPhone;
@property (nonatomic, copy) NSString *EnterpriseOriginName;
@property (nonatomic, copy) NSString *BusinessLicenseCode;
@property (nonatomic, copy) NSString *ScopeOfBusiness;// 经营范围
@property (nonatomic, copy) NSString *DefaultLinkManPhone;
@property (nonatomic, copy) NSString *IndustryName;
@property (nonatomic, copy) NSString *CreateTime;
@property (nonatomic, copy) NSString *CompanyStateName;
@property (nonatomic, copy) NSString *OccupancyModeName;
@property (nonatomic, copy) NSString *CompanyNatureName;
@property (nonatomic, copy) NSString *MainBusiness; // 主营业务
@property (nonatomic, copy) NSString *CompanyTypeName;
@property (nonatomic, copy) NSString *ContactWay;
@property (nonatomic, copy) NSString *Legal;
@property (nonatomic, copy) NSString *OrganCode;
@property (nonatomic, copy) NSString *CheckTableSummary;
@property (nonatomic, copy) NSString *RegistrationAdress;
@property (nonatomic, copy) NSString *CompanyName;

@property (nonatomic, copy) NSString *CompanyID ;
@property (nonatomic, copy) NSString *ProductionTypeID;

@property (nonatomic, copy) NSString *EnterpriseSituation;//企业情况
@property (nonatomic, copy) NSString *CompanyAdress; // 地址
@property (nonatomic, copy) NSString *Description ; // 描述


// ThumbDefualtPath
@property (nonatomic, copy) NSString *ParkName;// 园区名称
@property (nonatomic, copy) NSString *ThumbDefualtPath;//默认图片缩略图地址
@property (nonatomic, copy) NSString *AuditStatusID;// 审核状态ID,
@property (nonatomic, copy) NSString *EnterpriseOriginID;//企业来源ID,

@property (nonatomic, copy) NSString *EconomicTypeID;//企业经济类型ID,
@property (nonatomic, copy) NSString *ParkID;// 园区id
@property (nonatomic, copy) NSString *OccupancyModeID;//入住方式ID
@property (nonatomic, copy) NSString *NewEconomyIndustryTypeID;//新经济类型ID
@property (nonatomic, copy) NSString *IsRegisterCH;//是否在龙潭注册
@property (nonatomic, copy) NSString *ImportantTypeID;//重点类型ID

@end
