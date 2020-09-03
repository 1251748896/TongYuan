//
//  WebViewController.h
//  TongYuan
//
//  Created by apple on 2017/12/9.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController
{
    NSString *_webUrl;
}
- (instancetype)initWithUrl:(NSString *)url ;

@end
