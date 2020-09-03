//
//  SearchViewController.m
//  TongYuan
//
//  Created by 姜波 on 2017/12/9.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "SearchViewController.h"
#import "KeywordsView.h"

static NSString *const LandName = @"SearchTypeLandName"; //项目用地
static NSString *const SpaceLand = @"SearchTypeSpaceLand"; //空地情况
static NSString *const ProjectProjress = @"SearchTypeProjectProjress" ;//项目进度、项目大类
static NSString *const EnterpriseList = @"SearchTypeEnterpriseList";  //企业列表、企业大类
static NSString *const ProductEngageData = @"SearchTypeProductEngageData"; //生产经营数据
static NSString *const ProductList = @"SearchTypeProductList"; //产品大类、产品列表
@interface SearchViewController ()<UITextFieldDelegate,KeywordsViewDelegate>
@property (nonatomic) UITextField *searchTF;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搜索";
    self.view.backgroundColor = [Tool gayBgColor];
    CGFloat textfieldX = 12.0;
    CGFloat textfieldY = 12.0;
    UIImage *searchImage = [Tool textfieldSearchIconImage];
    UIImageView *imgv_icon = [[UIImageView alloc] init];
    imgv_icon.image = searchImage;
    imgv_icon.userInteractionEnabled = YES;
    [imgv_icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchEvent)]];
    imgv_icon.bounds = CGRectMake(0, 0, 20, 20);
    imgv_icon.contentMode = UIViewContentModeLeft;
    UITextField *searchTF = [[UITextField alloc] init];
    searchTF.borderStyle = UITextBorderStyleRoundedRect;
    searchTF.frame = CGRectMake(textfieldX, textfieldY, SCREEN_WIDTH-textfieldX*2, 30);
    searchTF.placeholder = [self getPlaceholderTex];
    searchTF.font = [UIFont systemFontOfSize:13];
    searchTF.rightView = imgv_icon;
    searchTF.delegate = self;
    searchTF.keyboardType = UIKeyboardTypeWebSearch;
    searchTF.returnKeyType = UIReturnKeySearch;
    searchTF.rightViewMode = UITextFieldViewModeAlways ;
    [self.view addSubview:searchTF];
    _searchTF = searchTF;
    UILabel *titLabel = [[UILabel alloc] init];
    titLabel.text = @"搜索历史";
    titLabel.frame = CGRectMake(textfieldX, CGRectGetMaxY(searchTF.frame)+12, 120, 20);
    titLabel.font = [UIFont boldSystemFontOfSize:15];
    titLabel.textColor = UIColorFromRGB(0x666666);
    [self.view addSubview:titLabel];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *historyK = [self getHistoryKey];
    
    NSArray *historyKeyArr = [def objectForKey:historyK];
    
    if ([historyKeyArr isKindOfClass:[NSArray class]]) {
        if (historyKeyArr.count) {
            KeywordsView *historyView = [[KeywordsView alloc] init];
            historyView.frame = CGRectMake(textfieldX, CGRectGetMaxY(titLabel.frame)+12.0, SCREEN_WIDTH-textfieldX*2, 400);
            historyView.delegate = self;
            historyView.dataArray = historyKeyArr;
            historyView.backgroundColor = [UIColor clearColor];
            [self.view addSubview:historyView];
        }
    }
}

- (NSString *)getHistoryKey {
   
    if (_type == SearchTypeLandName) {
        return LandName;
    } else if (_type == SearchTypeSpaceLand) {
        return SpaceLand;
    } else if (_type == SearchTypeProjectProjress) {
        return ProjectProjress;
    } else if (_type == SearchTypeEnterpriseList) {
        return EnterpriseList;
    } else if (_type == SearchTypeProductEngageData) {
        return ProductEngageData;
    } else if (_type == SearchTypeProductList) {
        return ProductList;
    }
    return @"";
}

- (NSString *)getPlaceholderTex {
    
    /*
     SearchTypeLandName ,//项目用地
     SearchTypeSpaceLand ,//空地情况
     SearchTypeProjectProjress ,//项目进度、项目大类
     
     SearchTypeEnterpriseList , //企业列表、企业大类
     SearchTypeProductEngageData ,//生产经营数据
     SearchTypeProductList ,//产品大类、产品列表
     */
    if (_type == SearchTypeLandName) {
        return SearchTFPlaceholderTextLandName;
    } else if (_type == SearchTypeSpaceLand) {
        return SearchTFPlaceholderTextSpaceLand;
    } else if (_type == SearchTypeProjectProjress) {
        return SearchTFPlaceholderTextProjectProjress;
    } else if (_type == SearchTypeEnterpriseList) {
        return SearchTFPlaceholderTextEnterpriseList;
    } else if (_type == SearchTypeProductEngageData) {
        return SearchTFPlaceholderTextProductEngageData;
    } else if (_type == SearchTypeProductList) {
        return SearchTFPlaceholderTextProductList;
    }
    
    return @"请输入关键字搜索";
}

- (void)searchEvent {
    
    if (_searchTF.text == nil) {
        _searchTF.text = @"";
    }
    if (_searchTF.text.length == 0) {
        _searchTF.text = @"";
    }
    
    if (_searchResult) {
        /*
         1.读取本地历史
         2.添加这次搜索记录
         */
        
        if (_searchTF.text.length != 0) {
            
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            
            NSString *historyK = [self getHistoryKey];
            
            NSArray *oldArr = [def objectForKey:historyK];
            
            if ([oldArr isKindOfClass:[NSArray class]]) {
                NSMutableArray *newArr = [NSMutableArray arrayWithArray:oldArr];
                
                if (newArr.count >= 19) {
                    
                    NSInteger cou = newArr.count - 19 ;
                    
                    for (int i=0; i<cou; i++) {
                        [newArr removeObjectAtIndex:0];
                    }
                }
                
                [newArr addObject:_searchTF.text];
                [def setObject:newArr forKey:historyK];
                [def synchronize];
            } else {
                // oldArr = nil
                NSMutableArray *keysArr = [NSMutableArray array];
                [keysArr addObject:_searchTF.text];
                [def setObject:keysArr forKey:historyK];
                [def synchronize];
            }
        }
        
        [self.navigationController popViewControllerAnimated:NO];
        _searchResult(_searchTF.text);
    }
}

- (void)beginSearchWithKeyWords:(NSString *)keyWords {
    if (keyWords.length) {
        _searchTF.text = keyWords;
        [self searchEvent];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    [self searchEvent];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text && textField.text.length) {
        [self searchEvent];
    }
    return YES;
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
