//
//  EnterpriseListViewController.h
//  TongYuan
//
//  Created by apple on 2017/12/15.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseViewController.h"

@interface EnterpriseListViewController : BaseViewController
{
    NSMutableArray *_topBtnArr ;
    NSInteger _orderType;// 1、综合(默认) 2、工商注册资金 3、产值
    BOOL _isAsc;
}
@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic, copy) NSString *topEnterpriseTypeID;
@property (nonatomic, copy) NSString *secondEnterpriseTypeID;
@end
