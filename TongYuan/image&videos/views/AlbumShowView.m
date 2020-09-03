//
//  AlbumShowView.m
//  xinhaosiIOT
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AlbumShowView.h"

@interface AlbumShowView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation AlbumShowView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)]];
    }
    return self;
}

- (void)removeView {
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UIView class]]) {
            [v removeFromSuperview];
        }
    }
    [self removeFromSuperview];
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
    
    if (self.dataArray.count > 0) {
        [self.dataArray removeAllObjects];
    }
    
    if (self.imageArray.count == 0) {
        return;
    }
    
    if (self.dataArray.count == 0) {
        [self.dataArray addObjectsFromArray:self.imageArray];
        if (_roundShow) {
            [self.dataArray insertObject:[self.imageArray lastObject] atIndex:0];
            [self.dataArray addObject:[self.imageArray firstObject]];
        }
    }
    
    self.contentSize = CGSizeMake(rect.size.width * self.dataArray.count, 100);
    
    for (int i=0; i<self.dataArray.count; i++) {
        
        CGFloat imgvH = rect.size.height*0.7 ;
        CGFloat imgvY = (rect.size.height - imgvH) / 2.0 ;
        
        CGRect frameeee = CGRectMake(0 + i*(rect.size.width), imgvY, rect.size.width, imgvH);
        
        id data = self.dataArray[i];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = frameeee;
        [self addSubview:imageView];
        
        if ([data isKindOfClass:[UIImage class]]) {
            imageView.image = self.dataArray[i];
        } else if ([data isKindOfClass:[NSString class]]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[i]]];
        }
    }
    
    self.pageControl.numberOfPages = self.imageArray.count;
    self.pageControl.frame = CGRectMake(rect.size.width, (rect.size.height - 100), rect.size.width, 30);
    [self setContentOffset:CGPointMake(rect.size.width, 0)];
    [self bringSubviewToFront:self.pageControl];
    
    CGPoint offset = CGPointMake(_curIndx * rect.size.width, 0);
    [self setContentOffset:offset];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //修正pageControl的frame
    CGRect frame = self.pageControl.frame;
    frame.origin.x = scrollView.contentOffset.x;
    self.pageControl.frame = frame;
    [self bringSubviewToFront:self.pageControl];
    
    
    //修正pageControl的currentPage
    CGFloat pageF = scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds);
    NSInteger pageI = [NSString stringWithFormat:@"%.0f",pageF].integerValue;
    if (pageI == self.imageArray.count) {
        pageI = 0;
    }
    _pageControl.currentPage = pageI;
    
    if (!_roundShow) return;
    //修正scrollView的偏移量
    CGFloat maxContentOffset = (self.dataArray.count-1) * CGRectGetWidth(scrollView.bounds);
    CGFloat maxContentOffset_1 = (self.dataArray.count-2) * CGRectGetWidth(scrollView.bounds);
    if (scrollView.contentOffset.x >= maxContentOffset) {
        [self setContentOffset:CGPointMake(CGRectGetWidth(self.bounds), 0)];
    } else if (scrollView.contentOffset.x <= 0) {
        [self setContentOffset:CGPointMake(maxContentOffset_1, 0)];
    }
    
}

// 获取视频url的第一帧图 url:本地路径？？？？？
/*
- (UIImage *)getThumbnailImage:(NSString *)videoURL {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
 
    return thumb;
}
 */

@end
