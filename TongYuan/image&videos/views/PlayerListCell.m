//
//  PlayerListCell.m
//  TongYuan
//
//  Created by apple on 2017/12/24.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "PlayerListCell.h"

@interface PlayerListCell()
@property (nonatomic) ZGLVideoPlyer *player; //
@end

@implementation PlayerListCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImageViewUI];
    }
    return self;
}

- (void)setImageViewUI {
    
    self.contentView.backgroundColor = [Tool gayBgColor];
    
    CGFloat xx = 10.0;
    _imageView = [[UIImageView alloc] init];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
    [self.contentView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(xx);
        make.left.equalTo(self.contentView.mas_left).offset(xx);
        make.right.equalTo(self.contentView.mas_right).offset(-xx);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-30);
    }];
    
    UIImageView *xiaoImgv = [[UIImageView alloc] init] ;
    xiaoImgv.image = [UIImage imageNamed:@"playerIcon.png"];
    [_imageView addSubview:xiaoImgv];
    [xiaoImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_imageView.mas_centerX);
        make.centerY.equalTo(_imageView.mas_centerY);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = UIColorFromRGB(0x404040);
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_left);
        make.right.equalTo(_imageView.mas_right);
        make.top.equalTo(_imageView.mas_bottom);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (void)imageClick {
    [self startPlaying:_videoUrl];
}

- (void)startPlaying:(NSString *)url {
    
    UIView *vi = [[UIView alloc] init];
    vi.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
    vi.backgroundColor = [UIColor blackColor];
    vi.userInteractionEnabled = YES;
    [vi addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remmmmm:)]];
    //  NSString *url = @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    CGFloat playerH = 300;
    CGFloat playerY = SCREENH_HEIGHT /2.0 - playerH/2.0;
    self.player = [[ZGLVideoPlyer alloc]initWithFrame:CGRectMake(0, playerY, SCREEN_WIDTH, playerH)];
    self.player.videoUrlStr = url;
    
    
    [vi addSubview:self.player];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:vi];
    
}

- (void)remmmmm:(UITapGestureRecognizer *)tap {
    [self.player pause];
    
    for (UIView *vv in tap.view.subviews) {
        [vv removeFromSuperview];
    }
    [tap.view removeFromSuperview];
}

@end
