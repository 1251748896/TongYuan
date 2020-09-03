//
//  MenusViewController.h
//  DrawerDemo
//
//  Created by apple on 2018/1/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 项目进度的搜索页面
 */
@interface MenusViewController : BaseViewController

@property (nonatomic, copy) void(^removeSearchView)(id obj);

@end
