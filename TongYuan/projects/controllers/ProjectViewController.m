//
//  ProjectViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/6.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "ProjectViewController.h"
#import "GoverModel.h"

#import "PorjectProcessController.h"
@interface ProjectViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *_navBtnArr ;
    UIView *_topLine;
    NSInteger _projectLandType;//征地型类型 1:征地型 6、非征地型
    NSArray *_landTypeStrArr;//标题
    NSInteger _projectStatus;//项目状态 1、待建 2、在建 3、竣工验收
}
@property (nonatomic) UIScrollView *navScroll ;
@property (nonatomic) UIView *btnFalgLine;

@property (nonatomic) NSMutableArray *lanTypeArray;

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic, copy) NSString *searchKey;

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _projectStatus = 1;
    _currentType = @"";
    _navBtnArr = [NSMutableArray arrayWithCapacity:11];
    _dataArray = [NSMutableArray arrayWithCapacity:6];
    _lanTypeArray = [NSMutableArray arrayWithCapacity:2];
    self.navigationItem.title = @"项目";
    self.view.backgroundColor = [Tool gayBgColor];
    
    
    [self initializeUserInterface];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initializaDataSource];
}

- (void)initializaDataSource {
    
    NSString *url = [NSString stringWithFormat:@"%@api/Project/GetProjectTypeNum",BASEURL];
    NSDictionary *param = @{@"projectStatus":@(_projectStatus)};
    WeakObj(self)
    [NetManager getWithURL:url params:param animation:YES success:^(id obj) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [weakself setValueWith:obj];
        }
    } failure:^(NSError *error) {
    }];
    
}

- (void)setValueWith:(NSDictionary *)obj {
    
    ProjectModel *model = [[ProjectModel alloc] initWithDictionary:obj];
    NSArray *arr = @[model.ExpropriaProjectNum,model.NoExpropriaProjectNum];
    int i = 0;
    for (UILabel *label in _lanTypeArray) {
        label.attributedText = [self getAttributeString:arr[i] indx:i];
        i++ ;
    }
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.DefalutPicUrl] placeholderImage:[Tool getBigPlaceholderImage]];
    
}

- (NSMutableAttributedString *)getAttributeString:(NSString *)companyConnt indx:(int)i {
    NSArray *info = @[@"征地型",@"非征地型"];
    NSString *companyCount = companyConnt;
    companyCount = [NSString stringWithFormat:@"%@家",companyCount];
    NSString *companyType = info[i];
    NSString *tex = [NSString stringWithFormat:@"%@%@",companyType,companyCount];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:tex];
    NSRange range = [tex rangeOfString:companyCount];
    [attr addAttribute:NSForegroundColorAttributeName value:[Tool blueColor] range:range];
    return attr;
}

- (void)initializeUserInterface {
    
    /*
     * 左边
     */
    
    CGFloat textfieldX = 12.0;
    CGFloat textfieldY = 12.0;
    UIImage *searchImage = [Tool textfieldSearchIconImage];
    UIImageView *imgv_icon = [[UIImageView alloc] init];
    imgv_icon.image = searchImage;
    imgv_icon.bounds = CGRectMake(0, 0, 20, 20);
    imgv_icon.contentMode = UIViewContentModeLeft;
    UITextField *searchTF = [[UITextField alloc] init];
    searchTF.borderStyle = UITextBorderStyleRoundedRect;
    searchTF.frame = CGRectMake(textfieldX, textfieldY, SCREEN_WIDTH-textfieldX*2, 30);
    searchTF.delegate = self;
    searchTF.placeholder = SearchTFPlaceholderTextProjectProjress;
    searchTF.font = [UIFont systemFontOfSize:13];
    searchTF.rightView = imgv_icon;
    searchTF.rightViewMode = UITextFieldViewModeAlways ;
    [self.view addSubview:searchTF];
    
    CGFloat scrollW = 120.0;
    _navScroll = [[UIScrollView alloc] init];
    _navScroll.backgroundColor = [UIColor whiteColor];
    _navScroll.frame = CGRectMake(0, CGRectGetMaxY(searchTF.frame)+textfieldY, scrollW, SCREENH_HEIGHT-64-49-44);
    _navScroll.delegate = self;
    _navScroll.showsVerticalScrollIndicator = NO;
    _navScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_navScroll];
    
    CGFloat linH = 1.0;
    CGFloat btnX = 0.0;
    CGFloat btnY = linH;
    CGFloat btnW = scrollW;
    CGFloat btnH = 40.0;
    
    
    int selectedIndx = 0;
    CGRect selectedBtnRect = CGRectZero;
    
    UIView *lin1 = [[UIView alloc] init];
    lin1.backgroundColor = [Tool gayLineColor];
    lin1.frame = CGRectMake(btnX, 0, btnW, linH/1.5);
    [_navScroll addSubview:lin1];
    _topLine = lin1 ;
    _projectStatus = 1;
    NSArray *arr = @[@"待建",@"在建",@"竣工验收"];
    _navScroll.contentSize = CGSizeMake(0, arr.count*(linH+btnH)+5);
    for (int i=0; i<arr.count; i++) {
        NSString *btnName = arr[i];
        if (i == selectedIndx) {
            _currentType = btnName ;
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(btnX, btnY+i*(btnH+linH), btnW, btnH);
        button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        button.selected = i == selectedIndx;
        if (button.selected) {
            selectedBtnRect = button.frame ;
        }
        [button setBackgroundImage:[Tool imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button setBackgroundImage:[Tool imageWithColor:self.view.backgroundColor] forState:UIControlStateSelected];
        button.tag = 300 + i;
        [button setTitleColor:UIColorFromRGB(0x404040) forState:UIControlStateNormal];
        [button setTitleColor:[Tool blueColor] forState:UIControlStateSelected];
        [button setTitle:btnName forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showDetailInfo:) forControlEvents:UIControlEventTouchUpInside];
        [_navScroll addSubview:button];
        [_navBtnArr addObject:button];
        
        UIView *lineee = [[UIView alloc] init];
        lineee.backgroundColor = self.view.backgroundColor;
        lineee.frame = CGRectMake(btnX, CGRectGetMaxY(button.frame), btnW, linH);
        [_navScroll addSubview:lineee];
    }
    
    _btnFalgLine = [[UIView alloc] init];
    _btnFalgLine.frame = CGRectMake(selectedBtnRect.origin.x+0.5, selectedBtnRect.origin.y, 2.0, selectedBtnRect.size.height);
    _btnFalgLine.backgroundColor = [Tool blueColor];
    [_navScroll addSubview:_btnFalgLine];
    
    /*
     * 右边
     */
//    GoverModel *model = self.dataArray[selectedIndx];
//    NSString *imgUrl = model.EnterpriseTypeIcon;
    
    CGFloat imgvX = CGRectGetMaxX(_navScroll.frame)+10.0;
    CGFloat imgvY = CGRectGetMinY(_navScroll.frame) + textfieldY;
    CGFloat imgvW = SCREEN_WIDTH-imgvX-10.0;
    CGFloat imgvH = 110.0/255.0 * imgvW;
    _imageView = [[UIImageView alloc] init];
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[Tool getBigPlaceholderImage]];
    _imageView.image = [Tool getBigPlaceholderImage];
    _imageView.frame = CGRectMake(imgvX, imgvY, imgvW, imgvH);
    _imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_imageView];
    
    UILabel *owerLabel = [UILabel new];
    owerLabel.font = [UIFont systemFontOfSize:14];
    owerLabel.textColor = UIColorFromRGB(0x999999);
    owerLabel.text = _currentType;
    [self.view addSubview:owerLabel];
    [owerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_imageView.mas_centerX);
        make.top.equalTo(_imageView.mas_bottom).offset(15);
    }];
    _currentTypeLabel = owerLabel ;
    
    for (int i=0; i<2; i++) {
        UIView *linee = [[UIView alloc] init];
        linee.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:linee];
        if (i == 0) {
            [linee mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(owerLabel.mas_centerY);
                make.height.mas_equalTo(1.0);
                make.width.mas_equalTo(SCREEN_WIDTH/7.7);
                make.right.equalTo(owerLabel.mas_left).offset(-10);
            }];
        } else if (i == 1) {
            [linee mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(owerLabel.mas_centerY);
                make.height.mas_equalTo(1.0);
                make.width.mas_equalTo(SCREEN_WIDTH/7.7);
                make.left.equalTo(owerLabel.mas_right).offset(10);
            }];
        }
    }
    
    CGFloat labelW = (imgvW-textfieldX) / 2.0;
    CGFloat labelH = 40.0;
    CGFloat labelY = CGRectGetMaxY(_imageView.frame) + 40.0;
    
    NSArray *info = @[@"征地型",@"非征地型"];
    
    for (int i=0; i<info.count; i++) {
        NSString *companyCount = @"0";
        companyCount = [NSString stringWithFormat:@"%@家",companyCount];
        NSString *companyType = info[i];
        NSString *tex = [NSString stringWithFormat:@"%@%@",companyType,companyCount];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:tex];
        NSRange range = [tex rangeOfString:companyCount];
        [attr addAttribute:NSForegroundColorAttributeName value:[Tool blueColor] range:range];
        UILabel *detal = [UILabel new];
        detal.font = [UIFont systemFontOfSize:14];
        detal.textColor = UIColorFromRGB(0x666666);
        detal.textAlignment = NSTextAlignmentCenter;
        detal.attributedText = attr;
        detal.userInteractionEnabled = YES;
        detal.tag = 100 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelGesture:)];
        [detal addGestureRecognizer:tap];
        detal.backgroundColor = [UIColor whiteColor];
        detal.layer.cornerRadius = 2.0;
        detal.layer.masksToBounds = YES;
        detal.numberOfLines = 0;
        detal.frame = CGRectMake(imgvX+(i%2)*(labelW+textfieldX), labelY+(i/2)*(labelH+textfieldX), labelW, labelH);
        [self.view addSubview:detal];
        
        [_lanTypeArray addObject:detal];
        
    }
}


- (void)showDetailInfo:(UIButton *)sender {
    if (sender.selected) return;
    
    BOOL show = sender.tag == 300;
    _topLine.hidden = !show;
    sender.selected = !sender.selected;
    for (UIButton *b in _navBtnArr) {
        if (b.selected && b != sender) {
            b.selected = !b.selected;
            break;
        }
    }
    CGRect tempRect = _btnFalgLine.frame;
    tempRect.origin.y = sender.frame.origin.y;
    [UIView animateWithDuration:0.25 animations:^{
        _btnFalgLine.frame = tempRect;
    }];
    
    //当前的类型
    _projectStatus = sender.tag - 300 + 1;
    _currentType = sender.titleLabel.text ;
    _currentTypeLabel.text = _currentType;
    [self initializaDataSource];
}

- (void)labelGesture:(UITapGestureRecognizer *)tap {
    /*
     1:征地型 6、非征地型
     */
    _projectLandType = tap.view.tag - 100 == 0? 1:6;
    [self pushToProcessVc];
}

- (void)pushToProcessVc {
    PorjectProcessController *vc = [[PorjectProcessController alloc] init];
    vc.projectStatus = _projectStatus;
    vc.projectLandType = _projectLandType;
    vc.searchKey = _searchKey;
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    SearchViewController *vc = [[SearchViewController alloc] init];
    WeakObj(self)
    vc.searchResult = ^(NSString *searchKey) {
        weakself.searchKey = searchKey;
        [weakself pushToProcessVc];
    };
    vc.type = SearchTypeProjectProjress;
    [self.navigationController pushViewController:vc animated:NO];
    
    return NO;
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
