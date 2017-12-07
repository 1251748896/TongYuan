//
//  LoginViewController.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
{
    void(^_dismiss)(BOOL succeed);
}
- (instancetype)initWith:(void(^)(BOOL succeed))dismiss;
@end
