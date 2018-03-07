//
//  文件名: WebController.m
//  工程名: chengzizhifu
//
//  创建人: KK
//  创建时间: 17/4/6
//

#import "WebController.h"

#pragma mark - 声明
@interface WebController()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIButton *urlAgain;
@property (weak, nonatomic) IBOutlet UIWebView *web;
@end

#pragma mark - 实现
@implementation WebController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navTitle = @"具体地点";
    [self createUI];
    [self showHudLoadingView:@"正在加载"];
}
- (void)createUI {
    _web.delegate = self;
    [_web loadRequest:({
        NSURL *url = [NSURL URLWithString:_url];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        request;
    })];
    
    _icon.layer.cornerRadius = _icon.height / 2;
    _icon.layer.masksToBounds = YES;
    _urlAgain.layer.cornerRadius = 3;
    _urlAgain.layer.masksToBounds = YES;
    _urlAgain.layer.borderColor = [UIColor grayColor].CGColor;
    _urlAgain.layer.borderWidth = 1;
}

- (IBAction)urlAgain:(UIButton *)sender {
    [self showHudLoadingView:@"正在加载"];
    [_web loadRequest:({
        NSURL *url = [NSURL URLWithString:_url];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        request;
    })];
}

#pragma mark - UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    _web.alpha = 0;
    [self hiddenHudLoadingView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _web.alpha = 1;
    [self hiddenHudLoadingView];
}


@end









