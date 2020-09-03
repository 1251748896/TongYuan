//
//  ImageListViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/18.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "ImageListViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h> // kUTTypeMovie 参数需要
#import <Photos/Photos.h>
//七牛相关
#import <QiniuSDK.h>
#import "ImgvListCell.h"
#import "MediumView.h"
#import "ImgVideoModel.h"
static NSString *const cellIdentifier = @"cell";
@interface ImageListViewController ()<UIWebViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MediumViewDelegate>
{
    NSString *_picDesribeStr;
}
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSInteger page;
@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) MediumView *bottomView;
@property (nonatomic) NSOperationQueue *queue;
@end

@implementation ImageListViewController
- (instancetype)initProjectId:(NSString *)projectId
{
    self = [super init];
    if (self) {
        _ProjectID = projectId;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [Tool gayBgColor];
    _dataArray = [NSMutableArray arrayWithCapacity:20];
    _picDesribeStr = @"";
    if (_ProjectID == nil) {
        _ProjectID = @"";
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH/2.0, 160);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-(64+60+20+50)) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = YES;
    //    _collectionView.backgroundColor = [Tool gayBgColor];
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[ImgvListCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    WeakObj(self)
    // 2.下拉刷新
    self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 1;
        [weakself initializeDataSource];
    }];
    
    [self initializeDataSource];
    _bottomView = [[MediumView alloc] init];
    _bottomView.frame = CGRectMake(0, CGRectGetMaxY(_collectionView.frame), SCREEN_WIDTH, 50+20+70+40);
    _bottomView.titleStr = @"请输入描述信息";
    _bottomView.backgroundColor = [Tool gayBgColor];
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
}


#pragma mark - <MediumViewDelegate>

- (void)currentDescribeStr:(NSString *)str {
    _picDesribeStr = str;
}

- (void)buttonIndex:(NSInteger)index {
    if ([self checkCameraPower] == NO) {
        return;
    }
    // 0:相册, 1:相机, 2:视频
    [self openCameraWithType:index];
}
- (void)showFunctionView {
    static BOOL show = YES;
    CGRect frame = _bottomView.frame;
    
    if (show) {
        frame.origin.y -= 20+70+40;
    } else {
        frame.origin.y += 20+70+40;
    }
    show = !show;
    [UIView animateWithDuration:0.25 animations:^{
        _bottomView.frame = frame;
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([Tool tool].imgListRefreshCode == [Tool imgVideoRefreshCode]) {
        [self initializeDataSource];
    }
    
}

- (void)initializeDataSource {
    WeakObj(self)
    // api/Project/GetProjectFileList
    NSString *url = [NSString stringWithFormat:@"%@api/Project/GetProjectFileList",BASEURL];
    NSDictionary *param = @{@"projectID":_ProjectID,@"fileType":@"1"};
    [NetManager getWithURL:url params:param animation:YES success:^(id obj) {
        
        NSLog(@"kkk = %@",obj);
        
        [Tool tool].imgListRefreshCode = 0;
        [weakself.dataArray removeAllObjects];
        
        [weakself.collectionView.mj_header endRefreshing];
        [weakself.collectionView.mj_footer endRefreshing];
        if ([obj isKindOfClass:[NSArray class]]) {
            for (NSDictionary *d in obj) {
                ImgVideoModel *model = [[ImgVideoModel alloc] initWithDictionary:d];
                [weakself.dataArray addObject:model];
            }
        }
        
        for (int i=0; i<weakself.dataArray.count; i++) {
            NSIndexPath *indxPath = [NSIndexPath indexPathForItem:i inSection:0];
            [weakself downloadImg:indxPath];
        }
        
        [weakself.collectionView reloadData];
    } failure:^(NSError *error) {
        
        [weakself.collectionView.mj_header endRefreshing];
        [weakself.collectionView.mj_footer endRefreshing];
    }];
}

- (NSOperationQueue *)queue {
    if (!_queue) _queue = [[NSOperationQueue alloc] init];
    return _queue;
}

- (void)downloadImg:(NSIndexPath *)indexPath {
    
    ImgVideoModel *model = self.dataArray[indexPath.row]; //取得改行对应的模型
    if ([model.picImage isKindOfClass:[UIImage class]]) {
        return;
    }
    
    WeakObj(self)
    [self.queue addOperationWithBlock: ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.FilePath]]; //得到图像数据
        UIImage *image = [UIImage imageWithData:imgData];
        image = [Tool compressImageWith:image];
        
        //在主线程中更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
            //通过修改模型, 来修改数据
            model.picImage = image;
            //刷新指定表格行
            
            [weakself.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            
        }];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImgvListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    ImgVideoModel *model = self.dataArray[indexPath.item];
    
    cell.imgUrl = model.FilePath ;
    
    if ([model.picImage isKindOfClass:[UIImage class]]) {
        cell.imageView.image = model.picImage;
    } else {
        cell.imageView.image = [Tool getBigPlaceholderImage];
    }
    cell.imgModelArr = self.dataArray ;
    cell.imgIndex = indexPath.item ;
    
    cell.nameLabel.text = model.FileDescribe ;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - <提交图片>

- (void)postDataToServer:(NSString *)urls fileName:(NSString *)fileName isImg:(BOOL)isImg {
    
    NSString *fileType = (isImg == YES? @"1":@"2");
    
    NSString *url = [NSString stringWithFormat:@"%@api/Project/SaveUploadFile",BASEURL];
    NSDictionary *param = @{@"projectID":_ProjectID,
                            @"fileName":fileName,
                            @"filePath":urls,
                            @"fileType":fileType,
                            @"fileDescribe":_picDesribeStr,
                            @"fileSize":@"未知",
                            };
    
    WeakObj(self)
    
    [NetManager postWithURL:url params:param animation:YES success:^(id obj) {
        
        if (isImg == NO) {
            [Tool tool].videoListRefreshCode = [Tool imgVideoRefreshCode];
        }
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            
            if (isImg) {
                [weakself initializeDataSource];
            }
        }
    } failure:^(NSError *error) {
        [UIAlertView showAlertViewWithMessage:@"上传失败,请检查网络或重新上传"];
    }];
}

- (void)startAnimation {
    [MBProgressHUD showHUDAddedTo:[Tool windowView] animated:YES];
}

- (void)stopAnnimation {
    [MBProgressHUD hideHUDForView:[Tool windowView] animated:YES];
}

- (void)uploadImageToQN:(UIImage *)img {
    [self startAnimation];
    NSData *imageData = UIImagePNGRepresentation(img);
    
    NSString *accessKey = [QNYTools getQNAppAK];
    NSString *secretKey = [QNYTools getQNAppSK];
    
    NSString *fileName = [QNYTools getImageFileName];
    NSString *bucket = [QNYTools getBucket];
    NSString *token = [QNYTools makeToken:accessKey secretKey:secretKey bucket:bucket key:fileName];
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    NSString *domain = [QNYTools getQNDomain];
    WeakObj(self)
    [upManager putData:imageData key:fileName token:token complete: ^(QNResponseInfo *info,NSString *key, NSDictionary *resp) {
        
        [weakself stopAnnimation];
        if (resp) {
            NSString *urls = [NSString stringWithFormat:@"http://%@/%@",domain,fileName];
            [weakself postDataToServer:urls fileName:fileName isImg:YES];
        } else {
            [UIAlertView showAlertViewWithMessage:@"请检查网路连接，或重新上传"];
        }
        
    } option:nil];
    
}

#pragma mark - <提交视频>

- (void)uploadVideo:(NSURL *)mp4Url {
    [Tool startAnimation];
    NSData *data = [NSData dataWithContentsOfFile:mp4Url.absoluteString];
    
    NSString *accessKey = [QNYTools getQNAppAK];
    NSString *secretKey = [QNYTools getQNAppSK];
    
    NSString *tempsoluteStr = mp4Url.absoluteString;
    
    NSArray *soluteArray = [tempsoluteStr componentsSeparatedByString:@"/"];
    
    NSString *fileName = @"";
    if (soluteArray.count) {
        fileName = [NSString stringWithFormat:@"%@_%@",[QNYTools getVideoFileName],[soluteArray lastObject]];
    } else {
        fileName = @"video__kk__ios.mp4";
    }
    
    NSString *bucket = [QNYTools getBucket];
    NSString *token = [QNYTools makeToken:accessKey secretKey:secretKey bucket:bucket key:fileName];
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSString *domain = [QNYTools getQNDomain];
    // data不对
    [Tool startAnimation];
    WeakObj(self)
    [upManager putData:data key:fileName token:token complete: ^(QNResponseInfo *info,NSString *key, NSDictionary *resp) {
        if (resp) {
            NSString *urlStr = [NSString stringWithFormat:@"http://%@/%@",domain,fileName];
            // 提交服务器
            [weakself postDataToServer:urlStr fileName:fileName isImg:NO];
        } else {
            [UIAlertView showAlertViewWithMessage:@"请检查网路连接，或重新上传"];
        }
        [Tool stopAnimation];
    } option:nil];
}


#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    WeakObj(self)
    //照片的详细信息 ，可在这里处理照片 或者视频
    [picker dismissViewControllerAnimated:YES completion:^{
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:@"public.image"]) {
            UIImage *image = info[UIImagePickerControllerEditedImage];
            image = [Tool compressImageWith:image];
            [weakself uploadImageToQN:image];
        } else if ([mediaType isEqualToString:@"public.movie"]) {
            NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
            [self movToMP4Url:videoURL];
        }
        [weakself showFunctionView];
    }];
    
}
- (void)movToMP4Url:(NSURL *)sourceUrl
{
    WeakObj(self)
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:sourceUrl options:nil];
    NSArray *compatiblePresets=[AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    // NSLog(@"%@",compatiblePresets);
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession=[[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
        
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        
        NSString *fileName = timeSp;
        NSString *resultPath=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingFormat:@"/video%@ios.mp4",fileName];
        
        exportSession.outputURL=[NSURL fileURLWithPath:resultPath];
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void){
            switch (exportSession.status) {
                case AVAssetExportSessionStatusCancelled:
                    NSLog(@"AVAssetExportSessionStatusCancelled");
                    break;
                case AVAssetExportSessionStatusUnknown:
                    NSLog(@"AVAssetExportSessionStatusUnknown");
                    break;
                case AVAssetExportSessionStatusWaiting:
                    NSLog(@"AVAssetExportSessionStatusWaiting");
                    break;
                case AVAssetExportSessionStatusExporting:
                    NSLog(@"AVAssetExportSessionStatusExporting");
                    break;
                case AVAssetExportSessionStatusCompleted:
                {
                    NSLog(@"转换成功");
                    NSURL *newUrl = [NSURL URLWithString:resultPath];
                    dispatch_queue_t mainQueue = dispatch_get_main_queue();
                    dispatch_async(mainQueue, ^{
                        [weakself uploadVideo:newUrl];
                    });
                    break;
                }
                case AVAssetExportSessionStatusFailed:
                    NSLog(@"AVAssetExportSessionStatusFailed");
                    break;
            }
        }];
    }
}
#pragma mark - 检查权限

- (BOOL)checkCameraPower {
    //检查权限
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        PHAuthorizationStatus author = [PHPhotoLibrary authorizationStatus];
        if (author == PHAuthorizationStatusRestricted || author == PHAuthorizationStatusDenied) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户拒绝访问" message:@"请进入“设置-隐私-相册-打开app权限开关“，以正常选择相册图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        return YES;
    } else {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户拒绝访问" message:@"请进入“设置-隐私-相册-打开app权限开关“，以正常选择相册图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        return YES;
    }
}

#pragma mark - 打开相机

- (void)openCameraWithType:(NSInteger)type {
    //判断设备是否有摄像头
    BOOL haveCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (haveCamera) {
        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        vc.delegate = self;
        if (type == 0) {
            vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        } else if (type == 1) {
            vc.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else if (type == 2) {
            //来自相机
            vc.sourceType = UIImagePickerControllerSourceTypeCamera;
            vc.videoQuality = UIImagePickerControllerQualityType640x480;
            vc.videoMaximumDuration = 10.0;
            vc.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
        }
        
        vc.allowsEditing = YES;
        [self presentViewController:vc animated:YES completion:^{
        }];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"该设备无相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
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
