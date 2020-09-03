//
//  EnterpriseDataListCell.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/15.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "EnterpriseDataListCell.h"

@implementation EnterpriseDataListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat lineY = 25 + 20; // lineW +
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10.0)];
    viewLine.backgroundColor = [Tool gayBgColor];
    [self.contentView addSubview:viewLine];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 10+(lineY-10)/2.0-17/2.0, 6, 17)];
    view.backgroundColor = [Tool buleTextColor];
    [self.contentView addSubview:view];
    
    UIView *linee = [[UIView alloc] initWithFrame:CGRectMake(0, lineY, SCREEN_WIDTH, 0.7)];
    linee.backgroundColor = [Tool gayLineColor];
    [self.contentView addSubview:linee];
    
    _enterpriseNameLabel = [[UILabel alloc] init];
    _enterpriseNameLabel.textColor = UIColorFromRGB(0x333333);
    _enterpriseNameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_enterpriseNameLabel];
    [_enterpriseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_right).offset(8);
        make.centerY.equalTo(view.mas_centerY);
    }];
    NSArray *arr = @[@"经济数据",@"税收分析"];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.borderColor = [Tool buleTextColor].CGColor;
        button.layer.borderWidth = 1.0;
        button.tag = 10 + i;
        [button setBackgroundImage:[Tool imageWithColor:UIColorFromRGB(0x448bfc)] forState:UIControlStateHighlighted];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 3.0; button.clipsToBounds = YES;
        [button setTitleColor:[Tool buleTextColor] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        if (i == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(linee.mas_bottom).offset(15);
                make.left.equalTo(view.mas_right).offset(3);
                make.height.mas_equalTo(40);
                make.right.equalTo(self.contentView.mas_centerX).offset(-15);
            }];
        } else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(linee.mas_bottom).offset(15);
                make.right.equalTo(self.contentView.mas_right).offset(-15);
                make.height.mas_equalTo(40);
                make.left.equalTo(self.contentView.mas_centerX).offset(15);
            }];
        }
    }
}

- (void)setModell:(EnterpriseDataListModel *)modell {
    if (_modell == modell) return;
    _modell = modell;
}

- (void)buttonClick:(UIButton *)button {
    NSInteger btnTag = button.tag - 10;
    if (_buttonClickEvent) {
        _buttonClickEvent(btnTag);
    }
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
