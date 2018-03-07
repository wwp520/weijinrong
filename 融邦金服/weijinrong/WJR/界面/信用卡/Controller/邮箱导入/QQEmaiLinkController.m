//
//  QQEmaiLinkController.m
//  weijinrong
//
//  Created by ouda on 17/6/27.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "QQEmaiLinkController.h"

@interface QQEmaiLinkController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)NSURL * url;
@end

@implementation QQEmaiLinkController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"QQ邮箱链接";
    [self createWebView];
}

//创建web网页
- (void)createWebView{
    self.webView=[[UIWebView  alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    _webView.delegate = self;
    [self.view  addSubview:self.webView];
    //qq
    _url = [NSURL URLWithString:@"https://jingyan.baidu.com/article/fedf0737af2b4035ac8977ea.html"];
    NSURLRequest * request = [NSURLRequest  requestWithURL:_url];
    [self.webView  loadRequest:request];
}

@end
