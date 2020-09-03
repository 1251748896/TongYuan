//
//  QNYTools.m
//  TongYuan
//
//  Created by apple on 2017/12/18.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "QNYTools.h"
#import <GTMBase64/GTMBase64.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
@implementation QNYTools
+ (NSString *)getQNAppAK {
    return @"T2NCelOdswJ4-ebbvvEU5aK5fi_uqscV1OrWi1f0";
}
+ (NSString *)getQNAppSK {
    return @"Aa2ncpt_PLnfFRsrbAoiakMKe5xoxnHngNkzV0sB";
}

+ (NSString *)getImageFileName {
    NSString *timeStempString = [self getCurrentTimeStempStr];
    NSString *randomString = [self getRandomStr];
    NSString *fileName = [NSString stringWithFormat:@"tyimage_%@%@.png",timeStempString,randomString];
    return fileName;
}

+ (NSString *)getVideoFileName {
    
    NSString *timeStempString = [self getCurrentTimeStempStr];
    NSString *randomString = [self getRandomStr];
    NSString *fileName = [NSString stringWithFormat:@"tyvideo_%@%@",timeStempString,randomString];
    return fileName;
}

+ (NSString *)getBucket {
    return @"tongyuanapp";
}
+ (NSString *)getQNDomain {
    return @"p0wnv2g1f.bkt.clouddn.com";
}
+ (NSString *)getRandomStr {
    int a = arc4random()%10;
    int b = arc4random()%10;
    int c = arc4random()%10;
    int d = arc4random()%10;
    NSString *s = [NSString stringWithFormat:@"%d%d%d%d",a,b,c,d];
    return s;
}
+ (NSString *)makeToken:(NSString *)accessKey secretKey:(NSString *)secretKey bucket:(NSString *)bucket key:(NSString *)key {
    const char *secretKeyStr = [secretKey UTF8String];
    NSString *policy = [self marshal: bucket key:key];
    NSData *policyData = [policy dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedPolicy = [GTMBase64 stringByWebSafeEncodingData:policyData padded:TRUE];
    const char *encodedPolicyStr = [encodedPolicy cStringUsingEncoding:NSUTF8StringEncoding];
    
    // ******************************************
    char digestStr[CC_SHA1_DIGEST_LENGTH];
    bzero(digestStr, 0);
    CCHmac(kCCHmacAlgSHA1, secretKeyStr, strlen(secretKeyStr), encodedPolicyStr, strlen(encodedPolicyStr), digestStr);
    NSString *encodedDigest = [GTMBase64 stringByWebSafeEncodingBytes:digestStr length:CC_SHA1_DIGEST_LENGTH padded:TRUE];
    // *******************************************
    
    NSString *token = [NSString stringWithFormat:@"%@:%@:%@",  accessKey, encodedDigest, encodedPolicy];
    return token;//得到了token
}

+ (NSString *)marshal:(NSString *)bucket key:(NSString *)key {
    time_t deadline;
    time(&deadline);//返回当前系统时间
    //@property (nonatomic , assign) int expires; 怎么定义随你...
    deadline += 3600; // +3600秒,即默认token保存1小时.
    NSNumber *deadlineNumber = [NSNumber numberWithLongLong:deadline];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //images是我开辟的公共空间名（即bucket），aaa是文件的key，
    //按七牛“上传策略”的描述：    <bucket>:<key>，表示只允许用户上传指定key的文件。在这种格式下文件默认允许“修改”，若已存在同名资源则会被覆盖。如果只希望上传指定key的文件，并且不允许修改，那么可以将下面的 insertOnly 属性值设为 1。
    //所以如果参数只传users的话，下次上传key还是aaa的文件会提示存在同名文件，不能上传。
    //传images:aaa的话，可以覆盖更新，但实测延迟较长，我上传同名新文件上去，下载下来的还是老文件。
    NSString *value = [NSString stringWithFormat:@"%@:%@", bucket, key];
    [dic setObject:value forKey:@"scope"];//根据
    [dic setObject:deadlineNumber forKey:@"deadline"];
    NSString *json = [NSDictionary convertToJsonData:dic];
    return json;
    
}

/*

- (void)uploadVideoToQN {
    if (!_videoUrll) {
        [self stopAnimation];
        return;
    }
    
    //提交前先停止播放器
    
    
    BOOL existss = [[NSFileManager defaultManager] fileExistsAtPath:_videoUrll.absoluteString];
    
    NSLog(@"existss = %d",existss);
    
    NSData *data = [NSData dataWithContentsOfFile:_videoUrll.absoluteString];
    
    NSString *accessKey = [XhsAppKeysTool qiNiuAccessKey];
    NSString *secretKey = [XhsAppKeysTool qiNiuSecretKey];
    
    NSString *tempsoluteStr = _videoUrll.absoluteString;
    
    NSArray *soluteArray = [tempsoluteStr componentsSeparatedByString:@"/"];
    
    NSString *fileName = @"";
    if (soluteArray.count) {
        int a = arc4random()%10;
        int b = arc4random()%10;
        int c = arc4random()%10;
        int d = arc4random()%10;
        fileName = [NSString stringWithFormat:@"%d%d%d%d_%@",a,b,c,d,[soluteArray lastObject]];
    } else {
        fileName = @"video_ios.mp4";
    }
    
    NSString *bucket = @"xhs-007";
    NSString *token = [XhsAppKeysTool makeToken:accessKey secretKey:secretKey bucket:bucket key:fileName];
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSString *domain = @"oznuanmqa.bkt.clouddn.com";
    // data不对
    
    WeakObj(self)
    [upManager putData:data key:fileName token:token complete: ^(QNResponseInfo *info,NSString *key, NSDictionary *resp) {
        StrongObj(weakself)
        if (resp) {
            NSString *videoUrl = [NSString stringWithFormat:@"http://%@/%@",domain,fileName];
            [weakself.moviesUrlArr addObject:videoUrl];
            // 提交服务器
            [weakself uoloadMediaToXhsServer];
        } else {
            [Tool showAnimationWithMessage:@"请检查网路连接，或重新上传" showTime:1.0 fatherView:weakself];
        }
        [strongweakself stopAnimation];
    } option:nil];
}

- (void)uploadImageToQN {
    
    if (self.imagesArr.count == 0){
        [self stopAnimation];
        return;
    }
    
    if (_uploadQueueNum+1 > _maxImageCount) {
        NSString *msg = [NSString stringWithFormat:@"上传第%zd张图片完毕",_uploadQueueNum];
        kLog(msg);
        // 提交服务器
        [self uoloadMediaToXhsServer];
        return;
    }
    
    UIImage *imag = self.imagesArr[_uploadQueueNum];
    imag = [UIImage compressImageWith:imag];
    NSData *imageData = UIImagePNGRepresentation(imag);
    [self uploadImageViewdata:imageData];
}

- (void)uploadImageViewdata:(NSData *)imageData {
    
    NSString *msg = [NSString stringWithFormat:@"正在上传第%zd张图片",_uploadQueueNum];
    kLog(msg);
    
    NSString *accessKey = [XhsAppKeysTool qiNiuAccessKey];
    NSString *secretKey = [XhsAppKeysTool qiNiuSecretKey];
    
    NSString *fileName = [XhsAppKeysTool getImageFileName];
    NSString *bucket = @"xhs-007";
    NSString *token = [XhsAppKeysTool makeToken:accessKey secretKey:secretKey bucket:bucket key:fileName];
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    NSString *domain = @"oznuanmqa.bkt.clouddn.com";
    WeakObj(self)
    [upManager putData:imageData key:fileName token:token complete: ^(QNResponseInfo *info,NSString *key, NSDictionary *resp) {
        
        if (resp) {
            NSString *imageUrl = [NSString stringWithFormat:@"http://%@/%@",domain,fileName];
            [weakself.imageUrlsArr addObject:imageUrl];
            weakself.uploadQueueNum ++ ;
            [weakself uploadImageToQN];
        } else {
            [Tool showAnimationWithMessage:@"请检查网路连接，或重新上传" showTime:1.0 fatherView:weakself];
        }
        [weakself stopAnimation];
    } option:nil];
}

 */

+ (NSString *)getCurrentTimeStempStr {
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    return timeSp;
}

@end
