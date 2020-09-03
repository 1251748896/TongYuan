//
//  ViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "ViewController.h"
#import "RootViewController.h"
#import "J_GuideView.h"
@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    RootViewController *vc = [[RootViewController alloc] init];
    
    [[[UIApplication sharedApplication] delegate] window].rootViewController = vc;
    
    [Tool tool].rootVC = vc;
    
    [self getVersion];
    [self checkGuideInfo];

}

- (void)checkGuideInfo {
    
    NSString *url = [NSString stringWithFormat:@"%@api/Banner/GetBannerList",BASEURL];
    WeakObj(self)
    [NetManager getWithURL:url params:@{} animation:YES success:^(id obj) {
       
        if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *d in obj) {
                NSString *imgUrl = @"";
                if ([weakself isNull:d[@"ImageUrl"]] == NO) {
                    imgUrl = d[@"ImageUrl"];
                }
                
                if (imgUrl.length) {
                    [arr addObject:imgUrl];
                }
                
            }
            
            if (arr.count) {
                NSLog(@"arr = %@",arr);
                [Tool tool].guideArr = arr;
                [Tool checkGuideView];
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (BOOL)isNull:(id)x {
    
    
    if (x == nil) {
        return YES;
    } else if ([x isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([x isEqual:nil]) {
        return YES;
    }
    if ([x isKindOfClass:[NSString class]]) {
        NSString *s = (NSString *)x;
        if (s.length == 0) {
            return YES;
        } else if ([s isEqualToString:@"<null>"]) {
            return YES;
        } else if ([s isEqualToString:@"(null)"]) {
            return YES;
        } else if ([s isEqualToString:@"null"]) {
            return YES;
        }
    }
    
    return NO;
}


- (void)getVersion {
    
    NSString *url = [NSString stringWithFormat:@"%@api/AppVersion/GetLatestAppVersionByAppID",BASEURL];
    //获取版本号
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:bundlePath];
    NSString *localVersion = [dict objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *param = @{@"appID":@"132341"};
    [NetManager getWithURL:url params:param animation:NO success:^(id obj) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSInteger appStoreVersionID = [obj[@"AppVersionID"] integerValue];
            
            if (appStoreVersionID) {
                /*
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView show];
                 */
            }
        }
    } failure:^(NSError *error) {
        
        [Tool checkGuideView];
    }];
    
    /*
     {
     "AppVersionID": 1,
     "AppInfoID": 2,
     "VersionNumber": "sample string 3",
     "FileName": "sample string 4",
     "FileSize": 5.0,
     "Url": "sample string 6",
     "DateTime": "2017-12-24 20:30:16",
     "AppInfoName": "sample string 8"
     }
     
     "AppVersionID": 版本ID,
     "AppInfoID": AppID,
     "VersionNumber": "版本号*",
     "FileName": "文件名称",
     "FileSize": 文件大小,
     "Url": "下载路径*",
     "DateTime": "上传时间",
     "AppInfoName": "App名称"
     
     
     */
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"but = %zd",buttonIndex);
    
    if (buttonIndex == 1) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
