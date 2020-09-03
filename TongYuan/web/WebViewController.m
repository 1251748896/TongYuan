//
//  WebViewController.m
//  TongYuan
//
//  Created by apple on 2017/12/9.
//  Copyright © 2017年 姜波. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
@property (nonatomic) UIWebView *webView;
@end

@implementation WebViewController

- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        _webUrl = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_webUrl == nil) return;
    
    CGRect frame = self.view.bounds;
    frame.size.height -= 20;
    
    NSLog(@"_webUrl = %@",_webUrl);
    _webView = [[UIWebView alloc] init];
    _webView.frame = frame;
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    [self loadHtmlWithUrl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)loadHtmlWithUrl {
    NSURL *URL = [NSURL URLWithString:_webUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [_webView loadRequest:request];
}

#pragma mark - delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [Tool startAnimation:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [Tool stopAnimation:self.view];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [Tool stopAnimation:self.view];
    [Tool startAnimationWithMessage:@"加载失败" showTime:1.5 onView:self.view];
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
