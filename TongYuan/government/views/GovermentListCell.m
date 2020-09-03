//
//  GovermentListCell.m
//  TongYuan
//
//  Created by apple on 2017/12/9.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "GovermentListCell.h"

@implementation GovermentListCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    self.contentView.backgroundColor = [Tool gayBgColor];
    
    CGFloat xx = 10.0;
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(xx);
        make.left.equalTo(self.contentView.mas_left).offset(xx);
        make.right.equalTo(self.contentView.mas_right).offset(-xx);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-30);
    }];
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = UIColorFromRGB(0x404040);
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_left);
        make.right.equalTo(_imageView.mas_right);
        make.top.equalTo(_imageView.mas_bottom);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

@end
