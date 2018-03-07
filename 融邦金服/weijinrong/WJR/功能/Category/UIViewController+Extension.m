//
//  UIViewController+Extension.m
//  weijinrong
//
//  Created by RY on 17/4/13.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (void)pushViewController:(Class)cls {
    BaseViewController *vc = [[cls alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)setRightItem:(NSString *)image title:(NSString *)title action:(SEL)action {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:({
        CGFloat width = title.length == 0 ? 20 : 80;
        UIButton *scanBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
        [scanBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [scanBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [scanBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        scanBtn;
    })];
}

// 登录页跳转
- (void)pushLoginVc:(KKBlock)success close:(KKBlock)close {
    LoginController *login = [[LoginController alloc] init];
    login.success = success;
    login.close = close;
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:login];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
//    success();
}


@end
