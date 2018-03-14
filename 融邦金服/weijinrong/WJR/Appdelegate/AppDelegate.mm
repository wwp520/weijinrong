//
//  AppDelegate.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "AppDelegate.h"
#import "NewAttestationController.h"
#import "WelcomeViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "UserPushModel.h"
#import "WelcomeController.h"
#import "ShenHe.h"
#import "UMMobClick/MobClick.h"

//以下几个库仅作为调试引用引用的
#import <AdSupport/AdSupport.h>
#import <CommonCrypto/CommonDigest.h>
#import <UserNotifications/UserNotifications.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

#pragma mark 声明
@interface AppDelegate ()<UNUserNotificationCenterDelegate>
@property (nonatomic, strong) BMKMapManager *manager;
@end

#pragma mark 实现
@implementation AppDelegate

#pragma mark 程序入口
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // 顺序不能换: 先百度, 后界面
    [self umengSDK];
    [self umengPushSDK:launchOptions];
    [self baiduSDK];
    [self iqKeyboard];
    [self createUI];
    // 分享
    [self shareWithShareKey:SHARE_KEY];
    // 从通知进来
    [self pushToNotification:launchOptions];
    // 统计
    UMConfigInstance.appKey = UMeng_total_KEY;
    UMConfigInstance.channelId = ChannelNumber;
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"10"];
    [MobClick setAppVersion:version];
    // 当前未登录
    [KKStaticParams sharedKKStaticParams].currentLogin = NO;
    
    return YES;
}


- (void)total {
    [MobClick profileSignInWithPUID:@"playerID"];
    [MobClick profileSignInWithPUID:@"playerID" provider:@"WB"];
}



// 初始化
- (void)createUI {
    // 设置NavigationBar背景颜色
    [[UINavigationBar appearance] setBarTintColor:StreamColor];
    // Window
    [self setWindow:[[UIWindow alloc] initWithFrame:ScreenBounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    
    
    if ([ShenHe isShenHeDate]) {
        [self.window setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:[[WelcomeViewController alloc] init]]];   ///看到引导页
    }else {
        [self.window setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:[[WelcomeController alloc] init]]];
    }
}




// 百度地图
- (void)baiduSDK {
    _manager = [[BMKMapManager alloc] init];
    BOOL ret = [_manager start:BAIDU_KEY generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}
// 键盘
- (void)iqKeyboard {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
    
    //    NSMutableSet *set = manager.disabledDistanceHandlingClasses;
    //    [set addObject:[NewAttestationController class]];
    //    [manager setValue:set forKey:@"disabledDistanceHandlingClasses"];
}
// 友盟分享
- (void)umengSDK {
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMeng_KEY];
    
    [UMShareManager configUSharePlatforms];
    
}
// 友盟推送
- (void)umengPushSDK:(NSDictionary *)launchOptions {
    //设置 AppKey 及 LaunchOptions
    [UMessage startWithAppkey:PUSH_KEY launchOptions:launchOptions httpsEnable:YES];
    [UMessage openDebugMode:YES];
    //注册通知
    [UMessage registerForRemoteNotifications];
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            
        } else {
            //点击不允许
            
        }
    }];
    [UMessage setLogEnabled:YES];
    
    
}
// Share分享
- (void)shareWithShareKey:(NSString *)shareKey {
    //share
    [ShareSDK registerApp:shareKey
     
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeRenren),
                            @(SSDKPlatformTypeAliPaySocial),
                            @(SSDKPlatformSubTypeQZone)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx7583c36ec3cb1f0e"
                                       appSecret:@"bf634eb98c65d6d717f06fe47cc13a5d"];
                 break;
                 //             case SSDKPlatformTypeWechat:
                 //                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                 //                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 //                 break;
                 //             case SSDKPlatformTypeQQ:
                 //                 [appInfo SSDKSetupQQByAppId:@"100371282"
                 //                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                 //                                    authType:SSDKAuthTypeBoth];
                 //                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106106364"
                                      appKey:@"VwXcDkVn5FWEibfi"
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeAliPaySocial:
                 [appInfo SSDKSetupAliPaySocialByAppId:@"2016102702359454"];
                 break;
             default:
                 break;
         }
     }];
}
// 从通知进来
- (void)pushToNotification:(NSDictionary *)launchOptions {
    // 从通知进来
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    // 不为空就是从通知进的程序
    if (remoteNotification != nil) {
        UserPushModel *model = [UserPushModel mj_objectWithKeyValues:remoteNotification];
        [KKStaticParams sharedKKStaticParams].pushModel = model;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushMessage" object:nil];
    }
}


#pragma mark - UNUserNotificationCenterDelegate
// iOS9 及以下进来
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    
    UserPushModel *model = [UserPushModel mj_objectWithKeyValues:userInfo];
    [KKStaticParams sharedKKStaticParams].pushModel = model;
    [KKTools presentPushController:model click:nil];
    
    NSLog(@"%@",userInfo);
    NSLog(@"123");
}
// 通知注册
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"token: %@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                         stringByReplacingOccurrencesOfString: @">" withString: @""]
                        stringByReplacingOccurrencesOfString: @" " withString: @""]);
}

// iOS10新增：前台通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    
    //    UserPushModel *model = [UserPushModel mj_objectWithKeyValues:userInfo];
    //    [KKStaticParams sharedKKStaticParams].pushModel = model;
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushMessage" object:nil];
    //
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        // 应用处于前台 - 远程推送
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        // 应用处于前台 - 本地推送
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    // 当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

// iOS10新增：后台通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    //    UserPushModel *model = [UserPushModel mj_objectWithKeyValues:userInfo];
    //    [KKStaticParams sharedKKStaticParams].pushModel = model;
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushMessage" object:nil];
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        // 应用处于后台 - 远程推送
        [UMessage didReceiveRemoteNotification:userInfo];
        NSLog(@"iOS10新增：后台远程推送");
        UserPushModel *model = [UserPushModel mj_objectWithKeyValues:userInfo];
        [KKStaticParams sharedKKStaticParams].pushModel = model;
        [KKTools presentPushController:model click:nil];
    }else{
        // 应用处于后台 - 本地推送
        NSLog(@"iOS10新增：后台本地推送");
        UserPushModel *model = [UserPushModel mj_objectWithKeyValues:userInfo];
        [KKStaticParams sharedKKStaticParams].pushModel = model;
        [KKTools presentPushController:model click:nil];
    }
}

#pragma mark 以下的
- (NSString *)openUDID {
    NSString* openUdid = nil;
    if (openUdid==nil) {
        CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef cfstring = CFUUIDCreateString(kCFAllocatorDefault, uuid);
        const char *cStr = CFStringGetCStringPtr(cfstring,CFStringGetFastestEncoding(cfstring));
        unsigned char result[16];
        CC_MD5( cStr,(CC_LONG)strlen(cStr), result );
        CFRelease(uuid);
        CFRelease(cfstring);
        openUdid = [NSString stringWithFormat:
                    @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%08lx",
                    result[0], result[1], result[2], result[3],
                    result[4], result[5], result[6], result[7],
                    result[8], result[9], result[10], result[11],
                    result[12], result[13], result[14], result[15],
                    (unsigned long)(arc4random() % NSUIntegerMax)];
    }
    return openUdid;
}



#pragma mark - 友盟分享
// 系统回调
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}




@end
