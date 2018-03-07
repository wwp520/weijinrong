//
//  BaseViewController.m
//  BusinessPeople
//
//  Created by RY on 17/1/10.
//  Copyright © 2017年 RY. All rights reserved.
//

#import "BaseViewController.h"
#import "CTLoadingView.h"
#import "ShenHe.h"

#pragma mark 声明
@interface BaseViewController ()<MBProgressHUDDelegate,UIAlertViewDelegate>
@property (nonatomic,retain) CTLoadingView *loadingview;  //加载的view
@property (nonatomic,retain) CTLoadingView *showPromptView; //提示用的View
@end

#pragma mark 实现
@implementation BaseViewController




#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
   //    if (self.navigationController != nil && self.navigationItem != nil) {
////        if (self.title !=nil) {
////            self.navigationItem.title = self.title;
////        }
////        if([Unity currentVersion] == ios7){
//            [self EditNavigationBarColor:nil backgroundImage:@"naviBG"];
//        }else{
//            [self EditNavigationBarColor:nil backgroundImage:@"naviBG"];
//        }
//        top = NavBarHeight;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([CLLocationManager locationServicesEnabled] &&
       [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        
    }else {
        // 登录页面不提示定位
        if (![self isKindOfClass:[LoginController class]]) {
            if ([ShenHe sharedShenHe].sh == NO) {
                if (![self isKindOfClass:[LoginController class]]) {
                    UIAlertView *locAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位服务未开启，请进入系统【设置】>【隐私】>【定位服务】中打开开关，并允许融邦金服使用定位服务" delegate:self cancelButtonTitle:@"立即开启" otherButtonTitles:nil, nil];
                    [locAlertView show];
                }
            }
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 8) {
        //跳入当前App设置界面,
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }else {
        //适配iOS7 ,跳入系统设置界面
        NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}




- (void)setNavTitle:(NSString *)navTitle {
    UILabel *label = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        label.text = navTitle;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:20];
        label;
    });
    
    self.navigationItem.titleView = label;
}

#pragma mark 点击事件
- (void)leftClick {
    [self.navigationController popViewControllerAnimated:YES];
}



//修改navagationbar的背景色
- (void)EditNavigationBarColor:(UIColor *)colorString backgroundImage:(NSString *)imageName {
//    if (imageName!=nil&&imageName.length>0) {
//        if([Unity currentVersion] == ios7){
//            [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:10 topCapHeight:10]  forBarMetrics:UIBarMetricsDefault];
//        }else
//        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:imageName] forBarMetrics:UIBarMetricsDefault];
//        }
//    }
//    if (colorString!=nil) {
//        [self.navigationController.navigationBar setBackgroundColor:colorString];
//    }
}



#pragma mark 等待框
//============================== 基础需求 ==============================//
// 文字框
- (void)showTitle:(NSString *)title  delay:(CGFloat)delay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = YES;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    hud.label.text = title;
    hud.label.textColor = [UIColor whiteColor];
    hud.margin = 10.f;
    hud.offset = CGPointMake(hud.offset.x, 150.f);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
}


// 信息框
- (void)showInfoWithTitle:(NSString *)title {
    [self showInfoWithTitle:title delay:1.5f];
}
- (void)showInfoWithTitle:(NSString *)title delay:(CGFloat)delay {
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    hud.userInteractionEnabled = YES;
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:@"CheckInfo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
    hud.label.text = title;
    hud.label.textColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:delay];
}




// 显示加载中
- (void)showHudLoadingView:(NSString *)loadTitle {
    if (self.loadingview) {
        [self.loadingview removeFromSuperview];
        self.loadingview = nil;
        self.loadingview = [[CTLoadingView alloc] initWithFrame:({
            CGFloat x = [UIScreen mainScreen].bounds.size.width/2 - 40;
            CGFloat y = ScreenHeight/2 - 80;
            CGRectMake(x, y, 80, 80);
        }) withTitle:loadTitle];
        [self.view addSubview:self.loadingview];
        self.view.userInteractionEnabled = NO;
    }
    else {
        self.loadingview = [[CTLoadingView alloc]initWithFrame:({
            CGFloat x = [UIScreen mainScreen].bounds.size.width/2 - 40;
            CGFloat y = ScreenHeight/2 - 80;
            CGRectMake(x, y, 80, 80);
        }) withTitle:loadTitle];
        [self.view addSubview:self.loadingview];
        self.view.userInteractionEnabled = NO;
    }
}
- (void)hiddenHudLoadingView {
// 隐藏加载
    if (self.loadingview) {
        __weak BaseViewController * weak = self;
        [UIView animateWithDuration:.3f animations:^{
            weak.loadingview.alpha = 0;
            //            self.view.userInteractionEnabled = YES;
        } completion:^(BOOL finished) {
            if (weak.loadingview) {
                [weak.loadingview removeFromSuperview];
                weak.loadingview = nil;
            }
            weak.view.userInteractionEnabled = YES;
        }];
    }
}




// 延时返回
- (void)popDelay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}
// 延时返回
- (void)popRootDelay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
}

//============================== 包装需求 ==============================//
// 网络不稳定
- (void)showNetFail {
    [self hiddenHudLoadingView];
    [self showTitle:@"网络不稳定" delay:1.5f];
}

// 加密数据
- (NSDictionary *)getRequestparamWithDict:(NSDictionary *)dict {
    NSString *str = [KKTools dictionaryToJson:dict];
    return @{@"param":[KKTools encryptionJsonString:str]};
}

//=============================== 其他 ================================//
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hiddenHudLoadingView];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self EditNavigationBarColor:nil backgroundImage:@"naviBG"];

    
    BOOL isHidden = self.navigationController.viewControllers.count > 1;
    self.hidesBottomBarWhenPushed = isHidden;
    self.navigationController.tabBarController.tabBar.hidden = isHidden;
    
}



@end









