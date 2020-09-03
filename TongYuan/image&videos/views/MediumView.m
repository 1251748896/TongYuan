//
//  MediumView.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/19.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "MediumView.h"

@interface MediumView()
@property (nonatomic) UITextField *picDescribeTF;
@end

@implementation MediumView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat btnW = 65;
    
    UIView *topBg = [[UIView alloc] init];
    topBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    topBg.backgroundColor = [UIColor whiteColor];
    [self addSubview:topBg];
    
    _picDescribeTF = [[UITextField alloc] init];
    _picDescribeTF.placeholder = _titleStr;
    _picDescribeTF.frame = CGRectMake(10, 8, SCREEN_WIDTH-10-btnW, 50-8*2);
    _picDescribeTF.font = [UIFont systemFontOfSize:14];
    [topBg addSubview:_picDescribeTF];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCREEN_WIDTH-btnW, 0, btnW, 50);
    addBtn.backgroundColor = [UIColor clearColor];
    [addBtn setImage:[UIImage imageNamed:@"add_medium_icon.png"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topBg addSubview:addBtn];
    
    UIView *buleLine = [[UIView alloc] init];
    buleLine.backgroundColor = [Tool blueColor];
    buleLine.frame = CGRectMake(10, 50-3, SCREEN_WIDTH-btnW-15-20, 1.0);
    [topBg addSubview:buleLine];
    
    CGFloat viewW = (SCREEN_WIDTH-15-20*2-100) / 3.0;
    NSArray *arr = @[@"相册",@"拍照",@"小视频"];
    NSArray *imgArr = @[@"img_white_top.png",@"canmera.png",@"video_cam_iocn.png"];
    for (int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [Tool gayLineColor];
        [button setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10 + i;
        button.frame = CGRectMake(15+i*(viewW+20), btnW, viewW, viewW);
        [self addSubview:button];
        
        UILabel *texLabel = [[UILabel alloc] init];
        texLabel.font = [UIFont systemFontOfSize:13];
        texLabel.textColor = UIColorFromRGB(0x999999);
        texLabel.text = arr[i];
        [self addSubview:texLabel];
        [texLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button.mas_centerX);
            make.top.equalTo(button.mas_bottom).offset(7);
        }];
    }
}

- (void)addBtnClick {
    
    if ([self.delegate respondsToSelector:@selector(showFunctionView)]) {
        [self.delegate showFunctionView];
    }
}

- (void)buttonClick:(UIButton *)button {
    if (_picDescribeTF.text == nil || _picDescribeTF.text.length == 0) {
        [Tool startAnimationWithMessage:@"请添加描述信息" showTime:0.5 onView:self];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(currentDescribeStr:)]) {
        [self.delegate currentDescribeStr:_picDescribeTF.text];
    }
    
    if ([self.delegate respondsToSelector:@selector(buttonIndex:)]) {
        [self.delegate buttonIndex:button.tag-10];
    }
}

@end
