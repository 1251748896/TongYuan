//
//  ProductViewController.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/17.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductModel.h"
#import "ProductListViewController.h"
@interface ProductViewController : BaseViewController
{
    NSString * _ProductTypeID;
    NSString *_secondEnterpriseTypeID;
    CGFloat _imageViewW ;
    CGFloat _imageViewX ;
    
    
    UIScrollView *_kindScroll;
    
    NSMutableArray *_kindSubViewsArr;
    NSString *_currentType ;
    UILabel *_currentTypeLabel ;
}
@end
