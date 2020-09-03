//
//  QYDetailBannerView.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/16.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>
//UICollectionReusableView
@interface QYDetailBannerView : UICollectionViewCell
{
    UILabel *_companyNameLabel;
}
- (instancetype)initWithFrame:(CGRect)frame ;
- (void)setImageArr:(NSArray *)arr companyName:(NSString *)name ;
//- (instancetype)init;
@end
