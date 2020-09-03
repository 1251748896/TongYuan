//
//  YQDataCollectionViewCell.m
//  TongYuan
//
//  Created by apple on 2017/12/10.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "YQDataCollectionViewCell.h"

@implementation YQDataCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    _imgv = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgv];
    
    
    _texLabel = [[UILabel alloc] init];
    _texLabel.font = [UIFont systemFontOfSize:14];
    _texLabel.textColor = UIColorFromRGB(0x666666);
    [self.contentView addSubview:_texLabel];
    /*
    [_imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    [_texLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.imgv.mas_bottom).offset(10);
    }];
    */
}

@end
