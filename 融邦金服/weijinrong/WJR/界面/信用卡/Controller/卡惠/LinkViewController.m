//
//  LinkViewController.m
//  weijinrong
//
//  Created by ouda on 17/5/18.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "LinkViewController.h"

@interface LinkViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
@end

@implementation LinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"信用卡申请";
    [self createWebView];
}

//创建web网页
-(void)createWebView{
    self.webView=[[UIWebView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    _webView.delegate = self;
    [self.view  addSubview:self.webView];
    
    NSURL  * url=[NSURL  URLWithString:_content];
    NSURLRequest * request = [NSURLRequest  requestWithURL:url];
    [self.webView  loadRequest:request];
}


#pragma mark - WebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self  hiddenHudLoadingView];
    });
}

-(void)setContent:(NSString *)content{
    _content = content;
}

//-(void)setLogo:(NSString *)logo{
//    _logo = logo;
//}

- (void)setModel:(CardBenifitModel *)model{
    _model = model;
}

@end
