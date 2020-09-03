//
//  Tool.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RootViewController.h"
static NSString *const USERTOKENKEY = @"userToken";
static NSString *const USERIPHONENUMBER = @"userIphoneNumber";
static NSString *const USERCOOKIE = @"userCookie";
static NSString *const USERPASSWORD = @"userPassword";


static NSString *const SearchTFPlaceholderTextLandName = @"请输入地块名称搜索"; //项目用地
static NSString *const SearchTFPlaceholderTextSpaceLand = @"请输入地块名称搜索"; //空地情况
static NSString *const SearchTFPlaceholderTextProjectProjress = @"请输入项目名称搜索" ;//项目进度、项目大类
static NSString *const SearchTFPlaceholderTextEnterpriseList = @"请输入企业名称搜索";  //企业列表、企业大类
static NSString *const SearchTFPlaceholderTextProductEngageData = @"请输入企业名称搜索"; //生产经营数据
static NSString *const SearchTFPlaceholderTextProductList = @"请输入产品名称搜索"; //产品大类、产品列表

typedef NS_ENUM(NSInteger, TYArrowheadDirection) {
    TYBlueArrowheadDirectionLeft    = 0,
    TYBlueArrowheadDirectionRight    ,
    TYBlueArrowheadDirectionTop ,
    TYBlueArrowheadDirectionBottom  ,
    
    TYGayArrowheadDirectionLeft ,
    TYGayArrowheadDirectionRight ,
    TYGayArrowheadDirectionTop ,
    TYGayArrowheadDirectionBottom  ,
};

typedef NS_ENUM(NSInteger, SearchViewControllerType) {
    ProjectProcessType    = 0,// 项目进度
    Enterprise    , // 企业
    ProjectUseLand , // 项目用地
    productOperationData ,//企业生产经营数据（企业列表）
};
@interface Tool : NSObject

@property (nonatomic) NSArray *guideArr ;//引导页imageUrl
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign) BOOL needReSetRootVc;//登录完成时候需要重置rootvc
@property (nonatomic) RootViewController *rootVC;
@property (nonatomic, assign) BOOL rmPlayer;//判断是否需要移除player
@property (nonatomic, assign) int imgListRefreshCode ;//记录是不是需要刷新图片列表或者视频列表
@property (nonatomic, assign) int videoListRefreshCode ;//记录是不是需要刷新图片列表或者视频列表

+ (instancetype)tool ;
//UI
+ (UIColor *)blueColor ;
+ (UIColor *)buleTextColor;
+ (UIColor *)gayBgColor ;
+ (UIColor *)gayLineColor ;

// 数据存储/数据转换
void klogdata (NSDictionary *dict) ;
- (void)deleUserInfo;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)textfieldSearchIconImage;
+ (NSString *)getToken ;
+ (NSString *)getIphoneNum ;
+ (NSString *)getPasswd ;
+ (NSString *)getUserCookie ;
+ (UIImage *)compressImageWith:(UIImage *)image ;
+ (NSString *)convertToJsonData:(NSDictionary *)dict ;
+ (UIImage *)getLocalVideoFirstImage:(id)url ;

+ (UIImage *)getTYArrowheadImage:(TYArrowheadDirection)type ;
+ (UIImage *)getBigPlaceholderImage;
+ (NSString*)removeFloatAllZero:(NSString*)string ;
+ (NSString *)transform:(NSString *)chinese ;
+ (int)imgVideoRefreshCode ;

//
+ (void)showLoginVc:(void (^)(BOOL isLogin))dismiss;;
+ (UIWindow *)windowView ;
//动画
+ (void)startAnimation:(UIView *)view;
+ (void)stopAnimation:(UIView *)view;
+ (void)startAnimation ;
+ (void)stopAnimation ;
+ (void)startAnimationWithMessage:(NSString *)title showTime:(CGFloat)time onView:(UIView *)view;
+ (void)checkGuideView ;
@end
