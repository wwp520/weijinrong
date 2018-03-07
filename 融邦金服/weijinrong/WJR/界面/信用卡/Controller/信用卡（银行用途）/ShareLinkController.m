//
//  ShareLinkController.m
//  weijinrong
//
//  Created by ouda on 2018/3/6.
//  Copyright © 2018年 oudapay. All rights reserved.
//

#import "ShareLinkController.h"
#import "HomeBtn.h"
#import <UShareUI/UShareUI.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>


@interface ShareLinkController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *codeImage;
@property(nonatomic,strong)NSArray * imageArry;
@property(nonatomic,strong)NSArray * titleArray;
@end

@implementation ShareLinkController

- (NSArray *)imageArry{
    if (!_imageArry) {
        _imageArry = @[@"微信好友.png",@"朋友圈.png",@"qq.png",@"qq空间.png"];
    }
    return _imageArry;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"微信",@"朋友圈",@"QQ",@"空间"];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"分享链接";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

//创建web网页
- (void)createUI{
    
    self.codeImage.image = self.image;
    
    //self.codeImage.contentMode = UIViewContentModeScaleAspectFit;

    //分享按钮
    //    NSInteger clomn = 4;
    CGFloat  btnW = 60;
    
    CGFloat margin = (ScreenWidth - 4 * btnW)/5;
    for (int i=0; i<4; i++) {
        UIButton * btn = [[UIButton  alloc]initWithFrame:CGRectMake(margin+i*(margin+btnW), ScreenHeight-180, btnW, 60)];
        btn.tag = i;
        //        btn.backgroundColor = [UIColor redColor];
        [btn setImage:[UIImage imageNamed:self.imageArry[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(margin+i*(margin+btnW), CGRectGetMaxY(btn.frame), btnW, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.titleArray[i];
        label.textColor = [UIColor blackColor];
        [self.view addSubview:label];
    }

}



// 友盟分享功能
- (void)btnClick:(UIButton *)btn {
    
    if (btn.tag == 0) {   //微信
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"欢迎进入融邦金服" images:@[self.image] url:nil title:@"融邦金服" type:SSDKContentTypeAuto];
        
        [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            // 成功
            if (state == SSDKResponseStateSuccess) {
                
            }
        }];
    }
    if (btn.tag == 1) {   //朋友圈
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"欢迎进入融邦金服" images:@[self.image] url:nil title:@"融邦金服" type:SSDKContentTypeAuto];
        
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            // 成功
            if (state == SSDKResponseStateSuccess) {
                
            }
        }];
        
    }
    if (btn.tag == 2) {   //QQ
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"欢迎进入融邦金服" images:@[self.image] url:nil title:@"融邦金服" type:SSDKContentTypeAuto];
        
        [ShareSDK share:SSDKPlatformSubTypeQQFriend parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            // 成功
            if (state == SSDKResponseStateSuccess) {
                
            }
        }];
    }
    if (btn.tag == 3) {   //空间
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"欢迎进入融邦金服" images:@[self.image] url:nil title:@"融邦金服" type:SSDKContentTypeAuto];
        
        [ShareSDK share:SSDKPlatformTypeQQ parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            // 成功
            if (state == SSDKResponseStateSuccess) {
                
            }
        }];
    }
}




@end
