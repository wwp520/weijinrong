//
//  BaseTabBarController.m
//  BusinessPeople
//
//  Created by RY on 17/1/10.
//  Copyright © 2017年 RY. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseTabBar.h"
#import "AppDelegate.h"
#import "ZYPTController.h"
#define TitleColor [Unity getColor:@"#535353"]

#pragma mark 声明
@interface BaseTabBarController ()<UIAlertViewDelegate, UIApplicationDelegate>

@end

#pragma mark 实现
@implementation BaseTabBarController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
- (void)createUI {
    
    // 令牌失效, 重新登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenOut:) name:@"tokenOut" object:nil];
    [UINavigationBar appearance];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 添加子控制器
    [self setupChildVc:[[HomeController alloc] init] title:@"首页" image:@"融邦金服" selectedImage:@"融邦金服首页"];
    
    [self setupChildVc:[[ZYPTController alloc] init] title:@"展业平台" image:@"zy_zypt_huise" selectedImage:@"zy_zypt"];

    [self setupChildVc:[[AdvisoryController alloc] init] title:@"资讯" image:@"融邦金服资讯" selectedImage:@"资讯(高亮)"];
    
    [self setupChildVc:[[MineController alloc] init] title:@"个人" image:@"融邦金服个人" selectedImage:@"个人(高亮)"];
    
    // 更换tabBar
//    [self setValue:[[BaseTabBar alloc] init] forKeyPath:@"tabBar"];
}

// 初始化子控制器
- (void)setupChildVc:(BaseViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.navTitle = title;
    vc.tabBarItem.image = ({
        UIImage *imageI = [UIImage imageNamed:image];
        imageI = [imageI imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        imageI;
    });
    vc.tabBarItem.selectedImage = ({
        UIImage *selectedImageI = [UIImage imageNamed:selectedImage];
        selectedImageI = [selectedImageI imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectedImageI;
    });
    vc.view.backgroundColor = [UIColor whiteColor];
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    AppDelegate *app = [UIApplication sharedApplication].delegate; // 获取当前app单例
    UIViewController *vc = app.window.rootViewController;
    app.window.rootViewController = self;
    [vc removeFromParentViewController];
}

- (void)tokenOut:(NSNotification *)not {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:not.object delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [KKTools becomeTabController];
}


@end

