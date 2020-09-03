//
//  SearchViewController.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/9.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, SearchType) {
    
    SearchTypeLandName ,//项目用地
    SearchTypeSpaceLand ,//空地情况
    SearchTypeProjectProjress ,//项目进度、项目大类
    SearchTypeEnterpriseList , //企业列表、企业大类
    SearchTypeProductEngageData ,//生产经营数据
    SearchTypeProductList ,//产品大类、产品列表
};
@interface SearchViewController : BaseViewController

@property (nonatomic, copy) void(^searchResult)(NSString *searchKey);

@property (nonatomic, assign) SearchType type ;


@end
