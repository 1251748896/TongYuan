//
//  QYDetailViewController.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/20.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseViewController.h"

@interface QYDetailViewController : BaseViewController
{
    NSString *_productId;
}
@property (nonatomic, copy) NSString *CompanyID;
@property (nonatomic, copy) NSString *enterpriseID;// ????

@end

/*
 
 OccupancyModeID": 入住方式ID,
 "NewEconomyIndustryTypeID": 新经济类型ID,
 "ListedSectorID": 上市ID,
 "IsFourS": 是否是4S店,
 "IsScientific": true,
 "IsDoubleEntrepreneurshipInnovation": 是否是双创企业,
 "IsPureProduction": 是否是纯生产企业,
 "IsListed": 是否上市,
 "ListedTime": 上市时间,
 "IsQuasiListing": 是否拟上市,
 "IsRegisterCH": 是否在龙潭注册,
 "IsPayTaxesInCH": 是否在龙潭纳税,
 "IsForeignCapital": 是否是外企,
 "IsHighTech": 是否是高科技企业,
 "IndustryTypes": "国民经济行业分类",
 "IsEmployerUnit": 是否是业主单位,
 "EnterpriseSituation": 企业情况,
 "ProductionTypeID": 生产类型ID,
 "BusinessTaxRelationship": 工商税务关系,
 "BusinessTaxStateID": 工商税务办理状态ID,
 "ListedSectorName": 上市板块名称,
 "NewEconomyIndustryTypeName": "新经济产业类型名称",
 "OccupancyModeName": "入住方式名称",
 "ProductionTypeName": "生产类型名称",
 "CompanyID": 公司ID*,
 "CompanyTypeID": 主导产业ID*,
 "UpCompanyTypeID": 四上类型ID*,
 "IndustryID": 行业ID*,
 "CompanyName": "公司名称*",
 "CompanyAdress": "公司地址*",
 "Description": "公司描述*",
 "SimpleName": "公司简称",
 "OrganCode": "组织机构代码*",
 "Legal": "法人*",
 "IsMaster": 是否重点*,
 "IsDelete": 是否删除,
 "ContactWay": "联系方式",
 "DefaultLinkManPhone": "常用联系人名称*",
 "DefaultLinkMan": "常用联系人电话*",
 "WebAdress": "网址*",
 "IsCreditCode": 是否三证合一,
 "ImportantTypeID": 重点类型ID,
 "ResearchCentresTypeID": 研究中心类型,
 "CreditCode": "社会统一信用代码证*",
 "TaxRegistrationCode": 国税地税登记代码,
 "BusinessLicenseCode": "营业执照代码",
 "CompanyStateID": 公司状态ID*,
 "CompanyNatureID": 公司性质*,
 "HasResearchCentres": 是否有研究中心,
 "IsUpCompany": 是否是规上企业*,
 "UpCompanyTime": 申规时间,
 "AnotherName": 别称,
 "TollFreeNumber": 咨询电话,
 "ParkID": 园区ID,
 "EconomicTypeID": 企业经济类型ID,
 "EnvironmentalCreditTypeID": 环保信誉等级类型ID,
 "RegisteredFunds": 企业注册资金*,
 "TotalAssets": 企业总资产*,
 "CustomerAreaID": 自定义区域ID,
 "MainBusiness": "主营业务*",
 "ScopeOfBusiness": "经营范围*",
 "RegistrationOrgan": "登记机关",
 "Patents": 专利情况,
 "LaborToll": 用工人数*,
 "RegistrationAdress": "注册地址*",
 "LegalPhone": 法人电话,
 "RegistrationTime": "注册时间",
 "EnterpriseOriginID": 企业来源ID,
 "AuditStatusID": 审核状态ID,
 "QRCode": 二维码,
 "CreateTime": "创建时间",
 "IsCheck": 是否核查,
 "IndustryName": "行业名称*",
 "CompanyTypeName": "现代电子信息*",
 "UpCompanyTypeName": 四上企业类型名称,
 "CompanyStateName": "待建*",
 "CompanyNatureName": "有限责任公司*",
 "ImportantTypeName": 重点类型名称,
 "ResearchCentresTypeName": 研究中心分类名称,
 "DefualtPic": 默认图片地址*,
 "ThumbDefualtPath": 默认图片缩略图地址*,
 "PicCount": 图片张数*,
 "Logo": logo,
 "ParkName": 园区名称,
 "EconomicTypeName": "经济类型名称*",
 "EnvironmentalCreditTypeName": 环保信誉等级类型名称,
 "CustomerAreaName": 自定义区域名称,
 "DefualtBusinessLicence": 默认营业执照地址*,
 "BusinessLicenceCount": 营业执照数量,
 "EnterpriseOriginName": "企业来源名称",
 "CheckTableSummary": "企业核查情况"
 
 */
