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
