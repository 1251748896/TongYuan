//
//  EnterpriseDetailViewController.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/16.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseViewController.h"

@interface EnterpriseDetailViewController : BaseViewController

@property (nonatomic, copy) NSString *CompanyID;
@property (nonatomic, copy) NSString *ProductionTypeID;

@end
/*
 {
 AnotherName = "<null>";
 AuditStatusID = "<null>";
 BusinessLicenceCount = 0;
 BusinessLicenseCode = 510000000420897;
 BusinessTaxRelationship = "<null>";
 BusinessTaxStateID = "<null>";
 CheckTableSummary = "";
 CompanyAdress = "\U5317\U4eac\U5e02\U6210\U534e\U533a\U6210\U5b8f\U8def58\U53f7A\U5ea7807";
 CompanyID = 1616;
 CompanyName = "\U91cd\U5e86\U601d\U767e\U6613\U5b66\U6280\U65e0\U9650\U8d23\U4efb\U516c\U53f8";
 CompanyNatureID = 7;
 CompanyNatureName = "\U6709\U9650\U8d23\U4efb\U516c\U53f8";
 CompanyStateID = 1;
 CompanyStateName = "\U5f85\U5efa";
 CompanyTypeID = 1;
 CompanyTypeName = "\U73b0\U4ee3\U7535\U5b50\U4fe1\U606f";
 ContactWay = "<null>";
 CreateTime = "2017-11-29 10:41:29";
 CreditCode = 9252000012440688XB;
 CustomerAreaID = "<null>";
 CustomerAreaName = "<null>";
 DefaultLinkMan = "\U80e1\U6b63\U5141";
 DefaultLinkManPhone = 19991720611;
 DefualtBusinessLicence = "<null>";
 DefualtPic = "<null>";
 Description = "                                          SPIRIT&\U601d\U767e\U6613\n               \U5fc3\U7406\U5b66\U5e94\U7528\U4ea7\U54c1\U4e0e\U670d\U52a1  \U7efc\U5408\U89e3\U51b3\U65b9\U6848\U4f9b\U5e94\U5546\n      \U56db\U5ddd\U601d\U767e\U6613\U79d1\U6280\U6709\U9650\U8d23\U4efb\U516c\U53f8\Uff08\U7b80\U79f0\Uff1aSPIRIT&\U601d\U767e\U6613\Uff09\Uff0c\U662f\U897f\U5357\U5730\U533a\U9886\U5148\U7684\U4e13\U6ce8\U4e8e\U5fc3\U7406\U884c\U4e1a\U5e94\U7528\U4ea7\U54c1\U7814\U53d1\U548c\U751f\U4ea7\U3001\U5fc3\U7406\U5e94\U7528\U670d\U52a1\U89e3\U51b3\U65b9\U6848\U4e8e\U4e00\U4f53\U7684\U521b\U65b0\U578b\U4f01\U4e1a\U3002\U516c\U53f8\U4e1a\U52a1\U8986\U76d6\U6559\U80b2\U3001\U533b\U7597\U3001\U519b\U961f\U3001\U516c\U5b89\U3001\U6212\U6bd2\U6240\U3001\U76d1\U72f1\U3001\U4f01\U4e8b\U4e1a\U5355\U4f4d\U7b49\U884c\U4e1a\Uff0c\U5411\U5176\U63d0\U4f9b\U4e2a\U6027\U5316\U3001\U4e13\U4e1a\U5316\U7684\U5fc3\U7406\U5b66\U5e94\U7528\U4ea7\U54c1\U4e0e\U670d\U52a1\U3002\n       \U601d\U767e\U6613\U957f\U671f\U4e0e\U591a\U5bb6\U4e13\U4e1a\U673a\U6784\U548c\U56fd\U5185\U5916\U77e5\U540d\U5fc3\U7406\U5b66\U4e13\U5bb6\U5bc6\U5207\U5408\U4f5c\Uff0c\U5e76\U5728\U56db\U5ddd\U3001\U65b0\U7586\U3001\U7518\U8083\U3001\U8d35\U5dde\U3001\U4e91\U5357\U3001\U91cd\U5e86\U72ec\U5bb6\U4ee3\U7406\U56fd\U5185\U5916\U9886\U5148\U673a\U6784\U7814\U53d1\U7684\U5fc3\U7406\U5b66\U5e94\U7528\U4ea7\U54c1\U3002\U516c\U53f8\U7814\U53d1\U4e0e\U9500\U552e\U6709\U5fc3\U7406\U6d4b\U8bc4\U3001\U5fc3\U7406\U6c99\U76d8\U3001\U8eab\U5fc3\U653e\U677e\U3001\U60c5\U7eea\U8c03\U9002\U3001\U667a\U80fd\U6c99\U76d8\U3001\U56e2\U4f53\U8f85\U5bfc\U3001\U5fc3\U7406\U81ea\U52a9\U3001\U5fc3\U7406\U6559\U5b66\U4eea\U5668\U3001\U667a\U80fd\U7269\U8054\U8bbe\U5907\Uff08AI-IOT\Uff09\U3001\U8f6f\U4ef6\U7cfb\U7edf\U3001\U4e91\U5fc3\U7406\U5e73\U53f0\U7b49100\U4f59\U79cd\U5fc3\U7406\U5b66\U5e94\U7528\U4ea7\U54c1\U3002\U4e1a\U52a1\U6d89\U53ca\U79d1\U7814\U3001\U5fc3\U7406\U8bbe\U5907\U3001\U7cfb\U7edf\U8f6f\U4ef6\U3001\U6280\U672f\U57f9\U8bad\U3001\U5fc3\U7406\U56fe\U4e66\U51fa\U7248\U3001\U5fc3\U7406\U5065\U5eb7\U6d3b\U52a8\U670d\U52a1\U516d\U5927\U9886\U57df\Uff0c\U6d89\U53ca\U9886\U57df\U5e7f\U6cdb\U3001\U670d\U52a1\U7528\U6237\U591a\U3001\U4e13\U4e1a\U5b9e\U529b\U5f3a\U3002  \U516c\U53f8\U8fd8\U627f\U62c5\U4e2d\U56fd\U9752\U5c11\U5e74\U53d1\U5c55\U670d\U52a1\U4e2d\U5fc3\U300a\U5171\U9752\U56e2\U7cfb\U7edf\U5fc3\U7406\U5065\U5eb7\U8f85\U5bfc\U5458\U300b\U5728\U897f\U5357\U5730\U533a\U7684\U63a8\U5e7f\U8fd0\U8425\U5de5\U4f5c\Uff0c\U9762\U5411\U5404\U884c\U4e1a\U5fc3\U7406\U5065\U5eb7\U4ece\U4e1a\U4eba\U5458\U8fdb\U884c\U8d44\U683c\U8ba4\U8bc1\U57f9\U8bad\U670d\U52a1\U3002\n       \U516c\U53f8\U5728\U6210\U90fd\U8bbe\U6709\U4ea7\U54c1\U4e2d\U5fc3\U548c\U9500\U552e\U4e2d\U5fc3\Uff0c\U4e1a\U52a1\U8f90\U5c04\U897f\U5357\U5730\U533a\Uff0c3\U5e74\U6765\U4e3a300\U591a\U4e2a\U5ba2\U6237\U63d0\U4f9b\U89e3\U51b3\U65b9\U6848\U548c\U4e13\U4e1a\U670d\U52a1\Uff0c\U5f97\U5230\U4e1a\U754c\U548c\U5ba2\U6237\U7684\U9ad8\U5ea6\U8ba4\U53ef\U3002\U672a\U67655\U5e74\Uff0c\U601d\U767e\U6613\U5c06\U643a\U624b\U897f\U5357\U5730\U533a\U5404\U7701\U5e02\U4e2d\U5c0f\U5b66\U6821\Uff0c\U4ee5\U6559\U80b2\U90e8\U300a\U4e2d\U5c0f\U5b66\U5fc3\U7406\U8f85\U5bfc\U5ba4\U5efa\U8bbe\U6307\U5357\U300b\U4e3a\U6807\U51c6\Uff0c\U5e2e\U52a9\U5b66\U6821\U5b8c\U6210\U5efa\U8bbe\U4efb\U52a1\U3002\U652f\U6301\U5404\U4e2a\U5c42\U6b21\U7684\U666e\U901a\U9ad8\U6821\U5efa\U7acb\U5927\U5b66\U751f\U5fc3\U7406\U5065\U5eb7\U6559\U80b2\U4e2d\U5fc3\U53ca\U5fc3\U7406\U5b66\U5b9e\U9a8c\U5ba4\U3002\U52a0\U5f3a\U540c\U53f8\U6cd5\U884c\U4e1a\U5ba2\U6237\U7684\U5408\U4f5c\Uff0c\U5e2e\U52a9\U5efa\U8bbe\U4e13\U4e1a\U5316\U7684\U5fc3\U7406\U8bad\U7ec3\U8f85\U5bfc\U4f53\U7cfb\U3002\U8fdb\U4e00\U6b65\U6df1\U5316\U540c\U533b\U9662\U7684\U5408\U4f5c\U5173\U7cfb\Uff0c\U652f\U6301\U533b\U9662\U5fc3\U7406\U95e8\U8bca\U5efa\U8bbe\U3002\U6211\U4eec\U5c06\U6301\U7eed\U4e3a\U5ba2\U6237\U63d0\U4f9b\U66f4\U4e13\U4e1a\U7684\U4ea7\U54c1\U548c\U4e2a\U6027\U5316\U670d\U52a1\Uff0c\U81f4\U529b\U4e8e\U6210\U4e3a\U4e2d\U56fd\U9886\U5148\U7684\U5fc3\U7406\U5b66\U5e94\U7528\U4ea7\U54c1\U4e0e\U670d\U52a1\U89e3\U51b3\U65b9\U6848\U4f9b\U5e94\U5546\U548c\U793e\U4f1a\U5316\U793a\U8303\U6027\U4f01\U4e1a\U3002\n";
 EconomicTypeID = 5;
 EconomicTypeName = "\U8054\U8425\U7ecf\U6d4e";
 EnterpriseOriginID = 2;
 EnterpriseOriginName = "\U7ba1\U59d4\U4f1a\U5f55\U5165";
 EnterpriseSituation = "<null>";
 EnvironmentalCreditTypeID = "<null>";
 EnvironmentalCreditTypeName = "<null>";
 HasResearchCentres = 0;
 ImportantTypeID = "<null>";
 ImportantTypeName = "<null>";
 IndustryID = 1205;
 IndustryName = "\U79d1\U6280\U63a8\U5e7f\U548c\U5e94\U7528\U670d\U52a1\U4e1a";
 IndustryTypes = ",13,";
 IsCheck = "<null>";
 IsCreditCode = 1;
 IsDelete = 0;
 IsDoubleEntrepreneurshipInnovation = 1;
 IsEmployerUnit = 0;
 IsForeignCapital = 0;
 IsFourS = 0;
 IsHighTech = 0;
 IsListed = 0;
 IsMaster = 0;
 IsPayTaxesInCH = 0;
 IsPureProduction = 0;
 IsQuasiListing = 0;
 IsRegisterCH = 0;
 IsScientific = 1;
 IsUpCompany = 0;
 LaborToll = 5;
 Legal = "\U90ed\U4f73\U660e";
 LegalPhone = "<null>";
 ListedSectorID = "<null>";
 ListedSectorName = "<null>";
 ListedTime = "<null>";
 Logo = "<null>";
 MainBusiness = "\U5fc3\U7406\U5b66\U5e94\U7528\U4ea7\U54c1\U7814\U53d1\Uff0c\U751f\U4ea7\Uff0c\U9500\U552e";
 NewEconomyIndustryTypeID = 4;
 NewEconomyIndustryTypeName = "\U4eba\U5de5\U667a\U80fd";
 OccupancyModeID = 3;
 OccupancyModeName = "\U79df\U8d41\U578b\U4f01\U4e1a";
 OrganCode = 31440688X;
 ParkID = 1;
 ParkName = "<null>";
 Patents = "<null>";
 PicCount = 3;
 ProductionTypeID = 1;
 ProductionTypeName = "\U751f\U4ea7\U6027";
 QRCode = "<null>";
 RegisteredFunds = 1000;
 RegistrationAdress = "\U91cd\U5e86\U601d\U767e\U6613\U5b66\U6280\U65e0\U9650\U8d23\U4efb\U516c\U53f8";
 RegistrationOrgan = "\U56db\U5ddd\U7701\U5de5\U5546\U7ba1\U7406\U5c40";
 RegistrationTime = "2014-12-26 00:00:00";
 ResearchCentresTypeID = "<null>";
 ResearchCentresTypeName = "<null>";
 ScopeOfBusiness = "\U6280\U672f\U63a8\U5e7f\U670d\U52a1\Uff1b\U8f6f\U4ef6\U5f00\U53d1\Uff1b\U4fe1\U606f\U7cfb\U7edf\U96c6\U6210\U670d\U52a1\Uff1b\U4fe1\U606f\U6280\U672f\U54a8\U8be2\U670d\U52a1\Uff1b\U5065\U5eb7\U7ba1\U7406\Uff0c\U517b\U751f\U3001\U5065\U5eb7\U3001\U4fdd\U5065\U54a8\U8be2\U670d\U52a1\Uff08\U4e0d\U5f97\U4ece\U4e8b\U533b\U7597\U8bca\U6cbb\U6d3b\U52a8\Uff09\Uff1b\U6559\U80b2\U54a8\U8be2\U670d\U52a1\Uff1b\U5546\U54c1\U6279\U53d1\U4e0e\U96f6\U552e\U3002";
 SimpleName = "\U56db\U5ddd\U601d\U767e\U6613";
 TaxRegistrationCode = "<null>";
 ThumbDefualtPath = "<null>";
 TollFreeNumber = "<null>";
 TotalAssets = 0;
 UpCompanyTime = "<null>";
 UpCompanyTypeID = "<null>";
 UpCompanyTypeName = "<null>";
 WebAdress = "http://www.spirit-edu.cn/";
 }
 */
