//
//  LinkURLController.m
//  weijinrong
//
//  Created by ouda on 17/6/14.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "LinkURLController.h"


@interface LinkURLController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)NSURL  * url;
@end

@implementation LinkURLController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"相关链接";
    [self createWebView];
}

//创建web网页
-(void)createWebView{
    self.webView=[[UIWebView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _webView.delegate = self;
    [self.view  addSubview:self.webView];
    // _model.cardLink     _urls
    _url=[NSURL  URLWithString:_model.linkUrl];
    NSURLRequest * request = [NSURLRequest  requestWithURL:_url];
    [self.webView  loadRequest:request];
    
}

#pragma mark--无用
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self  hiddenHudLoadingView];
    });
}

- (void)setModel:(CardWelfareListModel *)model{
    _model = model;
}


@end
