//
//  DescribeCell.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/16.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "DescribeCell.h"

@implementation DescribeCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    UIView *lin = [[UIView alloc] init];
    lin.backgroundColor = [Tool gayBgColor];
    lin.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    [self.contentView addSubview:lin];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textColor = UIColorFromRGB(0x333333);
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(lin.mas_bottom).offset(10);
    }];
    
    _detailLabel = [[UILabel alloc] init];
    
//    _detailLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    
    _detailLabel.frame = CGRectMake(10, 45, SCREEN_WIDTH-20, 17);
    _detailLabel.textColor = UIColorFromRGB(0x999999);
    _detailLabel.font = [UIFont systemFontOfSize:16];
    _detailLabel.numberOfLines = 0;
    [self.contentView addSubview:_detailLabel];
//    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(10);
//        make.top.equalTo(_titleLabel.mas_bottom).offset(7);
//        make.width.mas_equalTo(SCREEN_WIDTH-20);
//        make.height.mas_equalTo(16.7);
//    }];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[Tool blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(lookAll:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
}

- (void)lookAll:(UIButton *)btn {
    
    [button setTitle:@"" forState:UIControlStateNormal];
    _showing = !_showing;
    if ([self.delegate respondsToSelector:@selector(changeCellStatus:indnxPath:)]) {
        [self.delegate changeCellStatus:self indnxPath:_indexPath];
    }
}

- (void)setCellvalue:(DescribeModel *)modell {
    _titleLabel.text = modell.title;
    BOOL showBtn = [modell.showBtn boolValue];
    BOOL showingDetail = [modell.showing boolValue];
    
    self.showing = showingDetail;
    
    CGFloat labelSimpleH = [modell.describeSimpleLabelH floatValue];
    CGFloat labelDetailH = [modell.describeDetailLabelH floatValue];
    
    if (showBtn) {
        if (showingDetail) {
            [button setTitle:@"[收起]" forState:UIControlStateNormal];
        } else {
            [button setTitle:@"[查看详情]" forState:UIControlStateNormal];
        }
    } else {
        [button setTitle:@"" forState:UIControlStateNormal];
    }
    
    if (showBtn) {
        if (showingDetail) {
            _detailLabel.frame = CGRectMake(10, 45, SCREEN_WIDTH-20, labelDetailH);
        } else {
            _detailLabel.frame = CGRectMake(10, 45, SCREEN_WIDTH-20, labelSimpleH);
        }
    } else {
        _detailLabel.frame = CGRectMake(10, 45, SCREEN_WIDTH-20, labelSimpleH);
    }
    _detailLabel.text = modell.destring;
}


@end
