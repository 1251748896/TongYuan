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
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params animation:(BOOL)animation success:(void(^)(id obj))success failure:(void(^)(NSError *error))failure {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [MBProgressHUD showHUDAddedTo:window animated:YES];
    AFHTTPSessionManager *manager = [self httpsManager];
    [manager.requestSerializer setTimeoutInterval:10.0f];
    
    [manager POST:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:window animated:YES];
        if (success) {
            NSDictionary *resu = nil;
            NSError *err ;
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                resu = responseObject;
            }
            
            resu = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
            if (err) {
                NSLog(@"%@",err);
                failure(err);
            } else {
                success(resu);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:window animated:YES];
        if (failure) {
            failure(error);
        }
        NSLog(@"%@",error);
    }];
}
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params animation:(BOOL)animation success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [self httpsManager];
    [manager.requestSerializer setTimeoutInterval:10.0f];
    NSMutableDictionary *dict = nil;
    
    if ([params isKindOfClass:[NSMutableDictionary class]]) {
        dict = (NSMutableDictionary *)params;
    } else {
        dict = params.mutableCopy;
    }
    if ([Tool tool].token.length) {
        [dict setObject:[Tool tool].token forKey:@"token"];
    } else {
        NSLog(@"token 不存在");
        return;
    }
    
    [manager GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
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
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            NSLog(@"%@",url);
            NSLog(@"%@",error);
            failure(error);
        }
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
