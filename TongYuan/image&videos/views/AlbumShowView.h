//
//  AlbumShowView.h
//  xinhaosiIOT
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumShowView : UIScrollView

@property (nonatomic) NSArray *imageArray;//接收数据(url或image对象,都可以) requre
@property (nonatomic, assign) NSInteger curIndx;// 当前是第几张图片   requre

@property (nonatomic, assign) BOOL roundShow;// 是否循环显示
@property (nonatomic, assign) CGRect hiddenRect;// 消失的时候的rect
@property (nonatomic) UIColor *pageControlNormalColor;//默认为：白色
@property (nonatomic) UIColor *pageControlSelectedColor;//默认为：海蓝色

- (instancetype)init;
@end
