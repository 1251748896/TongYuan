//
//  GovernmentViewController.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseViewController.h"

@interface GovernmentViewController : BaseViewController
{
    NSString * _topEnterpriseTypeID;
    NSString *_secondEnterpriseTypeID;
    CGFloat _imageViewW ;
    CGFloat _imageViewX ;
    
    
    UIScrollView *_kindScroll;
    
    NSMutableArray *_kindSubViewsArr;
    
    NSString *_currentType ;
    UILabel *_currentTypeLabel ;
    
}
@end
