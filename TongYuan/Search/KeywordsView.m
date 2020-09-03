//
//  KeywordsView.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/11.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "KeywordsView.h"

@implementation KeywordsView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    for (id vi in self.subviews) {
        if ([vi isKindOfClass:[UIView class]]) {
            [vi removeFromSuperview];
        }
    }
    CGFloat textFont = 13;
    CGFloat btnH = 28;
    CGFloat btnX = 0.0;
    CGFloat btnY = 5.0;
    CGFloat colSpacing = 5.0;
    CGFloat rowSpacing = 5.0;
    UIButton *lastBtn = nil;
    
    NSInteger totalCou = _dataArray.count ;
    
    for (int i=0; i<totalCou; i++) {
        
        NSInteger idnx = totalCou - i - 1;
        
        NSString *tit = [NSString stringWithFormat:@"%@",_dataArray[idnx]];
        
        UIFont *texFont = [UIFont systemFontOfSize:textFont];
        CGRect r = [tit boundingRectWithSize:CGSizeMake(MAXFLOAT, btnH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:texFont} context:nil];
        CGFloat btnW = r.size.width + 8.0;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 20 + i;
        button.titleLabel.font =[UIFont systemFontOfSize:textFont];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius = 2.0;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        [button addTarget:self action:@selector(colorClick:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:tit forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        [button setTitleColor:[Tool blueColor] forState:UIControlStateHighlighted];
        
        //
        if (!lastBtn) {
            button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        } else {
            CGFloat bx = CGRectGetMaxX(lastBtn.frame)+colSpacing;
            CGFloat curMaxX = bx + btnW ;
            if (curMaxX > rect.size.width) {
                //换行
                btnY += btnH + rowSpacing ;
                btnX = 0.0;
                button.frame = CGRectMake(btnX, btnY, btnW, btnH);
            } else {
                //不换行
                button.frame = CGRectMake(bx, btnY, btnW, btnH);
            }
        }
        [self addSubview:button];
        lastBtn = button;
    }
}

- (void)colorClick:(UIButton *)button {
    button.layer.borderColor = [Tool blueColor].CGColor;
}

- (void)buttonClick:(UIButton *)button {
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    
    if ([self.delegate respondsToSelector:@selector(beginSearchWithKeyWords:)]) {
        [self.delegate beginSearchWithKeyWords:button.titleLabel.text];
    }
}

@end
