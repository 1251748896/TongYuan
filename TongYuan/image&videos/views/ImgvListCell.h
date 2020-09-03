//
//  ImgvListCell.h
//  TongYuan
//
//  Created by apple on 2017/12/24.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgvListCell : UICollectionViewCell
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UIImageView *imageView ;
@property (nonatomic, copy) NSString *imgUrl ;
@property (nonatomic, assign) NSInteger imgIndex ;

@property (nonatomic) NSArray *imgModelArr ;

- (instancetype)initWithFrame:(CGRect)frame;

@end
