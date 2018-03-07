//
//  BaseViewController.h
//  BusinessPeople
//
//  Created by RY on 17/1/10.
//  Copyright © 2017年 RY. All rights reserved.
//

#import <UIKit/UIKit.h>

static MBProgressHUD *hud;
@interface BaseViewController : UIViewController
@property (nonatomic, strong) NSString *navTitle;
//============================== 基础需求 ==============================//
/** 等待框 */
//- (void)showHudLoadingView:(NSString *)title;
//- (void)showHudLoadingView:(NSString *)title delay:(CGFloat)delay;
/** 文字框 */
- (void)showTitle:(NSString *)title delay:(CGFloat)delay;


//修改navagationbar的背景色
-(void)EditNavigationBarColor:(UIColor *)colorString backgroundImage:(NSString *)imageName;

/** 延时返回 */
- (void)popDelay;
/** 延时返回 */
- (void)popRootDelay;




// 显示加载中
- (void)showHudLoadingView:(NSString *)loadTitle;
// 隐藏加载
- (void)hiddenHudLoadingView;




//============================== 包装需求 ==============================//
/** 网络不稳定 */
- (void)showNetFail;
/** 加密数据 */
- (NSDictionary *)getRequestparamWithDict:(NSDictionary *)dict;


@end










