//
//  DongManager.h
//  weijinrong
//
//  Created by RY on 17/4/28.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DongManager : NSObject
// 平安普惠
+ (void)PinganNow:(NSDictionary *)params
          success:(SuccessBlock)success
             fail:(AFNErrorBlock)fail;

// 登录
+ (void)login:(NSDictionary *)params
     username:(NSString *)username
      success:(SuccessBlock)success
         fail:(AFNErrorBlock)fail;

//获取session
+ (void)getSession:(NSDictionary *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail;

//获取主页显示数据
+ (void)getiOSlogined:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail;


// 验证码
+ (void)code:(NSDictionary *)params
     success:(SuccessBlock)success
        fail:(AFNErrorBlock)fail;


//退出登录
+(void)logout:(NSDictionary *)params
        success:(SuccessBlock)success
           fail:(AFNErrorBlock)fail;

//注册
+ (void)registe:(NSDictionary *)params
        success:(SuccessBlock)success
           fail:(AFNErrorBlock)fail;

// 忘记密码
+ (void)forget:(NSDictionary *)params
       success:(SuccessBlock)success
          fail:(AFNErrorBlock)fail;


// 修改密码
+ (void)pwdChange:(NSDictionary *)params
          success:(SuccessBlock)success
             fail:(AFNErrorBlock)fail;

// 银行卡列表
+ (void)bankCardList:(NSDictionary *)params
             success:(SuccessBlock)success
                fail:(AFNErrorBlock)fail;


//银行列表
+ (void)bankList:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail;


//变更银行卡
+ (void)changeBankCard:(NSDictionary *)params
               success:(SuccessBlock)success
                  fail:(AFNErrorBlock)fail;

// 获取金额
+ (void)getMoney:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail;

// 意见反馈
+ (void)chatUs:(NSDictionary *)params
       success:(SuccessBlock)success
          fail:(AFNErrorBlock)fail;

// 验证码
+ (void)getCode:(NSDictionary *)params
     success:(SuccessBlock)success
        fail:(AFNErrorBlock)fail;


//修改密码
+ (void)changePass:(NSDictionary *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail;


// 图片上传
+ (void)upload:(NSDictionary *)params
        images:(NSArray *)images
       success:(SuccessBlock)success
          fail:(AFNErrorBlock)fail
       progess:(CurrentProgress)progess;


// 微信二维码
+ (void)weiChatPay:(NSDictionary *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail;

// 支付宝二维码
+ (void)alipyPay:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail;

// 获取支付状态
+ (void)payState:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail;

//(提款处)余额
+ (void)moneyInfo:(NSDictionary *)params
          success:(SuccessBlock)success
             fail:(AFNErrorBlock)fail;

// 提款信息
+ (void)moneyDetail:(NSDictionary *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail;

// 提款<wei>
+ (void)moneyNow:(NSString *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail;

//管卡处银行卡列表
+ (void)getBankCardList:(NSDictionary *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail;

//管卡处银行卡列表详情
+ (void)getBankCardListDelteil:(NSString *)params
                       success:(SuccessBlock)success
                          fail:(AFNErrorBlock)fail;
//积分
+ (void)Integral:(NSString *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail;

//邮箱导入
+ (void)Email:(NSString *)params
      success:(SuccessBlock)success
         fail:(AFNErrorBlock)fail;

//手动导入
+ (void)AutoAdd:(NSString *)params
        success:(SuccessBlock)success
           fail:(AFNErrorBlock)fail;

//积分处（银行logo）(通)
+ (void)Logo:(NSString *)params
     success:(SuccessBlock)success
        fail:(AFNErrorBlock)fail;

//卡惠
+ (void)CardBenefit:(NSString *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail;

//精卡推荐
+ (void)CardRecommend:(NSString *)params
              success:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail;

//卡惠精选
+ (void)CardBenefitSelect:(NSString *)params
                  success:(SuccessBlock)success
                     fail:(AFNErrorBlock)fail;

//分享二维码列表
+ (void)shareQRList:(NSString *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail;

//修改分享二维码
+ (void)shareQRReplace:(NSString *)params
               success:(SuccessBlock)success
                  fail:(AFNErrorBlock)fail;

//新增分享二维码
+ (void)shareQRAdd:(NSString *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail;

//删除分享二维码(通)
+ (void)DeleteQRAdd:(NSString *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail;

//申请办卡
//+ (void)ApplicationCard:(NSString *)params
//                success:(SuccessBlock)success
//                   fail:(AFNErrorBlock)fail;

//申请办卡
+ (void)ApplicationCard:(NSString *)params
                   url : (NSString *)url
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail;

//申请办卡(通)(改动)
+ (void)ApplicationCard:(NSString *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail;


//查询所有信用卡
+ (void)LookForCard:(NSDictionary *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail;

//提交审核信息
+ (void)SubmitInfo:(NSString *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail;

//查询更新信息
+ (void)LookUpdataInfo:(NSString *)params
               success:(SuccessBlock)success
                  fail:(AFNErrorBlock)fail;


//办卡链接
+ (void)BankLinkInfo:(NSDictionary *)params
             success:(SuccessBlock)success
                fail:(AFNErrorBlock)fail;

//条件筛选
+ (void)BankInfoSelected:(NSDictionary *)params
                 success:(SuccessBlock)success
                    fail:(AFNErrorBlock)fail;

//实名认证
+ (void)certification:(NSDictionary *)params
              success:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail;

//信用卡链接
+ (void)ApplyCreditLink:(NSDictionary *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail;

//信用卡链接
+ (void)CarCardType:(NSDictionary *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail;

//办卡奖励
+ (void)BankCardReward:(NSDictionary *)params
               success:(SuccessBlock)success
                  fail:(AFNErrorBlock)fail;

//办卡奖励 下拉列表
+ (void)BankCardRewardSelect:(NSDictionary *)params
                     success:(SuccessBlock)success
                        fail:(AFNErrorBlock)fail;

//信用卡处提款
+ (void)CreditGetCash:(NSString *)params
              success:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail;


// 添加分润银行卡信息
+ (void)rewardBankAdd:(NSDictionary *)params
              success:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail;

// 查询分润银行卡列表
+ (void)rewardBankCheck:(NSDictionary *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail;

// 删除分润银行卡列表
+ (void)deleteBankCheck:(NSDictionary *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail;

//所有银行logo和name
+ (void)AllBankInfo:(NSDictionary *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail;

//交易明细
+ (void)TradeDetailInfo:(NSDictionary *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail;

//交易明细某日
+ (void)moneySomeDay:(NSDictionary *)params
             success:(SuccessBlock)success
                fail:(AFNErrorBlock)fail;


//交易明细某日
+ (void)tradeMoneyDay:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail;

//交易明细周
+ (void)tradeMoneyWeek:(SuccessBlock)success
                  fail:(AFNErrorBlock)fail;

//交易明细月
+ (void)tradeMoneyMonth:(NSDictionary *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail;

//服务顾问
+ (void)serverAgentInfo:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail;


//扫码支付获取余额
+ (void)ScanDrawMoney:(NSDictionary *)params
              success:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail;


//版本升级
+ (void)queryMerchantinfo:(NSDictionary *)params
                  success:(SuccessBlock)success
                     fail:(AFNErrorBlock)fail;

// 贷款(房主带, 你我贷, 宅e呆)
+ (void)getLoanInfo:(NSDictionary *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail;

// 获取用户状态(不确定好不好使)
+ (void)getUserStatus:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail;

// 获取通知列表
+ (void)getMessageList:(SuccessBlock)success
                  fail:(AFNErrorBlock)fail;

// 我要贷款
+ (void)loanInfo:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail;

// 分润处确认提款(即下一步)
+ (void)SureGetMoney:(NSString *)params
             success:(SuccessBlock)success
                fail:(AFNErrorBlock)fail;

// 版本更新
+ (void)updateVersion:(NSString *)params
              success:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail;

@end
