//
//  EmailLinkController.m
//  weijinrong
//
//  Created by ouda on 17/6/27.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "EmailLinkController.h"

@interface EmailLinkController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)NSURL * url;
@end

@implementation EmailLinkController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"网易邮箱链接";
    [self createWebView];
}

//创建web网页
- (void)createWebView{
    self.webView=[[UIWebView  alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    _webView.delegate = self;
    [self.view  addSubview:self.webView];
    //网易
     _url = [NSURL URLWithString:@"https://jingyan.baidu.com/article/495ba841ecc72c38b30ede38.html?ich=s&jid=1&aaa_flag=1&_f_=1"];
    NSURLRequest * request = [NSURLRequest  requestWithURL:_url];
    [self.webView  loadRequest:request];
    
}



@end
