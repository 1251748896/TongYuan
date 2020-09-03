//
//  WYJHGuideView.m
//  xinhaosiIOT
//
//  Created by apple on 2017/9/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WYJHGuideView.h"


@interface WYJHGuideView ()<UIScrollViewDelegate>{
    UIImageView *_imageView;
    
}
- (id)init;

@property (nonatomic, strong, readonly) UIButton *topBtn;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation WYJHGuideView

- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initializeUserInterface];
    }
    return self;
}

+ (BOOL)needShowGuidePageFinish:(void(^)(void))finishAnimation {
    /*
    id x = nil;
    id y = [NSNull null];
    
     x --->(null)
     y ---><null>
    */
    
    //本地沙盒版本号
    NSString *key = [NSString stringWithFormat:@"lastVersion"];
    NSString *lastVersion_s = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (lastVersion_s == nil || [lastVersion_s isKindOfClass:[NSNull class]]) {
        lastVersion_s = @"0";
    }
    
    NSInteger lastVersion = [[lastVersion_s stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];//去掉“.”
    
    //app info里面的版本号
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:bundlePath];
    NSString *version = [dict objectForKey:@"CFBundleShortVersionString"];
    NSInteger nowVersion = [[version stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
    
    if (lastVersion < nowVersion) {
        //保存这次的版本号
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",version] forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    
    return NO;
    
}

- (void)initializeUserInterface {
    self.backgroundColor = [UIColor clearColor];
    self.pagingEnabled = YES;
    self.delegate = self;
    
    NSInteger guideImageCount = 3;
    
    //水平滑动
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = YES;
    self.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * (guideImageCount+0), CGRectGetHeight(self.frame));
    for (int i = 0; i < guideImageCount; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * i, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]))];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_%d.jpg",i + 1]];
        [self.imageArray addObject:imageView];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        
        if (i == guideImageCount - 1) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, CGRectGetHeight(self.frame) * 0.78, CGRectGetWidth(self.frame), 80);
            //            button.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
            [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
            
            _imageView = imageView;
        }
    }
    
    _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _topBtn.frame = CGRectMake(SCREEN_WIDTH - 112/2.0 - 20, 20+15, 112/2.0, 64/2.0);
    [_topBtn setBackgroundImage:[UIImage imageNamed:@"跳过.png"] forState:UIControlStateNormal];
    [_topBtn addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    _topBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_topBtn];
    
}

- (void)buttonPressed {
    
    //找到current imageView
    if (self.contentOffset.x == 0*SCREEN_WIDTH) {
        //1.
        _imageView = (UIImageView *)self.imageArray[0];
    } else if (self.contentOffset.x == 1*SCREEN_WIDTH) {
        //2.
        _imageView = (UIImageView *)self.imageArray[1];
    } else if (self.contentOffset.x == 2*SCREEN_WIDTH) {
        //3.
        _imageView = (UIImageView *)self.imageArray[2];
    } else {
        return;
    }
    //    button.frame
    [UIView animateWithDuration:1.2 animations:^{
        _imageView.bounds = CGRectMake(0, 0, CGRectGetWidth(_imageView.frame) * 1.6, CGRectGetHeight(_imageView.frame) * 1.6);
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
        if (_finish) {
            _finish();
        }
        [self removeFromSuperview];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    CGFloat maxX = scrollView.contentSize.width - CGRectGetWidth(scrollView.bounds);
//    CGFloat curX = scrollView.contentOffset.x;
//    if (curX >= maxX) {
//        [self removeFromSuperview];
//    }
    
//    _topBtn.frame = CGRectMake(SCREEN_WIDTH - 112/2.0 - 20 + scrollView.contentOffset.x, _topBtn.frame.origin.y, _topBtn.frame.size.width, _topBtn.frame.size.height);
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
