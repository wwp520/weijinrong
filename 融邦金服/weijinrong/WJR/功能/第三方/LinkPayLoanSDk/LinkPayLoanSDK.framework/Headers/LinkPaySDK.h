//
//  LinkPaySDK.h
//  LinkPaySDK
//
//  Created by 卢梦如 on 2017/6/6.
//  Copyright © 2017年 卢梦如. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    SdkStatusStarting,  // 正在启动
    
    SdkStatusSuccess,   // 启动成功
    
    SdkStatusFailure,   // 启动失败
    
    SdkStatusOther      // 尚未初始化
    
} SdkStatus;

@protocol LinkPaySdkDelegate <NSObject>

@optional

/**
 *  SDK初始化成功的代理方法
 *  YES:成功  NO:失败
 */

-(void)LinkPaySdkInitSuccess: (BOOL)success withError: (NSString *)error;


@end


@interface LinkPaySDK : NSObject


/**
 *  SDK初始化 (用户登录APP的时候调用此方法)
 *  appName:APP名称  sign:加密字符串  userId:用户在第三方平台的Id  phoneNum:用户的手机号
 */

+(void)initAccessKeyId: (NSString *)accessKeySecret andSign: (NSString *)sign andUserId: (NSString *)userId withPhoneNum: (NSString *)phoneNum delegate:(id<LinkPaySdkDelegate>)delegate;


/**
 *  获取SDK启动状态 (只有在启动成功之后才能进行正常的H5页面贷款交互等)
 *  SdkStatusStarting:正在启动  SdkStatusSuccess: 启动成功  SdkStatusFailure: 启动失败 SdkStatusOther: 尚未初始化
 */

+(SdkStatus)status;


/**
 *  SDK清除数据(用户退出登录的时候调用)
 */

+(BOOL)linkPaySdkLogOut;






@end
