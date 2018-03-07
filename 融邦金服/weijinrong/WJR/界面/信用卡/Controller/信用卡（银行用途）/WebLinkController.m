//
//  WebLinkController.m
//  weijinrong
//
//  Created by ouda on 17/6/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "WebLinkController.h"

@interface WebLinkController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
//@property(nonatomic,strong)NSURL * url;
@end

@implementation WebLinkController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"立即申请";
    [self createWebView];
}


//创建web网页
-(void)createWebView{
    self.webView=[[UIWebView  alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    _webView.delegate = self;
    [self.view  addSubview:self.webView];
    // _model.cardLink     _urls
    _url=[NSURL  URLWithString:_model.linkUrl];
    NSURLRequest * request = [NSURLRequest  requestWithURL:_url];
//    _str = [_url  absoluteString];
    [self.webView  loadRequest:request];
    
}

- (void)setModel:(CardWelfareListModel *)model{
    _model = model;
}


@end
