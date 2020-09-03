//
//  ESXViewController.m
//  TongYuan
//
//  Created by 姜波 on 2018/1/23.
//  Copyright © 2018年 姜波. All rights reserved.
//

#import "ESXViewController.h"
#import "SelectTimeView.h"
#import "SeleButtons.h"
@interface ESXViewController ()<UITextFieldDelegate,SelectTimeViewDelegate>
{
    CGFloat _bottomH ;
    NSInteger _tfIndex;
}
@property (nonatomic) NSMutableArray *buttonArr;
@property (nonatomic) UIScrollView *scrollView ;
@property (nonatomic) UITextField *minMoneyTF ;
@property (nonatomic) UITextField *maxMoneyTF ;
@property (nonatomic) UITextField *minTimeTF ;
@property (nonatomic) UITextField *maxTimeTF ;
@property (nonatomic) SeleButtons *regsInLT ;
@property (nonatomic) SeleButtons *regsOutLT ;
@property (nonatomic) SeleButtons *regsAll;
@property (nonatomic) SeleButtons *taxToLT ;
@property (nonatomic) SeleButtons *taxNotLT ;
@property (nonatomic) SeleButtons *taxAll;
@property (nonatomic) SeleButtons *workInLT ;
@property (nonatomic) SeleButtons *workOutLT ;
@property (nonatomic) SeleButtons *workAll ;

@end

@implementation ESXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    _buttonArr = [NSMutableArray arrayWithCapacity:2];
    
    _bottomH = 50.0;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(100, 0, SCREEN_WIDTH-100, SCREENH_HEIGHT - 64 - _bottomH);
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    CGFloat scrollW = CGRectGetWidth(_scrollView.bounds);
    
    UILabel *money_label = [[UILabel alloc] init];
    money_label.frame = CGRectMake(10, 10, scrollW-20, 20);
    money_label.text = @"请输入注册资金范围(单位：万)";
    money_label.backgroundColor = [UIColor whiteColor];
    money_label.textColor = UIColorFromRGB(0x333333);
    money_label.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:money_label];
    
    CGFloat tfW = scrollW * 0.42;
    CGFloat radioBtnH = 30;
    CGFloat radioBtnW = (scrollW-40) / 3.0;
    
    [self.minMoneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(money_label.mas_left);
        make.top.equalTo(money_label.mas_bottom).offset(10);
        make.width.mas_equalTo(tfW);
        make.height.mas_equalTo(30);
    }];
    self.minMoneyTF.text = @"0";
    
    
    UIView *lin_1 = [[UIView alloc] init];
    lin_1.backgroundColor = [Tool gayLineColor];
    [_scrollView addSubview:lin_1];
    [lin_1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(_scrollView.mas_centerX);
        make.left.equalTo(_minMoneyTF.mas_right).offset(2);
        make.centerY.equalTo(_minMoneyTF.mas_centerY);
        make.height.mas_equalTo(1.0);
        make.width.mas_equalTo(10);
    }];
    
    [self.maxMoneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(money_label.mas_right);
        make.left.equalTo(lin_1.mas_right).offset(2);
        make.centerY.equalTo(lin_1.mas_centerY);
        make.width.equalTo(_minMoneyTF.mas_width);
        make.height.equalTo(_minMoneyTF.mas_height);
    }];
    self.maxMoneyTF.text = @"0";
    //2.
    UILabel *regsTime_label = [[UILabel alloc] init];
//    regsTime_label.frame = CGRectMake(10, 10, scrollW-20, 20);
    regsTime_label.text = @"请输入注册时间范围";
    regsTime_label.backgroundColor = [UIColor whiteColor];
    regsTime_label.textColor = UIColorFromRGB(0x333333);
    regsTime_label.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:regsTime_label];
    [regsTime_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(money_label.mas_left);
        make.top.equalTo(_minMoneyTF.mas_bottom).offset(10);
    }];
    
    [self.minTimeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_minMoneyTF.mas_left);
        make.top.equalTo(regsTime_label.mas_bottom).offset(10);
        make.width.equalTo(_minMoneyTF.mas_width);
        make.height.equalTo(_minMoneyTF.mas_height);
    }];
    self.minTimeTF.text = @"0001/1/1";
    
    UIView *lin_2 = [[UIView alloc] init];
    lin_2.backgroundColor = [Tool gayLineColor];
    [_scrollView addSubview:lin_2];
    [lin_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lin_1.mas_centerX);
        make.centerY.equalTo(_minTimeTF.mas_centerY);
        make.height.equalTo(lin_1.mas_height);
        make.width.equalTo(lin_1.mas_width);
    }];
    
    [self.maxTimeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_maxMoneyTF.mas_right);
        make.centerY.equalTo(lin_2.mas_centerY);
        make.width.equalTo(_minTimeTF.mas_width);
        make.height.equalTo(_minTimeTF.mas_height);
    }];
    self.maxTimeTF.text = @"0001/1/1";
    
    //3.
    UILabel *regsInLT_label = [[UILabel alloc] init];
    regsInLT_label.text = @"是否在龙潭注册";
    regsInLT_label.backgroundColor = [UIColor whiteColor];
    regsInLT_label.textColor = UIColorFromRGB(0x333333);
    regsInLT_label.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:regsInLT_label];
    [regsInLT_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(money_label.mas_left);
        make.top.equalTo(_maxTimeTF.mas_bottom).offset(10);
    }];
    
    CGFloat jj = 10;
    
    [self.regsAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scrollView.mas_left).offset(jj);
        make.top.equalTo(regsInLT_label.mas_bottom).offset(10);
        make.width.mas_equalTo(radioBtnW);
        make.height.mas_equalTo(radioBtnH);
    }];
    
    
    [self.regsInLT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_regsAll.mas_right).offset(jj);
        make.top.equalTo(regsInLT_label.mas_bottom).offset(10);
        make.width.mas_equalTo(radioBtnW);
        make.height.mas_equalTo(radioBtnH);
    }];
    
    [self.regsOutLT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_regsInLT.mas_right).offset(jj);
        make.top.equalTo(regsInLT_label.mas_bottom).offset(10);
        make.width.mas_equalTo(radioBtnW);
        make.height.mas_equalTo(radioBtnH);
    }];
    
    //4.
    UILabel *taxInLT_label = [[UILabel alloc] init];
    taxInLT_label.text = @"是否在龙潭纳税";
    taxInLT_label.backgroundColor = [UIColor whiteColor];
    taxInLT_label.textColor = UIColorFromRGB(0x333333);
    taxInLT_label.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:taxInLT_label];
    [taxInLT_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(money_label.mas_left);
        make.top.equalTo(_regsInLT.mas_bottom).offset(10);
    }];
    
    [self.taxAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_regsAll.mas_left);
        make.top.equalTo(taxInLT_label.mas_bottom).offset(10);
        make.width.mas_equalTo(radioBtnW);
        make.height.mas_equalTo(radioBtnH);
    }];
    
    [self.taxToLT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_taxAll.mas_right).offset(jj);
        make.top.equalTo(taxInLT_label.mas_bottom).offset(10);
        make.width.mas_equalTo(radioBtnW);
        make.height.mas_equalTo(radioBtnH);
    }];
    
    [self.taxNotLT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_regsOutLT.mas_centerX);
        make.top.equalTo(taxInLT_label.mas_bottom).offset(10);
        make.width.mas_equalTo(radioBtnW);
        make.height.mas_equalTo(radioBtnH);
    }];
    
    //5.
    UILabel *workInLT_label = [[UILabel alloc] init];
    workInLT_label.text = @"是否在龙潭办公";
    workInLT_label.backgroundColor = [UIColor whiteColor];
    workInLT_label.textColor = UIColorFromRGB(0x333333);
    workInLT_label.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:workInLT_label];
    [workInLT_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(money_label.mas_left);
        make.top.equalTo(_taxToLT.mas_bottom).offset(10);
    }];
    
    [self.workAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_regsAll.mas_left);
        make.top.equalTo(workInLT_label.mas_bottom).offset(10);
        make.width.mas_equalTo(radioBtnW);
        make.height.mas_equalTo(radioBtnH);
    }];
    
    [self.workInLT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_regsInLT.mas_centerX);
        make.top.equalTo(workInLT_label.mas_bottom).offset(10);
        make.width.mas_equalTo(radioBtnW);
        make.height.mas_equalTo(radioBtnH);
    }];
    
    [self.workOutLT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_regsOutLT.mas_centerX);
        make.top.equalTo(workInLT_label.mas_bottom).offset(10);
        make.width.mas_equalTo(radioBtnW);
        make.height.mas_equalTo(radioBtnH);
    }];
    
    [self bottomButtons];
}

- (void)regsInTLClick:(SeleButtons *)button {
    if (button.selectting == 1) {
        return;
    }
    BOOL temp = 2;
    button.selectting = 1;
    if (_regsInLT == button) {
        _regsOutLT.selectting =temp;
        _regsAll.selectting = temp;
    } else if (_regsAll == button) {
        _regsInLT.selectting = temp;
        _regsOutLT.selectting = temp;
    } else {
        _regsInLT.selectting = temp;
        _regsAll.selectting = temp;
    }
}

- (void)taxToLTClick:(SeleButtons *)button {
    
    if (button.selectting == 1) {
        return;
    }
    BOOL temp = 2;
    button.selectting = 1;
    if (_taxAll == button) {
        _taxToLT.selectting = temp;
        _taxNotLT.selectting = temp;
    } else if (_taxToLT == button) {
        _taxNotLT.selectting = temp;
        _taxAll.selectting = temp;
    } else {
        _taxToLT.selectting = temp;
        _taxAll.selectting = temp;
    }
}

- (void)workInLTClick:(SeleButtons *)button {
    
    if (button.selectting == 1) {
        return;
    }
    
    BOOL temp = 2;
    button.selectting = 1;
    if (_workAll == button) {
        _workInLT.selectting = temp;
        _workOutLT.selectting = temp;
    } else if (_workInLT == button) {
        _workOutLT.selectting = temp;
        _workAll.selectting = temp;
    } else {
        _workInLT.selectting = temp;
        _workAll.selectting = temp;
    }
}

- (void)bottomButtons {
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width ;
    CGFloat shadowW = 100.0;
    CGFloat h = CGRectGetHeight(self.view.bounds);
    
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, shadowW, h)];
    shadow.userInteractionEnabled = YES;
    [shadow addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleEvent)]];
    shadow.backgroundColor = [UIColor clearColor];
    [self.view addSubview:shadow];
    
//    UIView *shadow_content = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shadow.frame), 0, screenWidth-shadowW, h)];
//    shadow_content.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:shadow_content];
    
    CGFloat btnW =  (screenWidth-shadowW) / 2.0-1.0;
    CGFloat btnH = _bottomH;
    CGFloat btnX = CGRectGetMaxX(shadow.frame);
    CGFloat btnY = CGRectGetMaxY(self.view.frame)-btnH - 64;
    NSArray *arr = @[@"重置",@"确定"];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[Tool imageWithColor:UIColorFromRGB(0xf7f7f7)] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[Tool imageWithColor:[Tool blueColor]] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(submitEvent:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(btnX + (1.0 + btnW)*i, btnY, btnW, btnH);
        button.tag = 100 + i;
        if (i == 0) {
            //            button
        } else {
            
        }
        
        [self.view addSubview:button];
        
        [_buttonArr addObject:button];
        
    }
}

- (void)cancleEvent {
    
    
    if (_removeSearchView) {
        _removeSearchView(@"2222");
    }
}

- (void)submitEvent:(UIButton *)button {
    
    if (button.tag == 101) {
        
        if (_minMoneyTF.text == nil || _minMoneyTF.text.length == 0) {
            [Tool startAnimationWithMessage:@"请完善注册金额" showTime:1.0 onView:self.view];
            return;
        }
        
        if (_maxMoneyTF.text == nil || _maxMoneyTF.text.length == 0) {
            [Tool startAnimationWithMessage:@"请完善注册金额" showTime:1.0 onView:self.view];
            return;
        }
        
        if (_minTimeTF.text == nil || _minTimeTF.text.length == 0) {
            [Tool startAnimationWithMessage:@"请完善注册时间" showTime:1.0 onView:self.view];
            return;
        }
        
        if (_maxMoneyTF.text == nil || _maxMoneyTF.text.length == 0) {
            [Tool startAnimationWithMessage:@"请完善注册时间" showTime:1.0 onView:self.view];
            return;
        }
        
        if (_regsAll.selected == NO && _regsInLT.selected == NO && _regsOutLT.selected == NO) {
            [Tool startAnimationWithMessage:@"请选择注册地点" showTime:1.0 onView:self.view];
            return;
        }
        
        if (_taxAll.selected == NO && _taxToLT.selected == NO && _taxNotLT.selected == NO) {
            [Tool startAnimationWithMessage:@"请选择纳税地点" showTime:1.0 onView:self.view];
            return;
        }
        
        if (_workAll.selected == NO && _workInLT.selected == NO && _workOutLT.selected == NO) {
            [Tool startAnimationWithMessage:@"请选择办公地点" showTime:1.0 onView:self.view];
            return;
        }
        
        CGFloat minMon = [_minMoneyTF.text floatValue];
        CGFloat maxMon = [_maxMoneyTF.text floatValue];
        
        if (minMon > maxMon) {
            [Tool startAnimationWithMessage:@"最大金额不能小于最大金额" showTime:1.0 onView:self.view];
            return;
        }
        
        NSInteger regsIndex = 0;
        if (_regsInLT.selected) {
            regsIndex = 1;
        } else if (_regsOutLT.selected) {
            regsIndex = 2;
        }
        NSInteger taxIndex = 0;
        if (_taxToLT.selected) {
            taxIndex = 1;
        } else if (_taxNotLT.selected) {
            taxIndex = 2;
        }
        NSInteger workIndex = 0;
        if (_workInLT.selected) {
            workIndex = 1;
        } else if (_workOutLT.selected) {
            workIndex = 2;
        }
        
        NSDictionary *param = @{@"beginRegisteredFunds":_minMoneyTF.text,
                                @"endRegisteredFunds":_maxMoneyTF.text,
                                @"beginRegistrationTime":_minTimeTF.text,
                                @"endRegistrationTime":_maxTimeTF.text,
                                @"isRegisterCH":@(regsIndex),
                                @"isPayTaxesInCH":@(taxIndex),
                                @"isWorkCH":@(workIndex)
                                };
        
        if (_removeSearchView) {
            _removeSearchView(param);
        }
    } else {
        //重置
        _minMoneyTF.text = @"";
        _maxMoneyTF.text = @"";
        _minTimeTF.text = @"";
        _maxTimeTF.text = @"";
        _regsInLT.selected = NO;
        _regsOutLT.selected = NO;
        _regsAll.selected = NO;
        _taxToLT.selected = NO;
        _taxNotLT.selected = NO;
        _taxAll.selected = NO;
        _workInLT.selected = NO;
        _workOutLT.selected = NO;
        _workAll.selected = NO;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    _tfIndex = textField.tag;
    
    SelectTimeView *timeView = [[SelectTimeView alloc]init];
    timeView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
    timeView.backgroundColor = [UIColor clearColor];
    timeView.delegate = self;
    timeView.curDate=[NSDate date];
    [[Tool windowView] addSubview:timeView];
    return NO;
}

-(void)didFinishPickView:(NSString*)date {
    if (_tfIndex == 1000) {
        _minTimeTF.text = date;
    } else if (_tfIndex == 1001) {
        _maxTimeTF.text = date;
    }
}

- (UITextField *)minMoneyTF {
    if (!_minMoneyTF) {
        _minMoneyTF = [[UITextField alloc] init];
        _minMoneyTF.borderStyle = UITextBorderStyleRoundedRect;
        _minMoneyTF.backgroundColor = [UIColor whiteColor];
        _minMoneyTF.font = [UIFont systemFontOfSize:16];
        _minMoneyTF.textColor = UIColorFromRGB(0x666666);
        [_scrollView addSubview:_minMoneyTF];
    }
    return _minMoneyTF;
}

- (UITextField *)maxMoneyTF {
    if (!_maxMoneyTF) {
        _maxMoneyTF = [[UITextField alloc] init];
        _maxMoneyTF.borderStyle = UITextBorderStyleRoundedRect;
        _maxMoneyTF.backgroundColor = [UIColor whiteColor];
        _maxMoneyTF.font = [UIFont systemFontOfSize:16];
        _maxMoneyTF.textColor = UIColorFromRGB(0x666666);
        [_scrollView addSubview:_maxMoneyTF];
    }
    return _maxMoneyTF;
}

- (UITextField *)minTimeTF {
    if (!_minTimeTF) {
        _minTimeTF = [[UITextField alloc] init];
        _minTimeTF.borderStyle = UITextBorderStyleRoundedRect;
        _minTimeTF.backgroundColor = [UIColor whiteColor];
        _minTimeTF.font = [UIFont systemFontOfSize:16];
        _minTimeTF.textColor = UIColorFromRGB(0x666666);
        _minTimeTF.tag = 1000;
        _minTimeTF.delegate = self;
        [_scrollView addSubview:_minTimeTF];
    }
    return _minTimeTF;
}

- (UITextField *)maxTimeTF {
    if (!_maxTimeTF) {
        _maxTimeTF = [[UITextField alloc] init];
        _maxTimeTF.borderStyle = UITextBorderStyleRoundedRect;
        _maxTimeTF.backgroundColor = [UIColor whiteColor];
        _maxTimeTF.font = [UIFont systemFontOfSize:16];
        _maxTimeTF.textColor = UIColorFromRGB(0x666666);
        _maxTimeTF.tag = 1001;
        _maxTimeTF.delegate = self;
        [_scrollView addSubview:_maxTimeTF];
    }
    return _maxTimeTF;
}

//MARK:第一组
- (SeleButtons *)regsInLT {
    if (!_regsInLT) {
        _regsInLT = [SeleButtons buttonWithType:UIButtonTypeCustom];
        [_regsInLT setTitle:@"是" forState:UIControlStateNormal];
        _regsInLT.selectting = 2;
        [_regsInLT addTarget:self action:@selector(regsInTLClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_regsInLT];
    }
    return _regsInLT;
}

- (SeleButtons *)regsOutLT {
    if (!_regsOutLT) {
        _regsOutLT = [SeleButtons buttonWithType:UIButtonTypeCustom];
        [_regsOutLT setTitle:@"否" forState:UIControlStateNormal];
        _regsOutLT.selectting = 2;
        [_regsOutLT addTarget:self action:@selector(regsInTLClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_regsOutLT];
    }
    return _regsOutLT;
}

- (SeleButtons *)regsAll {
    if (!_regsAll) {
        _regsAll = [SeleButtons buttonWithType:UIButtonTypeCustom];
        [_regsAll setTitle:@"所有" forState:UIControlStateNormal];
        _regsAll.selectting = 1;
        [_regsAll addTarget:self action:@selector(regsInTLClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_regsAll];
    }
    return _regsAll;
}
//MARK:第二组
- (SeleButtons *)taxToLT {
    if (!_taxToLT) {
        _taxToLT = [SeleButtons buttonWithType:UIButtonTypeCustom];
        [_taxToLT setTitle:@"是" forState:UIControlStateNormal];
        _taxToLT.selectting = 2;
        [_taxToLT addTarget:self action:@selector(taxToLTClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_taxToLT];
    }
    return _taxToLT;
}

- (SeleButtons *)taxNotLT {
    if (!_taxNotLT) {
        _taxNotLT = [SeleButtons buttonWithType:UIButtonTypeCustom];
        [_taxNotLT setTitle:@"否" forState:UIControlStateNormal];
        _taxNotLT.selectting = 2;
        [_taxNotLT addTarget:self action:@selector(taxToLTClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_taxNotLT];
    }
    return _taxNotLT;
}

- (SeleButtons *)taxAll {
    if (!_taxAll) {
        _taxAll = [SeleButtons buttonWithType:UIButtonTypeCustom];
        [_taxAll setTitle:@"所有" forState:UIControlStateNormal];
        _taxAll.selectting = 1;
        [_taxAll addTarget:self action:@selector(taxToLTClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_taxAll];
    }
    return _taxAll;
}
//MARK:第三组
- (SeleButtons *)workInLT {
    if (!_workInLT) {
        _workInLT = [SeleButtons buttonWithType:UIButtonTypeCustom];
        [_workInLT setTitle:@"是" forState:UIControlStateNormal];
        _workInLT.selectting = 2;
        [_workInLT addTarget:self action:@selector(workInLTClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_workInLT];
    }
    return _workInLT;
}

- (SeleButtons *)workOutLT {
    if (!_workOutLT) {
        _workOutLT = [SeleButtons buttonWithType:UIButtonTypeCustom];
        [_workOutLT setTitle:@"否" forState:UIControlStateNormal];
        _workOutLT.selectting = 2;
        [_workOutLT addTarget:self action:@selector(workInLTClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_workOutLT];
    }
    return _workOutLT;
}

- (SeleButtons *)workAll {
    if (!_workAll) {
        _workAll = [SeleButtons buttonWithType:UIButtonTypeCustom];
        [_workAll setTitle:@"所有" forState:UIControlStateNormal];
        _workAll.selectting = 1;
        [_workAll addTarget:self action:@selector(workInLTClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_workAll];
    }
    return _workAll;
}

- (UIImage *)getSelectedRadioImage {
    return [UIImage imageNamed:@"radio_red.png"];
}

- (UIImage *)getNormalRadioImage {
    return [UIImage imageNamed:@"radio_gay.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
