//
//  ZZSListTableViewCell.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/13.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "ZZSListTableViewCell.h"

@implementation ZZSListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface {
    _imgv = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgv];
    
    CGFloat imgvW = 90;
    
    [_imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(imgvW);
    }];
    
    _texLabel = [[UILabel alloc] init];
    _texLabel.numberOfLines = 0;
    _texLabel.textColor = UIColorFromRGB(0x666666);
    _texLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_texLabel];
    [_texLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgv.mas_right).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
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
