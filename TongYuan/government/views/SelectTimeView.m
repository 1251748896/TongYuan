//
//  SelectTimeView.m
//  ZhuShangDai
//
//  Created by Mac on 16/7/20.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "SelectTimeView.h"
#define screenWith  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface SelectTimeView()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger yearRange;
    NSInteger dayRange;
    NSInteger startYear;
    NSInteger selectedYear;
    NSInteger selectedMonth;
    NSInteger selectedDay;
    NSInteger selectedHour;
    NSInteger selectedMinute;
    NSInteger selectedSecond;
    NSCalendar *calendar;
    
    //左边退出按钮
    UIButton *cancelButton;
    //右边的确定按钮
    UIButton *chooseButton;
    
}


@property (nonatomic, copy) NSArray *selectedArray;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic,strong) NSString *string;
@end

@implementation SelectTimeView

- (instancetype)init
{
    self = [super init];
    if (self) {
 
        NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//        NSInteger unitFlags =  NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
        
        NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
       NSDateComponents *comps = [calendar0 components:unitFlags fromDate:[NSDate date]];
        NSInteger year=[comps year];
        
        startYear=year-150;
        yearRange=300;
        selectedYear=2000;
        selectedMonth=1;
        selectedDay=1;
        selectedHour=0;
        selectedMinute=0;
        dayRange=[self isAllDay:startYear andMonth:1];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    UIView *shadow = [[UIView alloc]initWithFrame:rect];
    shadow.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    shadow.userInteractionEnabled = YES;
    [shadow addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeShadow:)]];
    [self addSubview:shadow];
    
    // 先把这个view放在屏幕的最下面(在屏幕之外) 最后再动态弹出来
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, rect.size.height, rect.size.width, 220)];
    bgView.tag = 1000;
    bgView.backgroundColor = [UIColor whiteColor]; // 130 + 90 = 220
    [self addSubview:bgView];
    
    //右边的确定按钮
    chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 0, 60, 40);
    [chooseButton setTitle:@"确定" forState:UIControlStateNormal];
    chooseButton.backgroundColor = [UIColor whiteColor];
    chooseButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [chooseButton setTitleColor:UIColorFromRGB(0x448bfc) forState:UIControlStateNormal];
    //        [chooseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chooseButton addTarget:self action:@selector(hiddenPickerViewRight) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:chooseButton];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(bgView.frame), 1.0)];
    line.backgroundColor = UIColorFromRGB(0xe7e7e7);
    [bgView addSubview:line];
    
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), [UIScreen mainScreen].bounds.size.width, 179)];
    self.pickerView.backgroundColor = [UIColor whiteColor]
    ;
    self.pickerView.dataSource=self;
    self.pickerView.delegate=self;
    [bgView addSubview:self.pickerView];
    
    [self showCurrentDate];
    
    //所有控件创建完成之后，动态淡出bgView
    [UIView animateWithDuration:0.3 animations:^{
        bgView.center = CGPointMake(bgView.center.x, bgView.center.y - 220);
    }];
    
    
}

#pragma mark --
#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


//确定每一列返回的东西
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            return yearRange;
        }
            break;
        case 1:
        {
            return 12;
        }
            break;
        case 2:
        {
            return dayRange;
        }
            break;
        case 3:
        {
            return 24;
        }
            break;
        case 4:
        {
            return 60;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (void)showCurrentDate {
    //获取当前时间
    NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    comps = [calendar0 components:unitFlags fromDate:_curDate];
    NSInteger year=[comps year];
    NSInteger month=[comps month];
    NSInteger day=[comps day];
    NSInteger hour=[comps hour];
    NSInteger minute=[comps minute];
    
    selectedYear=year;
    selectedMonth=month;
    selectedDay=day;
    selectedHour=hour;
    selectedMinute=minute;
    
    dayRange=[self isAllDay:year andMonth:month];
    
    [self.pickerView selectRow:year-startYear inComponent:0 animated:YES];
    [self.pickerView selectRow:month-1 inComponent:1 animated:YES];
    [self.pickerView selectRow:day-1 inComponent:2 animated:YES];
//    [self.pickerView selectRow:hour inComponent:3 animated:YES];
//    [self.pickerView selectRow:minute inComponent:4 animated:YES];
    
    [self.pickerView reloadAllComponents];
    
    //当picker创建好的时候，马上就给 _string 赋值一次
//    _string = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld",(long)year,(long)month,(long)day,(long)hour,(long)minute];
    _string = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld",(long)year,(long)month,(long)day];
}

#pragma mark -- UIPickerViewDelegate

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(screenWith*component/6.0, 0,screenWith/6.0, 30)];
    label.font=[UIFont systemFontOfSize:15.0];
    label.tag=component*100+row;
    label.textAlignment=NSTextAlignmentCenter;
    switch (component) {
        case 0:
        {
            label.frame=CGRectMake(5, 0,screenWith/4.0, 30);
            label.text=[NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
        }
            break;
        case 1:
        {
            label.frame=CGRectMake(screenWith/4.0, 0, screenWith/8.0, 30);
            label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
        }
            break;
        case 2:
        {
            label.frame=CGRectMake(screenWith*3/8, 0, screenWith/8.0, 30);
            label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
        }
            break;
        case 3:
        {
            label.textAlignment=NSTextAlignmentRight;
            label.text=[NSString stringWithFormat:@"%ld时",(long)row];
        }
            break;
        case 4:
        {
            label.textAlignment=NSTextAlignmentRight;
            label.text=[NSString stringWithFormat:@"%ld分",(long)row];
        }
            break;
        case 5:
        {
            label.textAlignment=NSTextAlignmentRight;
            label.frame=CGRectMake(screenWith*component/6.0, 0, screenWith/6.0-5, 30);
            label.text=[NSString stringWithFormat:@"%ld秒",(long)row];
        }
            break;
            
        default:
            break;
    }
    return label;
}

// 监听picker的滑动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            selectedYear=startYear + row;
            dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
            [self.pickerView reloadComponent:2];
        }
            break;
        case 1:
        {
            selectedMonth=row+1;
            dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
            [self.pickerView reloadComponent:2];
        }
            break;
        case 2:
        {
            selectedDay=row+1;
        }
            break;
        case 3:
        {
            selectedHour=row;
        }
            break;
        case 4:
        {
            selectedMinute=row;
        }
            break;
            
        default:
            break;
    }
    
    _string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld",(long)selectedYear,(long)selectedMonth,(long)selectedDay];
    
}

#pragma mark -----点击事件------

//确认的隐藏
-(void)hiddenPickerViewRight {
    if ([self.delegate respondsToSelector:@selector(didFinishPickView:)]) {
        [self.delegate didFinishPickView:_string];
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.center = CGPointMake(self.center.x, self.center.y + 220);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)timeShadow:(UITapGestureRecognizer *)gesture {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.center = CGPointMake(self.center.x, self.center.y + 220);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark -- setter getter

- (NSArray *)selectedArray {
    if (!_selectedArray) {
        self.selectedArray = [@[] mutableCopy];
    }
    return _selectedArray;
}

-(NSInteger)isAllDay:(NSInteger)year andMonth:(NSInteger)month
{
    int day=0;
    switch(month)
    {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            day=31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            day=30;
            break;
        case 2:
        {
             //   4年1闰         百年不闰         400年再闰
            if(((year%4==0)&&(year%100!=0))||(year%400==0))
            {
                day=29;
                break;
            }
            else
            {
                day=28;
                break;
            }
        }
        default:
            break;
    }
    return day;
}


@end
