//
//  SaveManager.h
//  BusinessPeople
//
//  Created by RY on 17/1/13.
//  Copyright © 2017年 RY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kk_AutoLogin  @"kk_AutoLogin"
#define kk_FirstLogin @"kk_FirstLogin"
#define kk_Account    @"kk_Account"
#define kk_Password   @"kk_Password"
#define kk_Version    @"kk_Version"


/**
 *  保存版本号
 */
#define SaveVersion(str)   [SaveManager saveString:str forKey:kk_Version]
#define GetVersion [SaveManager getStringForKey:kk_Version]

/**
 *  自动登录
 *
 *  0/nil: 未选中  1:选中
 */
#define AutoLogin(str)   [SaveManager saveString:str forKey:kk_AutoLogin]
#define isAutoLogin      [[SaveManager getStringForKey:kk_AutoLogin] isEqualToString:@"1"]

/**
 *  第一次登录
 *
 *  NO/nil: 第一次登录   YES: 不是第一次登录
 */
#define FirstLogin   [SaveManager saveString:@"1" forKey:kk_FirstLogin]
#define isFirstLogin [[SaveManager getStringForKey:kk_FirstLogin] isEqualToString:@"1"]

/** 账号 */
#define SaveAccount(str)   [SaveManager saveString:str forKey:kk_Account]
#define GetAccount         [SaveManager getStringForKey:kk_Account]
/** 密码 */
#define SavePassword(str)  [SaveManager saveString:str forKey:kk_Password]
#define GetPassword        [SaveManager getStringForKey:kk_Password]


@interface SaveManager : NSObject

@property (nonatomic, strong) NSString *sessionID;//SessionID

+ (instancetype)shareInstance ;
// 存值
+ (void)saveString:(NSString *)str forKey:(NSString *)key;
// 取值
+ (NSString *)getStringForKey:(NSString *)key;

@end
