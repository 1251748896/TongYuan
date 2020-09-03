//
//  SeleButtons.m
//  TongYuan
//
//  Created by 姜波 on 2018/4/13.
//  Copyright © 2018年 姜波. All rights reserved.
//

#import "SeleButtons.h"

@implementation SeleButtons

- (void)setSelectting:(NSInteger)selectting {
    _selectting = selectting;
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    
    if (selectting == 1) {
        // 灰色
        self.backgroundColor = UIColorFromRGB(0xffffff);
        [self setTitleColor:UIColorFromRGB(0xde443c) forState:UIControlStateNormal];
        self.layer.borderColor = UIColorFromRGB(0xde443c).CGColor;
        self.layer.borderWidth = 1.0;
    } else {
        // 红色
        self.backgroundColor = UIColorFromRGB(0xf1f2f6);
        [self setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
//        self.layer.borderColor = UIColorFromRGB(0xde443c).CGColor;
        self.layer.borderWidth = 0;;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
