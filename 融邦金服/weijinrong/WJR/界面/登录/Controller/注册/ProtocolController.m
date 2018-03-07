//
//  ProtocolController.m
//  weijinrong
//
//  Created by ouda on 17/6/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "ProtocolController.h"

@interface ProtocolController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
@end

@implementation ProtocolController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"手机客户端服务协议";
    [self  createWebView];
}

//创建web网页
-(void)createWebView{
    self.webView=[[UIWebView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.webView.backgroundColor = [UIColor redColor];
    _webView.delegate = self;
    [self.view  addSubview:self.webView];
//    NSURL * url = [NSURL  URLWithString:@"file:///Users/ouda/Downloads/agreement.html"];
//    NSURLRequest * request = [NSURLRequest  requestWithURL:url];
//    [self.webView  loadRequest:request];
    
    
    // 应用场景:加载从服务器上下载的文件,例如pdf,或者word,图片等等文件
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"agreement.html" withExtension:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    
    [self.webView loadRequest:request];
}


#pragma mark - WebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self  hiddenHudLoadingView];
    });
}


@end
