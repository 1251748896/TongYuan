//
//  ButtonTableCell.m
//  TongYuan
//
//  Created by apple on 2017/12/7.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "ButtonTableCell.h"

@implementation ButtonTableCell
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
    CGFloat cellHeight = 510.0/2.0 ;
    
    CGFloat fontt = 11.0;
    CGFloat imgvCrnterY = (cellHeight-10)/4.0 - 20 ;
    //第一排
    NSArray *firArr = @[@"园区土地",@"项目进度",@"园区生产经营数据"];
    NSArray *imgs = @[@"yqtd_main_icon",@"yqtd_main_icon",@"yqtd_main_icon"];
    for (int i=0; i<firArr.count; i++) {
        UIImageView *imgv = [[UIImageView alloc] init];
        imgv.image = [UIImage imageNamed:imgs[i]];
        [self.contentView addSubview:imgv];
        
        if (i == 0) {
            [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.contentView.mas_left).offset(SCREEN_WIDTH/6.0);
                make.centerY.equalTo(self.contentView.mas_top).offset(imgvCrnterY);
            }];
        } else if (i == 1) {
            [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.contentView.mas_centerX);
                make.centerY.equalTo(self.contentView.mas_top).offset(imgvCrnterY);
            }];
        } else if (i == 2) {
            [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.contentView.mas_right).offset(-(SCREEN_WIDTH/6.0));
                make.centerY.equalTo(self.contentView.mas_top).offset(imgvCrnterY);
            }];
        }
        CGFloat labelW = SCREEN_WIDTH / 5.5;
        CGFloat labelH = 35.0;
        UILabel *label = [[UILabel alloc] init];
        label.text = firArr[i];
        label.textAlignment = NSTextAlignmentRight;
        label.bounds = CGRectMake(0, 0, labelW, labelH);
//        if (i == 0) {
//            label.center = CGPointMake(SCREEN_WIDTH/6.0, cellHeight/2.0 - labelH/2.0);
//        } else if (i == 1) {
//            label.center = CGPointMake(SCREEN_WIDTH/2.0, cellHeight/2.0 - labelH/2.0);
//        } else if (i == 2) {
//            label.center = CGPointMake(SCREEN_WIDTH - SCREEN_WIDTH/6.0, cellHeight/2.0 - labelH/2.0);
//        }
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.textColor = UIColorFromRGB(0x404040);
        label.font = [UIFont systemFontOfSize:fontt];
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imgv.mas_centerX);
            make.top.equalTo(imgv.mas_bottom).offset(6);
            make.width.mas_equalTo(labelW);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(i*(SCREEN_WIDTH/3.0), 0, SCREEN_WIDTH/3.0, (cellHeight-10)/2.0);
        [self.contentView addSubview:button];
        
    }
    
    UIView *lin = [[UIView alloc] init];
    lin.frame = CGRectMake(0, cellHeight/2.0-10.0, SCREEN_WIDTH, 1.0);
    lin.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.contentView addSubview:lin];
    
    //第二排
    NSArray *secArr = @[@"园区企业",@"企业生产经营数据",@"企业产业分类税值分析",@"企业产品"];
    NSArray *imgsSec = @[@"qyscjysj_mian_icon",@"qyscjysj_mian_icon",@"qyscjysj_mian_icon",@"qyscjysj_mian_icon"];
    for (int i=0; i<secArr.count; i++) {
        CGFloat buttonW = SCREEN_WIDTH / 4.0;
        CGFloat imgvCenterX =  SCREEN_WIDTH/8.0 + i*buttonW;
        UIImageView *imgv = [[UIImageView alloc] init];
        imgv.image = [UIImage imageNamed:imgsSec[i]];
        [self.contentView addSubview:imgv];
        
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_left).offset(imgvCenterX);
            make.bottom.equalTo(self.contentView.mas_centerY).offset(imgvCrnterY);
        }];
        
        CGFloat labelW = SCREEN_WIDTH / 5.5;
//        CGFloat labelH = 35.0;
        UILabel *label = [[UILabel alloc] init];
        label.text = secArr[i];
        label.textAlignment = NSTextAlignmentRight;
//        label.bounds = CGRectMake(0, 0, labelW, labelH);
//        label.center = CGPointMake(imgvCenterX, (cellHeight-20) - labelH/2.0);
        label.numberOfLines = 0;
        label.textColor = UIColorFromRGB(0x404040);
        label.font = [UIFont systemFontOfSize:fontt];
        [self.contentView addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imgv.mas_centerX);
            make.top.equalTo(imgv.mas_bottom).offset(6);
            make.width.mas_equalTo(labelW);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 103 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(i*(SCREEN_WIDTH/3.0), 0, SCREEN_WIDTH/3.0, (cellHeight-10)/2.0);
        [self.contentView addSubview:button];
    }
    
    UIView *lin1 = [[UIView alloc] init];
    lin1.frame = CGRectMake(0, cellHeight-20.0, SCREEN_WIDTH, 10.0);
    lin1.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.contentView addSubview:lin1];
    
    cellHeight += 25;
    
    UIButton *moreInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreInfoBtn setTitle:@"园区动态" forState:UIControlStateNormal];
    [moreInfoBtn setTitleColor:UIColorFromRGB(0x404040) forState:UIControlStateNormal];
    moreInfoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [moreInfoBtn addTarget:self action:@selector(moreInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:moreInfoBtn];
    [moreInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.height.mas_equalTo(25);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    UIImageView *iconn = [[UIImageView alloc] init];
//    iconn.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:iconn];
    [iconn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).offset(50);
        make.centerY.equalTo(self.contentView.mas_bottom).offset(-(25/2.0));
    }];
    
    
}

- (void)moreInfoBtnClick {
    if ([self.delegate respondsToSelector:@selector(mainClickIndex:)]) {
        [self.delegate mainClickIndex:7];
    }
}

- (void)buttonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(mainClickIndex:)]) {
        NSInteger indx = button.tag - 100;
        [self.delegate mainClickIndex:indx];
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
