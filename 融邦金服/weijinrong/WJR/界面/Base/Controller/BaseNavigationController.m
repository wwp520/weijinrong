//
//  BaseNavigationController.m
//  BusinessPeople
//
//  Created by RY on 17/1/10.
//  Copyright © 2017年 RY. All rights reserved.
//

#import "BaseNavigationController.h"

#pragma mark 声明
@interface BaseNavigationController ()

@end

#pragma mark 实现
@implementation BaseNavigationController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark 动作
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    // 如果不是跟控制器, 就有返回按钮
    if (self.viewControllers.count > 1) {
        [self hidesBottomBarWhenPushed];
        viewController.navigationItem.hidesBackButton = YES;
        [KKTools setLeftWithVc:viewController Image:@"main_back" action:@selector(leftClick)];
    }
}

- (void)customerBackButton:(UIViewController *)vc{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)) {
        btn.contentEdgeInsets =UIEdgeInsetsMake(3, -10, 3, 20);
        btn.imageEdgeInsets =UIEdgeInsetsMake(5, 5,5, 30);
    }
    vc.navigationItem.leftBarButtonItem = leftItem;
}


- (void)back{
    UIViewController *vc = self.viewControllers.lastObject;
    [vc.navigationController popViewControllerAnimated:YES];
}



@end

