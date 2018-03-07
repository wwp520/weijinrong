//
//  DongManager.m
//  weijinrong
//
//  Created by RY on 17/4/28.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "DongManager.h"

@implementation DongManager

// 登录(通)
+ (void)login:(NSDictionary *)params
     username:(NSString *)username
      success:(SuccessBlock)success
         fail:(AFNErrorBlock)fail{
    
    // 链接+参数
    //http://172.16.7.106:8088/sendmanage/login?
    //http://223.98.189.173:8081/sendmanage/login?
    //%@login?     //正产
    //%@login?param=%@
    //%@login?
    //%@   //测试
    
    
    NSString *oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              username, @"userName",
                              @"pmsMerchantInfoAction/merchantLogin.action",@"url",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@login?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//获取session(未)
+ (void)getSession:(NSDictionary *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail {
    // 链接+参数http://zxd-pc:8080/sendmanage/getsession?param=%@
    //
    
    NSString *str = [NSString stringWithFormat:@"%@getsession?param=%@",KHost,[KKTools dictionaryToJson2:params]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//获取主页显示数据
+ (void)getiOSlogined:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail {
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"pmsAppNoticeAction/iosStatus.action",@"url",
                              @"",@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];

    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}



//退出登录(通)
+(void)logout:(NSDictionary *)params
        success:(SuccessBlock)success
           fail:(AFNErrorBlock)fail{
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             [SaveManager getStringForKey:@"token"],@"token",
                             oldParam,@"inParam",nil];

    // 链接+参数
    NSString *str = [NSString stringWithFormat:@"%@logout?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


// 验证码(通)
+ (void)code:(NSDictionary *)params
     success:(SuccessBlock)success
        fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    
    NSDictionary *newParam = [[NSDictionary alloc]initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"pmsMessageAction/captchaValidation.action",@"url",
//                              [SaveManager  getStringForKey:@"token"],@"token",
//                              [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:params success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}



//注册(通)
+ (void)registe:(NSDictionary *)params
        success:(SuccessBlock)success
           fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    
    NSDictionary * newParam = [[NSDictionary alloc]initWithObjectsAndKeys:
                               GetAccount, @"userName",
                               oldParam,@"inParam",
                               @"pmsMerchantInfoAction/merchantRegister.action",@"url",
                               [SaveManager  getStringForKey:@"token"],@"token",
                               [SaveManager  getStringForKey:@"session"],@"session",
                               nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

// 修改密码(通)
+ (void)forget:(NSDictionary *)params
       success:(SuccessBlock)success
          fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc]initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"pmsMerchantInfoAction/retrievePasswordValidationConfirm.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam" ,nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

// 忘记密码()
+ (void)pwdChange:(NSDictionary *)params
          success:(SuccessBlock)success
             fail:(AFNErrorBlock)fail {
    
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary * newParam = [[NSDictionary alloc]initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"pmsMerchantInfoAction/changePassword.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam" ,nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

// 银行卡列表(通)
+ (void)bankCardList:(NSDictionary *)params
             success:(SuccessBlock)success
                fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:@{@"mercId":[SaveManager  getStringForKey:@"mercId"]}];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"pmsMerchantInfoAction/selectBankMessage.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}



// 银行列表(通)
+ (void)bankList:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"payCmmtufitAction/searchBankList.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}


// 更改银行卡(通)
+ (void)changeBankCard:(NSDictionary *)params
               success:(SuccessBlock)success
                  fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"pmsMerchantInfoAction/updateBankCard.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}

// 获取金额(通)
+ (void)getMoney:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[SaveManager  getStringForKey:@"mercId"],@"mercId", nil];
        NSString *str = [KKTools dictionaryToJson:dict];
        [KKTools encryptionJsonString:str];
    })];
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"drawMoneyAction/selectUser.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}


// 意见反馈(通)
+ (void)chatUs:(NSDictionary *)params
       success:(SuccessBlock)success
          fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"MerchantsFeedbackAction/merchantInsert.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}

// 验证码(通)
+ (void)getCode:(NSDictionary *)params
        success:(SuccessBlock)success
           fail:(AFNErrorBlock)fail{
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    
    NSDictionary *newParam = [[NSDictionary alloc]initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             @"pmsMessageAction/captchaValidation.action",@"url",
                             oldParam,@"inParam",nil];


    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];


}


//密码修改(通)
+ (void)changePass:(NSDictionary *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             @"pmsMerchantInfoAction/changePasswordValidationConfirm.action",@"url",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}


// 图片上传（wei）
+ (void)upload:(NSDictionary *)params
        images:(NSArray *)images
       success:(SuccessBlock)success
          fail:(AFNErrorBlock)fail
       progess:(CurrentProgress)progess {
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:params[@"param"]]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager uploadWithparam:nil UrlString:str1 fileArrya:images successBlock:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } failBlock:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:^(double progress) {
        if (progess) {
            progess(progress);
        }
    }];
    
}

// 微信二维码(通)
+ (void)weiChatPay:(NSDictionary *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"pmsNoCardTransInfoAction/weChatNocardInfo.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

// 支付宝二维码(通)
+ (void)alipyPay:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"pmsNoCardTransInfoAction/AlipayNocardInfo.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

// 获取支付状态(通)
+ (void)payState:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"pmsNoCardTransInfoAction/paymentInquiry.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}



//(提款处)余额(通)
+ (void)moneyInfo:(NSDictionary *)params
          success:(SuccessBlock)success
             fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:@{@"mercId":[SaveManager  getStringForKey:@"mercId"],@"creationName":GetAccount}];
        [KKTools encryptionJsonString:str];
    })];
    
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"drawMoneyAction/selectUser.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}


// 提款信息
+ (void)moneyDetail:(NSDictionary *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:@{@"mercId":[SaveManager  getStringForKey:@"mercId"]}];
        [KKTools encryptionJsonString:str];
    })];
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"drawMoneyAction/DrawmoneyDetail.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];

    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}

// 提款
+ (void)moneyNow:(NSString *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail {
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"drawMoneyAction/wechatDreawmoney.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//管卡处银行卡列表
+ (void)getBankCardList:(NSDictionary *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:@{@"mercId":[SaveManager  getStringForKey:@"mercId"]}];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/CreditInfo.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//管卡处银行卡列表详情(通)
+ (void)getBankCardListDelteil:(NSString *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail {
    
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/creditDetails.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//积分(通)
+ (void)Integral:(NSString *)params
                       success:(SuccessBlock)success
                          fail:(AFNErrorBlock)fail {
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/CardBenefitsIntegral.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];
   
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//手动导入(通)
+ (void)AutoAdd:(NSString *)params
      success:(SuccessBlock)success
         fail:(AFNErrorBlock)fail {
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/saveCreditCard.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}



//邮箱导入()
+ (void)Email:(NSString *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail {
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/cardEmail.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];

    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//积分处（银行logo）(通)
+ (void)Logo:(NSString *)params
      success:(SuccessBlock)success
         fail:(AFNErrorBlock)fail{
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/BankInfo.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];

    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//卡惠(通)
+ (void)CardBenefit:(NSString *)params
     success:(SuccessBlock)success
        fail:(AFNErrorBlock)fail{
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/CardBenefitsIntegral.action",@"url",
                             [SaveManager getStringForKey:@"token"],@"token",
                             [SaveManager getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];
    
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//精卡推荐(通)
+ (void)CardRecommend:(NSString *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail{
    NSMutableDictionary *newParam = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"PmsCreditInfoAction/recommendCard.action",@"url",
                             [SaveManager getStringForKey:@"token"],@"token",
                             [SaveManager getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];
    if (GetAccount && GetAccount.length != 0 || [SaveManager getStringForKey:@"token"] || [SaveManager getStringForKey:@"session"]) {
        [newParam setValue:GetAccount forKey:@"userName"];
    }
       
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//卡惠精选(通)
+ (void)CardBenefitSelect:(NSString *)params
              success:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail{
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/CreditCard.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//分享二维码列表(通)
+ (void)shareQRList:(NSString *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail {
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/recommend.action",@"url",
                             [SaveManager getStringForKey:@"token"],@"token",
                             [SaveManager getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//修改分享二维码(通)
+ (void)shareQRReplace:(NSString *)params
               success:(SuccessBlock)success
                  fail:(AFNErrorBlock)fail {
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/updateRecommend.action",@"url",
                             [SaveManager getStringForKey:@"token"],@"token",
                             [SaveManager getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];
   
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//新增分享二维码(通)
+ (void)shareQRAdd:(NSString *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail {
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/insertRecommend.action",@"url",
                             [SaveManager getStringForKey:@"token"],@"token",
                             [SaveManager getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];
   
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//删除分享二维码(通)
+ (void)DeleteQRAdd:(NSString *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail {
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"PmsCreditInfoAction/deleteRecommend.action",@"url",
                              [SaveManager getStringForKey:@"token"],@"token",
                              [SaveManager getStringForKey:@"session"],@"session",
                              params,@"inParam",nil];
    
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//申请办卡(通)
+ (void)ApplicationCard:(NSString *)params
                   url : (NSString *)url
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail {
    
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"PmsCreditInfoAction/applyCredit.action",@"url",
                              [SaveManager getStringForKey:@"token"],@"token",
                              [SaveManager getStringForKey:@"session"],@"session",
                              params,@"inParam",nil];

    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    

    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//申请办卡(通)(改动)
+ (void)ApplicationCard:(NSString *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail{

    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"PmsCreditInfoAction/applyCredit.action",@"url",
                              [SaveManager getStringForKey:@"token"],@"token",
                              [SaveManager getStringForKey:@"session"],@"session",
                              params,@"inParam",nil];
    
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}



//查询所有信用卡(通)
+ (void)LookForCard:(NSDictionary *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [SaveManager  getStringForKey:@"mercId"],@"mercId", nil]];  //类型
        [KKTools encryptionJsonString:str];
    })];
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/applyBankList.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//提交审核信息(通)
+ (void)SubmitInfo:(NSString *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail {
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/updateApplyCredit.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//查询更新信息(通)
+ (void)LookUpdataInfo:(NSString *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail {
    
        
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/applyBank.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             params,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//办卡链接(通)
+ (void)BankLinkInfo:(NSDictionary *)params
               success:(SuccessBlock)success
                  fail:(AFNErrorBlock)fail {
    
    NSString *oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [SaveManager  getStringForKey:@"mercId"],@"mercId",
                                                   nil]];  //类型
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/BankInfo.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//条件筛选(通)
+ (void)BankInfoSelected:(NSDictionary *)params
             success:(SuccessBlock)success
                fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [SaveManager  getStringForKey:@"mercId"],@"mercId",
                              nil];
        NSString *str = [KKTools dictionaryToJson:dict];  //类型
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"PmsCreditInfoAction/BankInfo.action",@"url",
                             [SaveManager getStringForKey:@"token"],@"token",
                             [SaveManager getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}
//实名认证
+ (void)certification:(NSDictionary *)params
              success:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail {
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:params[@"param"]]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//信用卡链接
+ (void)ApplyCreditLink:(NSDictionary *)params
              success:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail {
    
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:@{@"mercId":[SaveManager  getStringForKey:@"mercId"]}];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"PmsCreditInfoAction/cardLinkList.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    
//    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",[KKTools dictionaryToJson2:params]];
//    
//    // 转UTF-8
//    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//信用卡链接
+ (void)CarCardType:(NSDictionary *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail{

    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [SaveManager  getStringForKey:@"mercId"],@"mercId", nil];
        NSString *str = [KKTools dictionaryToJson:dict];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"PmsCreditInfoAction/cardselect.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//办卡奖励
+ (void)BankCardReward:(NSDictionary *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail{
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [SaveManager  getStringForKey:@"mercId"],@"mercId", nil];
        NSString *str = [KKTools dictionaryToJson:dict];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"PmsNoCardTransInfoAwardAction/applyAward.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//办卡奖励 下拉列表
+ (void)BankCardRewardSelect:(NSDictionary *)params
                     success:(SuccessBlock)success
                        fail:(AFNErrorBlock)fail {
    
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"PmsNoCardTransInfoAwardAction/applyAwardDemand.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//信用卡处提款
+ (void)CreditGetCash:(NSString *)params
               success:(SuccessBlock)success
                  fail:(AFNErrorBlock)fail{
    
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"PmsNoCardTransInfoAwardAction/applyDeposit.action.action",@"url",
                              [SaveManager getStringForKey:@"token"],@"token",
                              [SaveManager getStringForKey:@"session"],@"session",
                              params,@"inParam",nil];

    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


// 添加分润银行卡信息
+ (void)rewardBankAdd:(NSDictionary *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"pmsMerchantBindingcardInfoAction/addBankCard.action",@"url",
                              [SaveManager getStringForKey:@"token"],@"token",
                              [SaveManager getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
    
}



// 查询分润银行卡列表
+ (void)rewardBankCheck:(NSDictionary *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"pmsMerchantBindingcardInfoAction/bindingCardList.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
    
}



// 删除分润银行卡列表
+ (void)deleteBankCheck:(NSDictionary *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"pmsMerchantBindingcardInfoAction/deleteBindingCard.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
    
}

////所有银行logo和name
+ (void)AllBankInfo:(NSDictionary *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail{
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:@{@"mercId":[SaveManager  getStringForKey:@"mercId"]}];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"PmsCreditInfoAction/BankInfoAll.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//交易明细
+ (void)TradeDetailInfo:(NSDictionary *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail{
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:@{@"mercId":[SaveManager  getStringForKey:@"mercId"]}];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"PmsCreditInfoAction/BankInfoAll.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//交易明细某日
+ (void)moneySomeDay:(NSDictionary *)params
             success:(SuccessBlock)success
                fail:(AFNErrorBlock)fail {
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"pmsNoCardTransInfoRMFAction/monthTransaction.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//交易明细某日
+ (void)tradeMoneyDay:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail {
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                [SaveManager getStringForKey:@"mercId"],@"mercId", nil];
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"pmsNoCardTransInfoRMFAction/transactionDetail.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//交易明细周
+ (void)tradeMoneyWeek:(SuccessBlock)success
                  fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                [SaveManager getStringForKey:@"mercId"],@"mercId", nil];
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"pmsNoCardTransInfoRMFAction/weekTransaction.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];

}

//交易明细月
+ (void)tradeMoneyMonth:(NSDictionary *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail {
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"pmsNoCardTransInfoRMFAction/monthTransactionsum.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


//扫码支付获取余额
+ (void)ScanDrawMoney:(NSDictionary *)params
                success:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail{
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:@{@"mercId":[SaveManager  getStringForKey:@"mercId"]}];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"drawMoneyAction/selectUser.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//服务顾问
+ (void)serverAgentInfo:(SuccessBlock)success
                   fail:(AFNErrorBlock)fail {
    NSString *oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                [SaveManager getStringForKey:@"mercId"],@"mercId",
                                ChannelNumber,@"agentName", nil];
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"commonAction/getAgentInfo.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

//版本升级
+ (void)queryMerchantinfo:(NSDictionary *)params
                  success:(SuccessBlock)success
                     fail:(AFNErrorBlock)fail {
    
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"PmsVersionUpgradeAction/queryviewKyMerchantinfo.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

// 贷款(房主带, 你我贷, 宅e呆)
+ (void)getLoanInfo:(NSDictionary *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail {
    
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"loanOrder",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];

}

// 获取用户状态(不确定好不好使)  saveRealNameAuthenticationInformation
+ (void)getUserStatus:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail {
    
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                GetAccount,@"mobilePhone",
                                [SaveManager getStringForKey:@"mercId"],@"mercId", nil];
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
//                              @"pmsAppNoticeAction/merchantInfoStatus.action",@"url",
            @"pmsAppNoticeAction/merchantInfoStatus.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

// 获取通知列表
+ (void)getMessageList:(SuccessBlock)success
                  fail:(AFNErrorBlock)fail {
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                [SaveManager getStringForKey:@"mercId"],@"mercId", nil];
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"pmsAppNoticeAction/pmsAppNotice.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}

// 我要贷款
+ (void)loanInfo:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail {
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                [SaveManager getStringForKey:@"mercId"],@"mercId", nil];
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"loanOrder",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              oldParam,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


// 分润处确认提款(即下一步)
+ (void)SureGetMoney:(NSString *)params
            success:(SuccessBlock)success
               fail:(AFNErrorBlock)fail {
    
    
//    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
//        NSString *str = [KKTools dictionaryToJson:params];
//        [KKTools encryptionJsonString:str];
//    })];
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"pmsMerchantBindingcardInfoAction/updateDefault.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              params,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}


// 版本更新
+ (void)updateVersion:(NSString *)params
              success:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail {
      
    NSDictionary *newParam = [[NSDictionary alloc] initWithObjectsAndKeys:
                              GetAccount, @"userName",
                              @"PmsVersionUpgradeAction/queryviewKyMerchantinfo.action",@"url",
                              [SaveManager  getStringForKey:@"token"],@"token",
                              [SaveManager  getStringForKey:@"session"],@"session",
                              params,@"inParam",nil];
    
    NSString *str = [NSString stringWithFormat:@"%@dojob?param=%@",KHost,[KKTools dictionaryToJson2:newParam]];
    
    // 转UTF-8
    NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [AFNManager GET:str1 param:nil success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}


@end
