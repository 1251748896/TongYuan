//
//  QYDetailBannerView.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/16.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "QYDetailBannerView.h"
#import "CircleBannerView.h"

@interface QYDetailBannerView()<CircleBannerViewDelegate>
@property (nonatomic) CircleBannerView *bannerView;
@end

@implementation QYDetailBannerView
/*
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.contentView.backgroundColor = [Tool gayBgColor];
    CGFloat bannerH = 200.0/375.0 * SCREEN_WIDTH;
    _bannerView = [[CircleBannerView alloc] init];
    _bannerView.banneDdelegate = self;
    _bannerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, bannerH);
    _bannerView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bannerView];
    
    CGFloat bottomViewH = 45;
    UIView *vi = [[UIView alloc] init];
    vi.frame = CGRectMake(0, CGRectGetMaxY(_bannerView.frame), SCREEN_WIDTH, bottomViewH);
    vi.backgroundColor = [Tool gayBgColor];
    [self.contentView addSubview:vi];
    _companyNameLabel = [[UILabel alloc] init];
//    _companyNameLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH-40, bottomViewH-20);
    _companyNameLabel.bounds = CGRectMake(0, 0, SCREEN_WIDTH-30, bottomViewH-10);
    _companyNameLabel.backgroundColor = [UIColor whiteColor];
    _companyNameLabel.textColor = UIColorFromRGB(0x666666);
    _companyNameLabel.font = [UIFont systemFontOfSize:17];
    _companyNameLabel.textAlignment = NSTextAlignmentCenter;
//    _companyNameLabel.center = CGPointMake(SCREEN_WIDTH/2.0, CGRectGetMaxY(_bannerView.frame)+(bottomViewH/2.0));
    _companyNameLabel.center = CGPointMake(SCREEN_WIDTH/2.0, bottomViewH/2.0+5.0);
    _companyNameLabel.layer.cornerRadius = 3.0;
    _companyNameLabel.layer.masksToBounds = YES;
    [vi addSubview:_companyNameLabel];
    
}

- (void)setImageArr:(NSArray *)arr companyName:(NSString *)name {
    _bannerView.imageArray = arr;
    _companyNameLabel.text = name;
}
- (void)mainBannerClickIndex:(NSInteger)btnIndx indx:(NSInteger)indxxx {
    NSLog(@"indxxx = %zd",indxxx);
}

@end
