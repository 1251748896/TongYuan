//
//  QNYTools.h
//  TongYuan
//
//  Created by apple on 2017/12/18.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNYTools : NSObject
+ (NSString *)getQNAppAK;
+ (NSString *)getQNAppSK;
+ (NSString *)getImageFileName ;
+ (NSString *)getVideoFileName ;
+ (NSString *)getBucket ;
+ (NSString *)getQNDomain ;
+ (NSString *)makeToken:(NSString *)accessKey secretKey:(NSString *)secretKey bucket:(NSString *)bucket key:(NSString *)key;
@end
