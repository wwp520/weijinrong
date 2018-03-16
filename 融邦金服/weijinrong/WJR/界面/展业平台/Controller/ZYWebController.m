//
//  ZYWebController.m
//  weijinrong
//
//  Created by ouda on 2018/3/15.
//  Copyright © 2018年 oudapay. All rights reserved.
//

#import "ZYWebController.h"

@interface ZYWebController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation ZYWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createWebView];
}

//创建web网页
- (void)createWebView{
    self.webView=[[UIWebView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    _webView.delegate = self;
    [self.view  addSubview:self.webView];
    
    NSURL * url = [NSURL URLWithString:@"https://www.aliyun.com/product/ecs?spm=5176.8142029.388261.444.e93976f4imzc4Y"];
    NSURLRequest * request = [NSURLRequest  requestWithURL:url];
    [self.webView  loadRequest:request];
}


@end
