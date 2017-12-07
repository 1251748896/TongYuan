//
//  CircleBannerView.m
//  xinhaosiIOT
//
//  Created by apple on 2017/10/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CircleBannerView.h"

@interface CircleBannerView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CircleBannerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
    }
    return self;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _dataArray;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPageIndicatorTintColor = self.pageControlSelectedColor;
        _pageControl.pageIndicatorTintColor = self.pageControlNormalColor;
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
        _pageControl.autoresizingMask = UIViewAutoresizingNone;
        _pageControl.userInteractionEnabled = NO;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterval target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
        _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.timerInterval];
    }
    return _timer;
}

- (NSTimeInterval)timerInterval {
    if (!_timerInterval) {
        _timerInterval = 3.0;
    }
    return _timerInterval;
}

- (UIColor *)pageControlNormalColor {
    if (!_pageControlNormalColor) {
        _pageControlNormalColor = [UIColor whiteColor];
    }
    return _pageControlNormalColor;
}

- (UIColor *)pageControlSelectedColor {
    if (!_pageControlSelectedColor) {
        _pageControlSelectedColor = [UIColor colorWithRed:0.204 green:0.816 blue:0.969 alpha:1.000];
    }
    return _pageControlSelectedColor;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)pageChange:(UIPageControl *)pageControl {
    
}

- (void)setImageArray:(NSArray *)imageArray {
    
    _imageArray = imageArray;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
   
    for (UIView *vi in self.subviews) {
        if ([vi isKindOfClass:[UIImageView class]]) {
            [vi removeFromSuperview];
        }
    }
    
    
    if (_timerInterval <= 0) {
        _timerInterval = 3.0;
    }
    
    if (self.dataArray.count > 0) {
        [self.dataArray removeAllObjects];
    }
    
    if (self.imageArray.count == 0) {
        return;
    }
    
    if (self.dataArray.count == 0) {
        [self.dataArray addObjectsFromArray:self.imageArray];
        [self.dataArray insertObject:[self.imageArray lastObject] atIndex:0];
        [self.dataArray addObject:[self.imageArray firstObject]];
    }
    
    self.contentSize = CGSizeMake(rect.size.width * self.dataArray.count, 100);
    
    for (int i=0; i<self.dataArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.frame = CGRectMake(0 + i*(rect.size.width), 0, rect.size.width, rect.size.height);
        [self addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[i]]];
    }
    
    self.pageControl.numberOfPages = self.imageArray.count;
    self.pageControl.frame = CGRectMake(rect.size.width, (rect.size.height - 30), rect.size.width, 30);
    [self setContentOffset:CGPointMake(rect.size.width, 0)];
    [self bringSubviewToFront:self.pageControl];
    [self startTimer];
}

- (void)timerEvent {
    
    CGFloat offsetWidth = CGRectGetWidth(self.bounds);
    //判断当前的偏移量是否出现 异常偏移
    CGFloat offsetX = self.contentOffset.x / CGRectGetWidth(self.bounds);
    NSInteger xx = (NSInteger)offsetX;
    if (offsetX != xx) {
        //把少偏移的0.x倍宽度 补上去
        CGFloat tempWidth = (offsetX - xx) * offsetWidth;
        tempWidth = offsetWidth - tempWidth;
        
        [self setContentOffset:CGPointMake(self.contentOffset.x + tempWidth, 0) animated:YES];
        return;
    }
    [self setContentOffset:CGPointMake(self.contentOffset.x + offsetWidth, 0) animated:YES];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //修正pageControl的frame
    CGRect frame = self.pageControl.frame;
    frame.origin.x = scrollView.contentOffset.x;
    self.pageControl.frame = frame;
    [self bringSubviewToFront:self.pageControl];
    
    //修正scrollView的偏移量
    CGFloat maxContentOffset = (self.dataArray.count-1) * CGRectGetWidth(scrollView.bounds);
    CGFloat maxContentOffset_1 = (self.dataArray.count-2) * CGRectGetWidth(scrollView.bounds);
    if (scrollView.contentOffset.x >= maxContentOffset) {
        [self setContentOffset:CGPointMake(CGRectGetWidth(self.bounds), 0)];
    } else if (scrollView.contentOffset.x <= 0) {
        [self setContentOffset:CGPointMake(maxContentOffset_1, 0)];
    }
    
    //修正pageControl的currentPage
    CGFloat pageF = scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds);
    NSInteger pageI = [NSString stringWithFormat:@"%.0f",pageF].integerValue - 1;
    if (pageI == self.imageArray.count) {
        pageI = 0;
    }
    _pageControl.currentPage = pageI;
}

//将要拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self pauseTimer];
}

//手动拖拽的滑动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self startTimer];
}
- (void)startTimer {
    //开启定时器
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.timerInterval];
}
- (void)pauseTimer {
    //暂停定时器
    self.timer.fireDate = [NSDate distantFuture];
}
- (void)stopTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
@end
