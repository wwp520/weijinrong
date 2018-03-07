//
//  NSString+NetString.h
//  weijinrong
//
//  Created by RY on 17/4/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NetString)

// 加密数据
+ (NSDictionary *)getRequestparamWithDict:(NSDictionary *)params;

// 登录
+ (NSString *)getLogin;
// 注册
+ (NSString *)getRegister;
// 短信
+ (NSString *)getCode;
// 忘记密码短信
+ (NSString *)getForget;
// 修改密码
+ (NSString *)getPwdChange;
// 银行卡列表
+ (NSString *)getBankCardList_URL;
// 银行列表
+ (NSString *)getBankList_URL;
// 更改银行卡
+ (NSString *)getChangeBankCard_URL;
// 获取金额
+ (NSString *)getMoney_URL;
// 联系我们
+ (NSString *)getChatUS_URL;
// 修改密码
+ (NSString *)getChangePwd2_URL;
// 图片上传
+ (NSString *)getUplodeImage_URL;
// 图片上传完后上传的东西
+ (NSString *)getSaveRealName_URL;
// 微信二维码
+ (NSString *)getWeiChat_URL;
// 支付宝二维码
+ (NSString *)getAlipy_URL;
// 支付状态
+ (NSString *)getPayState_URL;
// 余额
+ (NSString *)getMoneyInfo_URL;
// 提款信息
+ (NSString *)getMoneyDetail_URL;
// 提款
+ (NSString *)getMoneyNow_URL ;
// 信用卡
+ (NSString *)getCredit_url;
// 信用卡详情
+ (NSString *)getCreditList_url;
// 上传审核图片
+ (NSString *)get_fileautograph_url;


@end
