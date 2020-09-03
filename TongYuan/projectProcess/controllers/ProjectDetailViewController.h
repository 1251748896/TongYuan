//
//  ProjectDetailViewController.h
//  TongYuan
//
//  Created by 姜波 on 2017/12/17.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseViewController.h"

@interface ProjectDetailViewController : BaseViewController
{
    UIImage *_selectedImage;
    NSURL *_videoURL;
}
@property (nonatomic, copy) NSString *ProjectName;
@property (nonatomic, copy) NSString *ProjectID;
@end
