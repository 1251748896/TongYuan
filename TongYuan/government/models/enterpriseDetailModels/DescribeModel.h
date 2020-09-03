//
//  DescribeModel.h
//  TongYuan
//
//  Created by apple on 2017/12/19.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseModel.h"

@interface DescribeModel : BaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *destring;
@property (nonatomic, copy) NSString *showBtn;//记录是否需要显示“详情”按钮
@property (nonatomic, copy) NSString *showing;//记录在显示的状态下，是否为 展开状态
@property (nonatomic, copy) NSString *describeSimpleLabelH ;
@property (nonatomic, copy) NSString *describeDetailLabelH ;
/*
 * 记录当前cell的高度
 * 0 ~ 4排文字的高度
 * 文字超过4排，也只有4排的高度
 */
@property (nonatomic, copy) NSString *desCellH ;

/*
 * 记录当前cell全部文字的高度
 * 当文字 小于 5排的时候，desCellH = desDetailCellH ;
 */
@property (nonatomic, copy) NSString *desDetailCellH ;//全部文字的高度
@end
