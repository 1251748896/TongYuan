//
//  J_GuideView.m
//  TongYuan
//
//  Created by 姜波 on 2018/1/13.
//  Copyright © 2018年 姜波. All rights reserved.
//

#import "J_GuideView.h"

@interface J_GuideView()<UIScrollViewDelegate>{
    UIImageView *_imageView ;
    UIScrollView *_scroll ;
    UIButton *_button;
    NSTimer *_timer;
    
    NSMutableArray *_imgvArr;
    
}
//@property (nonatomic) NSTimer *timer;
@end

@implementation J_GuideView

- (void)setShowImageDataArr:(NSArray *)imageUrlArr {
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (_imageArr == nil || _imageArr.count == 0) {
        return;
    }
    
    CGFloat imgvW = rect.size.width;
    CGFloat imgvH = rect.size.height;
    CGFloat imgvX = 0.0;
    CGFloat imgvY = 0.0;
    
    _imgvArr = [NSMutableArray arrayWithCapacity:_imageArr.count];
    
    _scroll = [[UIScrollView alloc] init];
    _scroll.frame = rect;
    _scroll.pagingEnabled = YES;
    _scroll.contentSize = CGSizeMake(imgvW*_imageArr.count, imgvH);
    _scroll.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scroll];
    
    for (int i=0; i<_imageArr.count; i++) {
        
        NSString *imgUrl = [NSString stringWithFormat:@"%@",_imageArr[i]];
        
        UIImageView *imgv = [[UIImageView alloc] init];
        imgv.frame = CGRectMake(imgvX + i*imgvW, imgvY, imgvW, imgvH);
        [imgv sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[Tool getBigPlaceholderImage]];
        [_scroll addSubview:imgv];
        [_imgvArr addObject:imgv];
        if (i == _imageArr.count - 1) {
            _imageView = imgv;
        }
    }
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(imgvW-80, 25, 60, 30);
    _button.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [_button setTitle:@"跳过" forState:UIControlStateNormal];
    [_button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    _button.layer.cornerRadius = 3.0;
    _button.layer.masksToBounds = YES;
    [_button addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    
    [self startTimer];
}

- (void)jump {
    //找到current imageView
    
    NSInteger inx = _scroll.contentOffset.x / SCREEN_WIDTH ;
    
    if (inx >= _imageArr.count) {
        return;
    }
    
    _imageView = _imgvArr[inx];
    
    //    button.frame
    [UIView animateWithDuration:1.2 animations:^{
        _imageView.bounds = CGRectMake(0, 0, CGRectGetWidth(_imageView.frame) * 1.6, CGRectGetHeight(_imageView.frame) * 1.6);
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
        [self stopTimer];
        if (_finish) {
            _finish();
        }
        for (id vi in self.subviews) {
            if ([vi isKindOfClass:[UIView class]]) {
                [vi removeFromSuperview];
            }
        }
        [self removeFromSuperview];
    }];
}

- (void)timerEvent {
    
    if (_imageArr.count == 1) {
        [self jump];
        return;
    }
    
    NSInteger cou = _imageArr.count-1;
    
    if (_scroll.contentOffset.x == cou*SCREEN_WIDTH) {
        [self jump];
        [self stopTimer];
        return;
    }
    
    CGFloat offsetWidth = CGRectGetWidth(self.bounds);
    //判断当前的偏移量是否出现 异常偏移
    CGFloat offsetX = _scroll.contentOffset.x / CGRectGetWidth(self.bounds);
    NSInteger xx = (NSInteger)offsetX;
    
    if (offsetX != xx) {
        //把少偏移的0.x倍宽度 补上去
        CGFloat tempWidth = (offsetX - xx) * offsetWidth;
        tempWidth = offsetWidth - tempWidth;
        
        [_scroll setContentOffset:CGPointMake(_scroll.contentOffset.x + tempWidth, 0) animated:YES];
        return;
    } else {
        NSLog(@"相等");
    }
    
    [_scroll setContentOffset:CGPointMake(_scroll.contentOffset.x + offsetWidth, 0) animated:YES];
}

- (void)startTimer {
    
    if (_timer) {
        _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0];
        return;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
}

- (void)pauseTimer {
    _timer.fireDate = [NSDate distantFuture];
}

- (void)stopTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
