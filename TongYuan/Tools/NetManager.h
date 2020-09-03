//
//  NetManager.h
//  TongYuan
//
//  Created by apple on 2017/12/7.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params animation:(BOOL)animation success:(void(^)(id obj))success failure:(void(^)(NSError *error))failure;
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params animation:(BOOL)animation success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;




@end

/*
 
 {
 
 UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
 [MBProgressHUD showHUDAddedTo:window animated:YES];
 
 NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
 AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
 
 NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
 AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
 
 //待发送数据:@[@{}] -> 数组套字典
 NSString *jsonStr = params;
 NSData *postData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
 
 NSURL *URL = [NSURL URLWithString:url];
 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
 [request setHTTPMethod:@"POST"];
 [request setHTTPBody:postData];
 
 NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
 if (error) {
 NSLog(@"Error: %@", error);
 } else {
 NSLog(@"%@ %@", response, responseObject);
 }
 }];
 [dataTask resume];
 
 */



