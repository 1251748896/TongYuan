//
//  KeywordsView.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/11.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeywordsViewDelegate <NSObject>

- (void)beginSearchWithKeyWords:(NSString *)keyWords;


@end

@interface KeywordsView : UIView

@property (nonatomic) NSArray *dataArray;
@property (nonatomic, weak) id<KeywordsViewDelegate>delegate;


@end
