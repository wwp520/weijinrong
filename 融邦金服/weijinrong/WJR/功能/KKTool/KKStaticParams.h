//
//  文件名: KKStaticParams.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/12
//

#import <Foundation/Foundation.h>
#import "UserPushModel.h"

#pragma mark - 声明
@interface KKStaticParams : NSObject
singleton_interface(KKStaticParams)

@property (nonatomic, strong) LoginModel *login;        // 登录参数
@property (nonatomic, assign) NSInteger cityId;         // 城市Id
@property (nonatomic, assign) CGFloat lat;              // 经度
@property (nonatomic, assign) CGFloat lot;              // 纬度

@property (nonatomic, strong) NSString *cardAmount;     // 办卡金额
@property (nonatomic, strong) NSString *cardSumAmount;  // 累积办卡金额
@property (nonatomic, strong) NSString *mercSts;        // 实名认证

@property (nonatomic, strong) NSString *profitMin;
@property (nonatomic, strong) NSString *profitMax;

@property (nonatomic, strong) UserPushModel *pushModel; // 推送model
@property (nonatomic, assign) BOOL currentLogin;        // 是否登陆了

@end








