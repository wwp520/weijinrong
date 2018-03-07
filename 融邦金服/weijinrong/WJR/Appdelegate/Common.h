//
//  Common.h
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#ifndef Common_h
#define Common_h


//=============================== 单例 ===============================//
// .h
#define singleton_interface(class) +(instancetype) shared##class;
// .m
#define singleton_implementation(class)         \
static class *_instance;                        \
\
+(id) allocWithZone : (struct _NSZone *) zone { \
static dispatch_once_t onceToken;               \
dispatch_once(&onceToken, ^{                    \
_instance = [super allocWithZone:zone];         \
});                                             \
\
return _instance;                               \
}                                               \
\
+(instancetype) shared##class                   \
{                                               \
if (_instance == nil) {                         \
_instance = [[class alloc] init];               \
}                                               \
\
return _instance;                               \
}




#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 网络
#import <AFNetworking/AFNetworking.h>
#import "AFNManager.h"
#import "KKManager.h"
#import "DongManager.h"
// 第三方
#import "UMessage.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <IQKeyboardManager/IQKeyboardReturnKeyHandler.h>
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import "CKAlertManager.h"
#import "UMShareManager.h"
#import "Code39.h"
// 分类
#import "DeviceModel.h"
#import "UITextField+Extension.h"
#import "UIImage+Extension.h"
#import "UIView+Extension.h"
#import "UITableView+Extension.h"
#import "UIButton+Extension.h"
#import "NSString+NetString.h"
#import "NSString+Extension.h"
#import "UIViewController+Extension.h"
// 模型
#import "LoginModel.h"
// 工具类
#import "SaveManager.h"
#import "KKTools.h"
#import "KKCountdown.h"
#import "KKStaticParams.h"
// Base
#import "BaseCell.h"
#import "BaseView.h"
#import "BaseModel.h"
#import "BaseTabBar.h"
#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "BaseTabBarController.h"
// 请求失败
#import "NetFailView.h"
// 主页
#import "LoginController.h"
#import "HomeController.h"
#import "CreditCardController.h"
#import "MineController.h"
#import "AdvisoryController.h"
#import "WebController.h"

#endif
