//
//  文件名: KKManager.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/10
//

#import <Foundation/Foundation.h>

#pragma mark - 声明
@interface KKManager : NSObject

// 登录
+ (void)login:(NSDictionary *)params
      success:(SuccessBlock)success
         fail:(AFNErrorBlock)fail;
// 验证码
+ (void)code:(NSDictionary *)params
     success:(SuccessBlock)success
        fail:(AFNErrorBlock)fail;
// 注册
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
// 银行列表
+ (void)bankList:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail;
// 更改银行卡
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
// 修改密码
+ (void)changePass:(NSDictionary *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail;
// 图片上传
+ (void)upload:(NSDictionary *)params
        images:(NSArray *)images
       success:(SuccessBlock)success
          fail:(AFNErrorBlock)fail
       progess:(CurrentProgress)progess;

// 图片上传后要上传的
+ (void)saveRealName:(NSDictionary *)params
             success:(SuccessBlock)success
                fail:(AFNErrorBlock)fail;
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
// 余额
+ (void)moneyInfo:(NSDictionary *)params
          success:(SuccessBlock)success
             fail:(AFNErrorBlock)fail;
// 提款信息
+ (void)moneyDetail:(NSDictionary *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail;
// 提款
+ (void)moneyNow:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail;
// 审核图片
+ (void)fileautograph:(NSDictionary *)params
                image:(AFNFileModel *)image
              success:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail
              progess:(CurrentProgress)progess;


@end
