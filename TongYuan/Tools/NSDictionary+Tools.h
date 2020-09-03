//
//  NSDictionary+Tools.h
//  xinhaosiIOT
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Tools)
+ (NSString *)convertToJsonData:(NSDictionary *)dict;
+ (NSString *)logChineseString:(NSDictionary *)dict;
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;
@end
