//
//  WebViewController.m
//  TangPassport
//
//  Created by Xiaodong Jiang on 8/11/15.
//  Copyright (c) 2015 黑龙江龙卫中新医药连锁有限公司. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.title = self.name;
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:self.htmlString baseURL:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

//-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    int fontSize = 100;
//    NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", fontSize];
//    [webView stringByEvaluatingJavaScriptFromString:jsString];
//}

#pragma mark - getter and setter

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBARHEIGHT)];
        _webView.delegate = self;
    }
    return _webView;
}

@end
