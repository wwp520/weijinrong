//
//  UIViewController+Extension.h
//  weijinrong
//
//  Created by RY on 17/4/13.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

- (void)pushViewController:(Class)cls;
- (void)setRightItem:(NSString *)image title:(NSString *)title action:(SEL)action ;

// 登录页跳转
- (void)pushLoginVc:(KKBlock)success close:(KKBlock)close ;

@end
