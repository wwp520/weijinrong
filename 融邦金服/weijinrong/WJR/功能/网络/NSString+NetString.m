//
//  NSString+NetString.m
//  weijinrong
//
//  Created by RY on 17/4/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "NSString+NetString.h"

//#define kHost @"http://223.98.189.173:8080/payment_app"   // 孝欢本地
#define kHost          @"http://lkl.oudapay.com:8108/payment_app"    // 融邦金服正式
#define NHost          @"http://lkl.oudapay.com:8107/loan"           // 实名认证
#define MHost          @"http://lkl.oudapay.com:8108/payment_app"    // 提款
#define THost          @"http://123.59.106.50:8185/ouda_pms"         // 审核图片

#define login_URL           @"/pmsMerchantInfoAction/merchantLogin.action"
#define register_URL        @"/pmsMerchantInfoAction/merchantRegister.action"
#define code_URL            @"/pmsMessageAction/captchaValidation.action"
#define forget_URL          @"/pmsMerchantInfoAction/retrievePasswordValidationConfirm.action"
#define changePwd_URL       @"/pmsMerchantInfoAction/changePassword.action"
#define bankCardList_URL    @"/pmsMerchantInfoAction/selectBankMessage.action"
#define bankList_URL        @"/payCmmtufitAction/searchBankList.action"
#define changeBankCard_URL  @"/pmsMerchantInfoAction/updateBankCard.action"
#define money_URL           @"/drawMoneyAction/selectUser.action"
#define chatUS_URL          @"/MerchantsFeedbackAction/merchantInsert.action"
#define changePwd2_URL      @"/pmsMerchantInfoAction/changePasswordValidationConfirm.action"
#define uplodeImage_URL     @"/upload"
#define fileautograph_URL   @"/upload"
#define saveRealName_URL    @"/pmsMerchantInfoAction/saveRealNameAuthenticationInformation.action"
#define weiChat_URL         @"/pmsNoCardTransInfoAction/weChatNocardInfo.action"
#define alipy_URL           @"/pmsNoCardTransInfoAction/AlipayNocardInfo.action"
#define payState_URL        @"/pmsNoCardTransInfoAction/paymentInquiry.action"
#define moneyInfo_URL       @"/drawMoneyAction/selectUser.action"
#define moneyDetail_URL     @"/drawMoneyAction/DrawmoneyDetail.action"
#define moneyNow_URL        @"/drawMoneyAction/wechatDreawmoney.action"
#define getBankCardList_url @"/PmsCreditInfoAction/CreditInfo.action"    //信用卡
#define getBankCardListDelteil_url  @"/PmsCreditInfoAction/creditDetails.action"
#define Integral_URL        @"/PmsCreditInfoAction/CardBenefitsIntegral.action"  //积分
#define Email               @"/PmsCreditInfoAction/cardEmail.action"
#define AutoAdd_URl         @"/PmsCreditInfoAction/saveCreditCard.action"
#define Logo_URL            @"/PmsCreditInfoAction/BankInfo.action"    //积分（logo）
#define CardBenefit         @"/PmsCreditInfoAction/CardBenefitsIntegral.action" //卡惠
#define CardRecommend       @"/PmsCreditInfoAction/recommendCard.action"
#define CardBenefitSelect   @"/PmsCreditInfoAction/CreditCard.action"

#define ApplicationCard     @"/PmsCreditInfoAction/applyCredit.action"
#define LookForCard         @"/PmsCreditInfoAction/applyBankList.action"
#define SubmitInfo          @"/PmsCreditInfoAction/updateApplyCredit.action"
#define LookUpdataInfo      @"/PmsCreditInfoAction/applyBank.action"
#define BankLinkInfo        @"/PmsCreditInfoAction/BankInfo.action"
#define BankInfoSelected    @"/ PmsCreditInfoAction/BankInfo.action"

#pragma mark - 实现
@implementation NSString (NetString)



+ (NSString *)getLogin {
    return [NSString stringWithFormat:@"%@%@",kHost,login_URL];
}
+ (NSString *)getRegister {
    return [NSString stringWithFormat:@"%@%@",kHost,register_URL];
}
+ (NSString *)getCode {
    return [NSString stringWithFormat:@"%@%@",kHost,code_URL];
}
+ (NSString *)getForget {
    return [NSString stringWithFormat:@"%@%@",kHost,forget_URL];
}
+ (NSString *)getPwdChange {
    return [NSString stringWithFormat:@"%@%@",kHost,changePwd_URL];
}
+ (NSString *)getBankCardList_URL {
    return [NSString stringWithFormat:@"%@%@",kHost,bankCardList_URL];
}
+ (NSString *)getBankList_URL {
    return [NSString stringWithFormat:@"%@%@",kHost,bankList_URL];
}
+ (NSString *)getChangeBankCard_URL {
    return [NSString stringWithFormat:@"%@%@",kHost,changeBankCard_URL];
}
+ (NSString *)getMoney_URL {
    return [NSString stringWithFormat:@"%@%@",kHost,money_URL];
}
+ (NSString *)getChatUS_URL {
    return [NSString stringWithFormat:@"%@%@",kHost,chatUS_URL];
}
+ (NSString *)getChangePwd2_URL {
    return [NSString stringWithFormat:@"%@%@",kHost,changePwd2_URL];
}
+ (NSString *)getUplodeImage_URL {
    return [NSString stringWithFormat:@"%@%@",NHost,uplodeImage_URL];
}
+ (NSString *)get_fileautograph_url{
    return [NSString stringWithFormat:@"%@%@",THost,fileautograph_URL];
}
+ (NSString *)getSaveRealName_URL {
    return [NSString stringWithFormat:@"%@%@",kHost,saveRealName_URL];
}
+ (NSString *)getWeiChat_URL {
    return [NSString stringWithFormat:@"%@%@",kHost,weiChat_URL];
}
+ (NSString *)getAlipy_URL {
    return [NSString stringWithFormat:@"%@%@",kHost,alipy_URL];
}
+ (NSString *)getPayState_URL {
    return [NSString stringWithFormat:@"%@%@",kHost,payState_URL];
}
+ (NSString *)getMoneyInfo_URL {
    return [NSString stringWithFormat:@"%@%@",kHost,moneyInfo_URL];
}
+ (NSString *)getMoneyDetail_URL {
    return [NSString stringWithFormat:@"%@%@",kHost,moneyDetail_URL];
}
+ (NSString *)getMoneyNow_URL {
    return [NSString stringWithFormat:@"%@%@",MHost, moneyNow_URL];
}
//信用卡
+ (NSString *)getCredit_url{
   return [NSString stringWithFormat:@"%@%@",kHost, getBankCardList_url];
}
+ (NSString *)getCreditList_url{
    return [NSString stringWithFormat:@"%@%@",kHost,getBankCardListDelteil_url];
}

//=================================================================================
// 加密解密
+ (NSDictionary *)getRequestparamWithDict:(NSDictionary *)params {
    if (params == nil) {
        return nil;
    }
    NSString *str1 = [self dictionaryToJson:params];
    return @{@"requestData":[KKTools encryptionJsonString:str1]};
}
// 字典转换为 json 字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


@end
