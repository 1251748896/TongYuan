//
//  YQDynamicCell.m
//  TongYuan
//
//  Created by apple on 2017/12/7.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "YQDynamicCell.h"

@implementation YQDynamicCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI  {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat bian = 12.0;
    CGFloat imgvH = (375.0/2.0/355.0) * (SCREEN_WIDTH-2*bian);
    _imgv = [[UIImageView alloc] init];
    _imgv.frame = CGRectMake(bian, 3, SCREEN_WIDTH-bian*2, imgvH);
    [self.contentView addSubview:_imgv];
    _imgv.layer.cornerRadius = 5.0 ;
    _imgv.layer.masksToBounds = YES;
    
    _contentlabel = [[UILabel alloc] init];
//    _contentlabel.frame = CGRectMake( CGRectGetMinX(_imgv.frame), CGRectGetMaxY(_imgv.frame)+10, SCREEN_WIDTH-2*bian, 30);
    _contentlabel.numberOfLines = 0;
    _contentlabel.textColor = UIColorFromRGB(0x404040);
    _contentlabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_contentlabel];
    [_contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgv.mas_bottom).offset(10);
        make.left.equalTo(_imgv.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH-2*bian);
    }];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = UIColorFromRGB(0x404040);
    _timeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentlabel.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    _readCountLabel = [[UILabel alloc] init];
    _readCountLabel.textColor = UIColorFromRGB(0x999999);
    _readCountLabel.font = _timeLabel.font;
    [self.contentView addSubview:_readCountLabel];
    [_readCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_contentlabel.mas_right);
        make.centerY.equalTo(_timeLabel.mas_centerY);
    }];
    
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
