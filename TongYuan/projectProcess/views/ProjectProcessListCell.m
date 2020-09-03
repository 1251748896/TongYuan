//
//  ProjectProcessListCell.m
//  TongYuan
//
//  Created by apple on 2017/12/10.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "ProjectProcessListCell.h"
#import "CircleView.h"
@interface ProjectProcessListCell()
@property (nonatomic) CircleView *circleVi;
@property (nonatomic) UILabel *projectNameLabel, *testResultLabel, * timeLabel;
@end
@implementation ProjectProcessListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat cellHeight = 92.0;
    
    //
    [self.circleVi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.mas_equalTo(cellHeight-30);
        make.height.mas_equalTo(cellHeight-30);
    }];
    self.circleVi.highLightColor = [Tool blueColor];
    
    CGFloat j = 7.0;
    
    _projectNameLabel = [[UILabel alloc] init];
    _projectNameLabel.textColor = UIColorFromRGB(0x666666);
    _projectNameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_projectNameLabel];
    [_projectNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_circleVi.mas_right).offset(10);
        make.top.equalTo(_circleVi.mas_top).offset(j);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    _testResultLabel = [[UILabel alloc] init];
    _testResultLabel.textColor = UIColorFromRGB(0x999999);
    _testResultLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_testResultLabel];
    [_testResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_projectNameLabel.mas_left);
        make.bottom.equalTo(_circleVi.mas_bottom).offset(-j);
    }];
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = UIColorFromRGB(0x999999);
    _timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(_testResultLabel.mas_centerY);
    }];
    
    
}

- (void)setCellValueWithModel:(PorjectProcessListModel *)modell {
    
    CGFloat percent = [modell.ProgressPercent floatValue];
    if (percent > 100) {
        percent = 100;
    }
    
    if (percent == 0) {
        percent = 0.0000001;
        self.circleVi.percent = percent;//此时的值用来绘制圆形
    } else {
        
        percent = percent / 100.0;
        self.circleVi.percent = percent;//此时的值用来绘制圆形
        if (percent > 0.001 && percent < 0.005001) {
            percent = 0.005001;//此时的值用来显示在label上
        }
    }
    
    NSString *perc = [NSString stringWithFormat:@"%.0f",percent*100];
    perc = [Tool removeFloatAllZero:perc];
    perc = [NSString stringWithFormat:@"%@%@",perc,@"%"];
    
    self.circleVi.percentStr = perc;
    
    self.projectNameLabel.text = modell.ProjectName;
    self.testResultLabel.text = modell.ThisNodeName;
    NSString *signTime = [NSString stringWithFormat:@"签约：%@",modell.SigningTime];
    self.timeLabel.text = signTime;
    
}

- (CircleView *)circleVi {
    if (!_circleVi) {
        _circleVi = [[CircleView alloc] init];
        _circleVi.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_circleVi];
    }
    return _circleVi;
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
