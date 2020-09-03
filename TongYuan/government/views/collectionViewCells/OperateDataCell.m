//
//  OperateDataCell.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/16.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "OperateDataCell.h"

@implementation OperateDataCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    UIView *lin = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    lin.backgroundColor = [Tool gayBgColor];
    [self.contentView addSubview:lin];
    
    UILabel *tit = [[UILabel alloc] init];
    tit.text = @"生产经营数据";
    tit.textColor = UIColorFromRGB(0x333333);
    tit.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:tit];
    [tit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(lin.mas_bottom).offset(20);
    }];
    
    NSArray *arr = @[@"经济数据",@"税收分析"];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 10 + i;
        [button setBackgroundImage:[Tool imageWithColor:[Tool buleTextColor]] forState:UIControlStateNormal];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:19];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 3.0; button.clipsToBounds = YES;
        [self.contentView addSubview:button];
        if (i == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tit.mas_bottom).offset(15);
                make.left.equalTo(self.contentView.mas_left).offset(10);
                make.height.mas_equalTo(40);
                make.right.equalTo(self.contentView.mas_centerX).offset(-10);
            }];
        } else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tit.mas_bottom).offset(15);
                make.right.equalTo(self.contentView.mas_right).offset(-10);
                make.height.mas_equalTo(40);
                make.left.equalTo(self.contentView.mas_centerX).offset(10);
            }];
        }
    }
    UIView *lin2 = [[UIView alloc] init];
    lin2.backgroundColor = [Tool gayBgColor];
    [self.contentView addSubview:lin2];
    [lin2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
}

- (void)buttonClick:(UIButton *)button {
    if (_buttonClickEvent) {
        _buttonClickEvent(button.tag - 10);
    }
}

@end
