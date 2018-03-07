//
//  AboutUsViewController.m
//  chengzizhifu
//
//  Created by 快易 on 15/2/3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "AboutUsViewController.h"
#import "UpdateModel.h"
#import "Unity.h"

#pragma mark 声明
@interface AboutUsViewController (){
    UILabel *infoLabel;
}

@end

#pragma mark 实现
@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self createWebView];
}
- (void)createNavigation{
    self.navTitle=@"关于我们";
}
- (void)createWebView{
    // 以前是本地网址，现在删除了
//    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    [self.view addSubview:self.webView];
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"copyright" ofType:@"html"];
//    NSURL* url = [NSURL fileURLWithPath:path];
//    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
//    [self.webView loadRequest:request];
    
    NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    CGFloat topMgr = 10 ;
    CGFloat leftMgr = 15;
    UILabel *messageLab = [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(leftMgr, topMgr, 100, 35) _string:@"版权信息" _lableFont:[UIFont systemFontOfSize:20] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentLeft];
    infoLabel = [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(leftMgr, CGRectGetMaxY(messageLab.frame)+10, 200, 20) _string:[NSString stringWithFormat:@"Copyright ©2017,融邦金服(%@)",app_Version] _lableFont:[UIFont systemFontOfSize:12] _lableTxtColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7] _textAlignment:NSTextAlignmentLeft];
    UIImageView *codeImage = [Unity imageviewAddsuperview_superView:self.view _subViewFrame:CGRectMake((self.view.width-250)/2, CGRectGetMaxY(infoLabel.frame)+10, 250, 250) _imageName:@"erweima(1)" _backgroundColor:[UIColor whiteColor]];
    
    UIButton * button=[Unity buttonAddsuperview_superView:self.view _subViewFrame:CGRectMake((self.view.width-250)/2,CGRectGetMaxY(codeImage.frame)+2*10, 250,[Unity countcoordinatesY:60/2]) _tag:self _action:@selector(phoneAction) _string:@"" _imageName:@""];
    button.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.03];
    button.layer.cornerRadius = 5;

    UIImageView * image=[Unity imageviewAddsuperview_superView:button _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2], (button.height-60/2)/2, [Unity countcoordinatesW:70/2], 60/2) _imageName:@"telephone.png" _backgroundColor:[UIColor clearColor]];
    UILabel * titleLab= [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(image.right+[Unity countcoordinatesX:40/2],(button.height-80/2)/2, [Unity countcoordinatesX:400/2],80/2 ) _string:@"客服电话:4000029699" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
    titleLab.centerX = button.centerX;
    
}

- (void)phoneAction {
    NSURL *url = [NSURL URLWithString:@"telprompt://4000029699"];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备暂时不支持拨号功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }

}

@end
