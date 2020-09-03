//
//  Tool.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "Tool.h"
#import "LoginViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "J_GuideView.h"

@implementation Tool


+ (instancetype)tool
{
    static Tool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        instance.token = @"";
    });
    return instance;
}

#pragma mark - UI

+ (UIColor *)blueColor {
    return UIColorFromRGB(0x0064c2);
}
+ (UIColor *)buleTextColor {
    return UIColorFromRGB(0x0098ff);
}
+ (UIColor *)gayBgColor {
    return UIColorFromRGB(0xf5f5f5);
}

+ (UIColor *)gayLineColor {
    return UIColorFromRGB(0xe7e7e7);
}

#pragma mark - 数据

void klogdata (NSDictionary *dict) {
    
    if (![dict isKindOfClass:[NSDictionary class]]) {
        NSLog(@"传入的数据不是json");
    }
    
    NSString * str = @"";
    
    for (NSString *key in dict) {
        if ([dict[key] isKindOfClass:[NSString class]]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;\n%@",key,str];
        }
        if ([dict[key] isKindOfClass:[NSDictionary class]]) {
            str = [NSString stringWithFormat:@"%@\n@property (nonatomic, strong) NSDictionary *%@;\n",str,key];
        }
        if ([dict[key] isKindOfClass:[NSArray class]]) {
            str = [NSString stringWithFormat:@"%@\n@property (nonatomic, strong) NSArray *%@;\n",str,key];
        }
    }
    
    NSLog(@"%@",str);
}

- (void)deleUserInfo {
    self.isLogin = NO;
    self.token = @"";
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERTOKENKEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERCOOKIE];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERIPHONENUMBER];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERPASSWORD];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SearchTFPlaceholderTextLandName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SearchTFPlaceholderTextSpaceLand];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SearchTFPlaceholderTextProjectProjress];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SearchTFPlaceholderTextEnterpriseList];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SearchTFPlaceholderTextProductEngageData];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SearchTFPlaceholderTextProductList];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)textfieldSearchIconImage {
    return [UIImage imageNamed:@"home-search"];
}

+ (UIImage *)getTYArrowheadImage:(TYArrowheadDirection)type {
    if (type == TYBlueArrowheadDirectionTop) {
        return [UIImage imageNamed:@"home-arrow_up"];
    } else if (type == TYBlueArrowheadDirectionBottom) {
        return [UIImage imageNamed:@"home-arrow_down"];
    } else if (type == TYBlueArrowheadDirectionLeft) {
        return [UIImage imageNamed:@"home-arrow_left"];
    } else if (type == TYBlueArrowheadDirectionRight) {
        return [UIImage imageNamed:@"home-arrow_right"];
    }
    
    else if (type == TYGayArrowheadDirectionTop) {
        return [UIImage imageNamed:@"home-arrow_gray_up"];
    } else if (type == TYGayArrowheadDirectionBottom) {
        return [UIImage imageNamed:@"home-arrow_gray_down"];
    } else if (type == TYGayArrowheadDirectionLeft) {
        return [UIImage imageNamed:@"home-arrow_gray_left"];
    } else if (type == TYGayArrowheadDirectionRight) {
        return [UIImage imageNamed:@"home-arrow_gray_right"];
    }
    return [UIImage imageNamed:@"home-arrow_gray_right"];
}
+ (UIImage *)getBigPlaceholderImage {
    return [UIImage imageNamed:@"plisholder_main_banner"];
}

+ (NSString *)getToken {
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    NSString *userToken = [defau objectForKey:USERTOKENKEY];
    if ([userToken isKindOfClass:[NSString class]]) {
        return userToken;
    }
    return @"";
}

+ (NSString *)getIphoneNum {
    
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    NSString *iphNum = [defau objectForKey:USERIPHONENUMBER];
    if ([iphNum isKindOfClass:[NSString class]]) {
        return iphNum;
    }
    return @"";
}

+ (NSString *)getPasswd {
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    NSString *passwd = [defau objectForKey:USERPASSWORD];
    if ([passwd isKindOfClass:[NSString class]]) {
        return passwd;
    }
    return @"";
}

+ (NSString *)getUserCookie {
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    NSString *cookie = [defau objectForKey:USERCOOKIE];
    if ([cookie isKindOfClass:[NSString class]]) {
        return cookie;
    }
    return @"";
}

+ (UIWindow *)windowView {
    return [[[UIApplication sharedApplication] delegate] window];
}
#pragma mark - <压缩图片>

+ (UIImage *)compressImageWith:(UIImage *)image {
    
    @autoreleasepool {
        float imageWidth = image.size.width;
        float imageHeight = image.size.height;
        float width = 640;
        float height = image.size.height/(image.size.width/width);
        
        float widthScale = imageWidth /width;
        float heightScale = imageHeight /height;
        
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        
        if (widthScale > heightScale) {
            [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
        }
        else {
            [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
        }
        
        // 从当前context中创建一个改变大小后的图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
}

+ (NSString*)removeFloatAllZero:(NSString*)string {
    NSString * testNumber = string;
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
}

+ (NSString *)transform:(NSString *)chinese {
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    return [pinyin uppercaseString];
}

+ (NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+ (int)imgVideoRefreshCode {
    return 1000;
}

+ (UIImage *)getLocalVideoFirstImage:(id)url {
    
    NSURL *URLLLL = nil;
    if ([url isKindOfClass:[NSString class]]) {
        URLLLL = [NSURL fileURLWithPath:url];
    } else if ([url isKindOfClass:[NSURL class]]) {
        URLLLL = url;
    } else {
        NSLog(@"传入的本地url错误");
        return [[UIImage alloc] init];
    }
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:URLLLL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    NSLog(@"error = %@",error);
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    NSLog(@"thumb = %@",thumb);
    
    return thumb;
}
+ (void)showLoginVc:(void (^)(BOOL))dismiss {
    
    [[Tool tool] deleUserInfo];
    
    [Tool tool].needReSetRootVc = YES;
    LoginViewController *vc = [[LoginViewController alloc] init];
    [[self windowView].rootViewController presentViewController:vc animated:YES completion:^{
        
    }];
}

#pragma mark - 动画
+ (void)startAnimation:(UIView *)view {
    
    NSString *message = @"";
    
    CGRect bounds = [[[UIApplication sharedApplication] delegate] window].bounds;
    UIView *blaView = [[UIView alloc]initWithFrame:bounds];
    blaView.backgroundColor = [UIColor clearColor];
    blaView.tag = 666;
    MBProgressHUD *hud = nil;
        hud = [MBProgressHUD showHUDAddedTo:blaView animated:YES];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:blaView];
        if (message.length) {
            hud.label.text = message;
        }
    [view addSubview:blaView];
}

+ (void)stopAnimation:(UIView *)view {
    UIView *blaView = [view viewWithTag:666];
    if (blaView) {
        [blaView removeFromSuperview];
    }
}

+ (void)startAnimationWithMessage:(NSString *)title showTime:(CGFloat)time onView:(UIView *)view {
    MBProgressHUD *hud =[[MBProgressHUD alloc]initWithView:view];
    hud.center = view.center;
    hud.label.text = title;hud.mode = MBProgressHUDModeText;
    [hud showAnimated:YES]; [hud hideAnimated:YES afterDelay:time];
    [view addSubview:hud];
}

+ (void)startAnimation {
    [MBProgressHUD showHUDAddedTo:[Tool windowView] animated:YES];
}

+ (void)stopAnimation {
    [MBProgressHUD hideHUDForView:[Tool windowView] animated:YES];
}

+ (void)checkGuideView {
    NSArray *arr = [Tool tool].guideArr;
    if (arr.count == 0) {
        return;
    }
    
    J_GuideView *view = [[J_GuideView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.imageArr = arr;
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
    [[Tool windowView] addSubview:view];
}

@end
