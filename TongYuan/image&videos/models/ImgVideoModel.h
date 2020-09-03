//
//  ImgVideoModel.h
//  TongYuan
//
//  Created by apple on 2017/12/24.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "BaseModel.h"

@interface ImgVideoModel : BaseModel

@property (nonatomic, copy) NSString *APFID;
@property (nonatomic, copy) NSString *FileDescribe;
@property (nonatomic, copy) NSString *FileName;
@property (nonatomic, copy) NSString *FilePath;
@property (nonatomic, copy) NSString *FileSize;
@property (nonatomic, copy) NSString *FileType;
@property (nonatomic, copy) NSString *ProjectID;
@property (nonatomic, copy) NSString *UploadTime;


@property (nonatomic) UIImage *videoImage ;
@property (nonatomic) UIImage *picImage ;

@end
