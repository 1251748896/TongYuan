//
//  MediumListViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/18.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "MediumListViewController.h"

#import "VideoListViewController.h"
#import "ImageListViewController.h"
@interface MediumListViewController ()
{
    NSMutableArray *_btnArr, *_labelArr, *_imgvArr;
    NSArray *_vcArr;
}

@property (nonatomic) VideoListViewController *videoVc;
@property (nonatomic) ImageListViewController *imgvVc;
@property (nonatomic) UIViewController *currentVc;

@end

@implementation MediumListViewController
- (void)dealloc {
    [Tool tool].imgListRefreshCode = 0;
    [Tool tool].videoListRefreshCode = 0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"项目图片";
    
    _btnArr = [NSMutableArray arrayWithCapacity:2];
    _labelArr = [NSMutableArray arrayWithCapacity:2];
    _imgvArr = [NSMutableArray arrayWithCapacity:2];
    
    
    CGFloat bb = 56.0 / 38.0 ;
    
    CGFloat viewX = 10.0;
    CGFloat viewY = 10.0;
    CGFloat viewW = (SCREEN_WIDTH-30.0) / 2.0;
    CGFloat viewH = 60.0;
    NSArray *arr = @[@"图片",@"视频"];
    NSArray *imgArr = @[@"img_gay_top.png",@"video_xiao_icon.png"];
    for (int i=0; i<2; i++) {
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        view.frame = CGRectMake(viewX+i*(viewW+viewX), viewY, viewW, viewH);
        
        [view setBackgroundImage:[Tool imageWithColor:[Tool gayBgColor]] forState:UIControlStateNormal];
        [view setBackgroundImage:[Tool imageWithColor:[Tool blueColor]] forState:UIControlStateSelected];
        [view addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        view.tag = 10 + i;
        [self.view addSubview:view];
        [_btnArr addObject:view];
        
        UIImage *imageeee = [UIImage imageNamed:imgArr[i]];
        UIImageView *imgv = [[UIImageView alloc] init];
        imgv.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imgv];
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.mas_centerX);
            make.top.equalTo(view.mas_top).offset(5);
            make.width.mas_equalTo(bb*25);
            make.height.mas_equalTo(25);
        }];
        [_imgvArr addObject:imgv];
        
        UILabel *labe = [[UILabel alloc] init];
        labe.text = arr[i];
        
        labe.font = [UIFont systemFontOfSize:16];
        [view addSubview:labe];
        [labe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.mas_centerX);
            make.bottom.equalTo(view.mas_bottom).offset(-5);
        }];
        [_labelArr addObject:labe];
        
        
        if (_isImage && i ==0) {
            view.selected = YES;
            labe.textColor = [UIColor whiteColor];
            imgv.image = imageeee;
        } else if (!_isImage && i == 1) {
            view.selected = YES ;
            labe.textColor = UIColorFromRGB(0x333333);
            imgv.image = [UIImage imageNamed:@"video_camera_white_icon.png"];
        } else {
            view.selected = NO;
            labe.textColor = UIColorFromRGB(0x333333);
            imgv.image = imageeee;
        }
        
    }
    
    CGFloat vcY = viewY + viewH + 10;
    CGFloat vcH = SCREENH_HEIGHT - vcY;
    _videoVc = [[VideoListViewController alloc] initProjectId:_ProjectID];
    _videoVc.view.frame = CGRectMake(0, vcY, SCREEN_WIDTH, vcH);
    [self addChildViewController:_videoVc];
    
    _imgvVc = [[ImageListViewController alloc] initProjectId:_ProjectID];
    _imgvVc.view.frame = _videoVc.view.frame;
    [self addChildViewController:_imgvVc];
    
    _vcArr = @[_imgvVc,_videoVc];
    
    if (_isImage) {
        _currentVc = _imgvVc;
        [self.view addSubview:_imgvVc.view];
    } else {
        _currentVc = _videoVc;
        [self.view addSubview:_videoVc.view];
    }
}

- (void)buttonClick:(UIButton *)button {
    
    if (button.selected) return;
    
    button.selected = !button.selected;
    
    for (UIButton *b in _btnArr) {
        if (b.selected && b != button) {
            b.selected = !b.selected;
            break;
        }
    }
    
    NSInteger indx = button.tag - 10;
    
    NSInteger unIndx = 1-indx;
    
    UILabel *labe = _labelArr[indx];
    labe.textColor = [UIColor whiteColor];
    UILabel *labe1 = _labelArr[unIndx];
    labe1.textColor = UIColorFromRGB(0x333333);
    
    if (indx == 1) {
        UIImageView *imgv = _imgvArr[1];
        imgv.image = [UIImage imageNamed:@"video_camera_white_icon.png"];
    } else {
        UIImageView *imgv = _imgvArr[1];
        imgv.image = [UIImage imageNamed:@"video_xiao_icon.png"];
    }
    
    [self changeVc:indx];
}

- (void)changeVc:(NSInteger)indx {
    UIViewController *toVc = _vcArr[indx];
    
    if ([_currentVc isKindOfClass:[toVc class]]) {
        return;
    }
    
    [self transitionFromViewController:_currentVc toViewController:toVc duration:0.25 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
    } completion:^(BOOL finished) {
        _currentVc = toVc;
    }];
    
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
