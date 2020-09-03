//
//  YQDataViewController.m
//  TongYuan
//
//  Created by apple on 2017/12/10.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "YQDataViewController.h"
#import "YQDataCollectionViewCell.h"

static NSString *cellIdtfer = @"cell";

@interface YQDataViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *dataArray;
@end

@implementation YQDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [Tool gayBgColor];
    self.navigationItem.title = @"园区生产经营数据";
    _dataArray = [NSMutableArray arrayWithCapacity:4];
    [self getData];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[YQDataCollectionViewCell class] forCellWithReuseIdentifier:cellIdtfer];
}

- (void)getData {
    NSString *url = [NSString stringWithFormat:@"%@api/Tax/OutputValue",BASEURL];
    [NetManager postWithURL:url params:nil animation:YES success:^(id obj) {
        NSLog(@"jjj = %@",obj);
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
    [_dataArray addObjectsFromArray:@[@{@"img":@"home-park-land",@"title":@"产值"},
                            @{@"img":@"home-project-schedule", @"title":@"主营业务收入"},
                            @{@"img":@"home-profits", @"title":@"利润"},
                            @{@"img":@"home-tax", @"title":@"税收"}
                            ]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat w = (collectionView.bounds.size.width)/2.0;
    CGFloat h = w * 0.75;
    
    return CGSizeMake(w, h);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YQDataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdtfer forIndexPath:indexPath];
    NSDictionary *d = self.dataArray[indexPath.item];
    BOOL left = indexPath.item % 2 == 1;
    cell.imgv.image = [UIImage imageNamed:d[@"img"]];
    cell.texLabel.text = d[@"title"];
    
    if (cell.tag != 10086) {
        CGFloat off = SCREEN_WIDTH * 0.1;
        
        [cell.imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            if (left) {
                make.left.equalTo(cell.contentView.mas_left).offset(off);
            } else {
                make.right.equalTo(cell.contentView.mas_right).offset(-off);
            }
        }];
        [cell.texLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.imgv.mas_centerX);
            make.top.equalTo(cell.imgv.mas_bottom).offset(10);
        }];
    }
    cell.tag = 10086;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *hStr = @"";
    if (indexPath.item == 0) {
        hStr = @"Taxs/OutputValue";
    } else if (indexPath.item == 3) {
        hStr = @"Taxs/TaxRevenue";
    } else if (indexPath.item == 1) {
        hStr = @"Taxs/Revenue";
    } else if (indexPath.item == 2) {
        hStr = @"Taxs/Profit";
    } else {
        return;
    }
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,hStr];
    WebViewController *vc = [[WebViewController alloc] initWithUrl:url];
    [self.navigationController pushViewController:vc animated:YES];
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
