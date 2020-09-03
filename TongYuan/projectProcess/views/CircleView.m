//
//  CircleView.m
//  xinhaosiIOT
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CircleView.h"

/* 弧度转角度 */
#define SK_RADIANS_TO_DEGREES(radian) \
((radian) * (180.0 / M_PI))
/* 角度转弧度 */
#define SK_DEGREES_TO_RADIANS(angle) \
((angle) / 180.0 * M_PI)

@interface CircleView ()
@property (nonatomic) UILabel *percentLabel;
@end

@implementation CircleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    CGFloat _lineWidth = 3.0;
    CGFloat _rouds = (rect.size.width - 2*_lineWidth) / 2.0;
    
    UIColor *color2 = [Tool gayBgColor];
    [color2 set];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width/2.0, rect.size.height/2.0) radius:_rouds startAngle:0 endAngle:2*M_PI clockwise:NO];
    
    path2.lineWidth = _lineWidth;
    //    path2.lineCapStyle = kCGLineCapRound;
    //    path2.lineJoinStyle = kCGLineJoinRound;
    [path2 stroke];
    
    UIColor *color = _highLightColor;
    [color set];
    
    CGFloat endAnglesss = _percent *(2* M_PI) - M_PI_2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width/2.0, rect.size.height/2.0) radius:_rouds startAngle:-M_PI_2 endAngle:endAnglesss clockwise:YES];
    
    path.lineWidth = _lineWidth;
//    path.lineCapStyle = kCGLineCapRound;
//    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
//
    [self.percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    self.percentLabel.text = _percentStr;
}

- (void)setPercentStr:(NSString *)percentStr {
    
    if (![_percentStr isEqualToString:percentStr]) {
        _percentStr = percentStr;
        self.percentLabel.text = percentStr;
        [self setNeedsDisplay];
    }
}

- (UILabel *)percentLabel {
    if (!_percentLabel) {
        _percentLabel = [[UILabel alloc] init];
        _percentLabel.text = @"0.0%";
        
        _percentLabel.textColor = UIColorFromRGB(0x4d4d4d);
        _percentLabel.font = [UIFont systemFontOfSize:14.0];
        
        [self addSubview:_percentLabel];
    }
    return _percentLabel;
}

@end
