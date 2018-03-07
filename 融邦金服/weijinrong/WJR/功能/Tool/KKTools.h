//
//  KKTools.h
//  BusinessPeople
//
//  Created by RY on 17/1/10.
//  Copyright © 2017年 RY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "UserPushModel.h"

/** 公共类 */
@interface KKTools : NSObject

//=================================== 界面 ===================================//
// 设置右侧图标
+ (void)setRightWithVc:(BaseViewController *)vc Image:(NSString *)title action:(SEL)sel;
// 设置左侧图标
+ (void)setLeftWithVc:(BaseViewController *)vc Image:(NSString *)title action:(SEL)sel;
// 输入框左侧图标
+ (void)setFiledLeft:(NSString *)str field:(UITextField *)textField;
// 输入框右侧图标
+ (void)setFiledRight:(NSString *)str field:(UITextField *)textField;
// 获取当前显示的控制器
+ (BaseViewController *)getCurrentVC ;

//=================================== 转换 ===================================//
// 字符串转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
// 字典转换为字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
+ (NSString *)dictionaryToJson2:(NSDictionary *)dic;
// 字典转换为JSON
+ (NSString *)convertToJsonData:(NSDictionary *)dict;
// 字符串转换成字典
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;

//=================================== 验证 ===================================//
// 验证手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
// 信用卡验证
+ (BOOL)isValidCreditNumber:(NSString*)value;
// 身份证验证
+ (BOOL)validateIdentityCard:(NSString *)identityCard;
// 验证email
+ (BOOL)verfierEmail:(NSString *)email;
// 验证密码
+ (BOOL)verfierPassword:(NSString *)pwd;

//=================================== 时间 ===================================//
// 返回时间字符串
+ (NSString *)strWithDate:(NSString *)dateFormat today:(NSInteger)days;

//=================================== 加密 ===================================//
// 加密
+ (NSString *)encryptionJsonString:(NSString *)string;
// 解密
+ (NSString *)decryptJsonString:(NSString *)string;

//================================ 切换根控制器 ================================//
+ (void)becomeTabController;
+ (void)becomeLoginController;

// 从通知进来
+ (void)presentPushController:(UserPushModel *)model click:(KKBlock)click;


@end
