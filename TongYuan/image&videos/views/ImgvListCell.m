//
//  ImgvListCell.m
//  TongYuan
//
//  Created by apple on 2017/12/24.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "ImgvListCell.h"
#import "AlbumShowView.h"

#import "ImgVideoModel.h"

@implementation ImgvListCell
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
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgvTagMethood:)]];
    [self.contentView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(xx);
        make.left.equalTo(self.contentView.mas_left).offset(xx);
        make.right.equalTo(self.contentView.mas_right).offset(-xx);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-30);
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

// 点击查看大图
- (void)imgvTagMethood:(UITapGestureRecognizer *)tap {
    
    UIView *imgv = tap.view;
    CGRect frameInWindow = [imgv convertRect:imgv.frame toView:[Tool windowView]];
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:_imgModelArr.count];
    for (ImgVideoModel *m in _imgModelArr) {
        [tempArr addObject:m.FilePath];
    }
    
    AlbumShowView *album = [[AlbumShowView alloc] init];
    album.frame = frameInWindow;
    album.hiddenRect = frameInWindow;
    album.backgroundColor = [UIColor blackColor];
        
    album.imageArray = tempArr;
    album.curIndx = _imgIndex;
    [[Tool windowView] addSubview:album];
    album.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
    
}
@end
