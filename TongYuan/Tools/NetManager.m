//
//  NetManager.m
//  TongYuan
//
//  Created by apple on 2017/12/7.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "NetManager.h"
#import <AFNetworking.h>

@implementation NetManager

#pragma mark - < 一下是正常的post、get >


+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params animation:(BOOL)animation success:(void(^)(id obj))success failure:(void(^)(NSError *error))failure {
    
    CGRect bounds = [[[UIApplication sharedApplication] delegate] window].bounds;
    UIView *blaView = [[UIView alloc]initWithFrame:bounds];
    blaView.backgroundColor = [UIColor clearColor];
    MBProgressHUD *hud = nil;
    if (animation) {
        hud = [MBProgressHUD showHUDAddedTo:blaView animated:YES];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:blaView];
    }
    
    AFHTTPSessionManager *manager = [self httpsManager];
    [manager.requestSerializer setTimeoutInterval:10.0f];

    
    NSLog(@"普通的post");
    
    NSString *hhhhh = [NSString stringWithFormat:@"Bearer %@",[Tool tool].token];
    [manager.requestSerializer setValue:hhhhh forHTTPHeaderField:@"Authorization"];
    
    [manager POST:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *resu = nil;
            NSError *err ;
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                resu = responseObject;
            }
            resu = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
            if (err) {
                NSLog(@"数据解析失败：%@",err);
                failure(err);
            } else {
                success(resu);
            }
        }
        [hud hideAnimated:YES];
        [MBProgressHUD hideHUDForView:blaView animated:YES];
        [blaView removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [MBProgressHUD hideHUDForView:blaView animated:YES];
        [blaView removeFromSuperview];
        if (failure) {
            failure(error);
        }
        NSLog(@"数据请求失败%@",error);
    }];
}
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params animation:(BOOL)animation success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    
    CGRect bounds = [[[UIApplication sharedApplication] delegate] window].bounds;
    UIView *blaView = [[UIView alloc]initWithFrame:bounds];
    blaView.backgroundColor = [UIColor clearColor];
    MBProgressHUD *hud = nil;
    if (animation) {
        hud = [MBProgressHUD showHUDAddedTo:blaView animated:YES];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:blaView];
    }
    
    AFHTTPSessionManager *manager = [self httpsManager];
    [manager.requestSerializer setTimeoutInterval:10.0f];
    
    if ([Tool tool].token.length) {
        NSString *hhhhh = [NSString stringWithFormat:@"Bearer %@",[Tool tool].token];
        [manager.requestSerializer setValue:hhhhh forHTTPHeaderField:@"Authorization"];
        
        NSLog(@"hhh = %@",hhhhh);
        
    } else {
        NSLog(@"token ----> 不存在");
        NSLog(@"url = %@",url);
        NSLog(@"dict = %@",params);
//        return;
    }
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *resu = nil;
            NSError *err = nil;
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                resu = responseObject;
            }
            resu = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
            if (err) {
                NSLog(@"%@",url);
                NSLog(@"%@",err);
                if (failure) {
                    failure(err);
                }
            } else {
                if (success) {
                    success(resu);
                }
            }
        [hud hideAnimated:YES];
        [MBProgressHUD hideHUDForView:blaView animated:YES];
        [blaView removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSLog(@"%@",url);
            NSLog(@"%@",error);
            failure(error);
        }
        [hud hideAnimated:YES];
        [MBProgressHUD hideHUDForView:blaView animated:YES];
        [blaView removeFromSuperview];
    }];
}

#pragma mark - <基本配置>
+ (AFHTTPSessionManager *)httpsManager {
    //    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    //    policy.allowInvalidCertificates = NO;
    //    policy.validatesDomainName = NO;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //    manager.securityPolicy = policy;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"image/png",@"text/plain", nil];
    return manager;
}
@end
