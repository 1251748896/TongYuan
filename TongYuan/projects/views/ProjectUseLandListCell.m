//
//  ProjectUseLandListCell.m
//  TongYuan
//
//  Created by apple on 2017/12/8.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "ProjectUseLandListCell.h"
@interface ProjectUseLandListCell()
@property (nonatomic) UILabel *titleLab;
@property (nonatomic) NSMutableArray *labelArray;
@property (nonatomic) NSMutableArray *titLabelArray;


@end
@implementation ProjectUseLandListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.contentView.backgroundColor = [Tool gayBgColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *bgview = [[UIView alloc] init];
    bgview.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    bgview.layer.cornerRadius = 3.0;
    bgview.layer.masksToBounds = YES;
    bgview.layer.borderColor = [UIColor whiteColor].CGColor;
    bgview.layer.borderWidth = 1.0;
    
    CGFloat lineH = 1.0;
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.textColor = [Tool blueColor];
    _titleLab.text = @"天威";
//    _titleLab.layer.cornerRadius = 3.0;
//    _titleLab.layer.masksToBounds = YES;
    _titleLab.backgroundColor = [UIColor whiteColor];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgview.mas_top).offset(lineH);
        make.left.equalTo(bgview.mas_left).offset(lineH);
        make.right.equalTo(bgview.mas_right).offset(-lineH);
        make.height.mas_equalTo(44);
    }];
    
    CGFloat labelW = (SCREEN_WIDTH-20)*0.32;
    CGFloat labelX = 10.0 + lineH;
    CGFloat labelY = 10.0 +lineH + 44.0 + lineH;
    CGFloat labelH = 39.0;
    _titLabelArray = [NSMutableArray arrayWithCapacity:4];
    
    for (int i=0; i<4; i++) {
        UILabel *lab = [[UILabel alloc] init];
        lab.backgroundColor = [UIColor whiteColor];
        lab.textColor = UIColorFromRGB(0x404040);
        lab.textAlignment = NSTextAlignmentRight;
        lab.frame = CGRectMake(labelX, labelY+i*(labelH+lineH), labelW, labelH);
        lab.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:lab];
        [_titLabelArray addObject:lab];
    }
    
    _labelArray = [NSMutableArray arrayWithCapacity:4];
    CGFloat valueLabelX = labelX + labelW + lineH;
    CGFloat valueLabelW = SCREEN_WIDTH - 20 - 2*lineH - labelW - lineH;
    
    for (int i=0; i<4; i++) {
        UILabel *lab = [[UILabel alloc] init];
        lab.backgroundColor = UIColorFromRGB(0xf9f9f9);
        lab.textColor = UIColorFromRGB(0x999999);
        lab.textAlignment = NSTextAlignmentLeft;
        lab.frame = CGRectMake(valueLabelX, labelY+i*(labelH+lineH), valueLabelW, labelH);
        lab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:lab];
        [_labelArray addObject:lab];
    }
}

- (void)setCellValueWithModel:(ProjectUseLandListModel *)modell type:(BOOL)pjLand {
    NSArray *arr = nil;
    NSString *titl = nil;
    if (pjLand) {
        NSArray *titArr = @[@"地块名称",@"企业名称",@"总面积",@"供地时间"];
        int i = 0;
        for (UILabel *lab in _titLabelArray) {
            NSString *str = [NSString stringWithFormat:@"%@：",titArr[i]];
            lab.text = str ;
            i++;
        }
        
        titl = modell.Project_Name;
        arr = @[modell.Project_Name,modell.Project_All_Name,modell.Area,modell.SupplyTime];
    } else {
        NSArray *titArr = @[@"地块名称",@"地块坐落位置",@"地块面积",@"地块用途"];
        int i = 0;
        for (UILabel *lab in _titLabelArray) {
            NSString *str = [NSString stringWithFormat:@"%@：",titArr[i]];
            lab.text = str ;
            i++;
        }
        
        titl = modell.Land_Name;
        arr = @[modell.Land_Name,modell.Land_Located,modell.Area,modell.Land_UseName];
    }
    self.titleLab.text = titl;
    int x = 0;
    for (UILabel *labe in _labelArray) {
        NSString *str = [NSString stringWithFormat:@"  %@",arr[x]];
        labe.text = str;
        x++ ;
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
