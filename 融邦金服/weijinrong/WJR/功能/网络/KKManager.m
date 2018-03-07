//
//  文件名: KKManager.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/10
//

#import "KKManager.h"
#import "NSString+NetString.h"

#pragma mark - 实现
@implementation KKManager

// 登录
+ (void)login:(NSDictionary *)params
      success:(SuccessBlock)success
         fail:(AFNErrorBlock)fail {
    
    
    NSString *oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *params2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"pmsMerchantInfoAction/merchantLogin.action",@"url",
                             oldParam,@"inParam",nil];
    NSDictionary *newParam = @{@"param":params2};
    [AFNManager GET:[NSString getLogin] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}
// 验证码
+ (void)code:(NSDictionary *)params
     success:(SuccessBlock)success
        fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getCode] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}
// 注册
+ (void)registe:(NSDictionary *)params
        success:(SuccessBlock)success
           fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getRegister] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}
// 忘记密码
+ (void)forget:(NSDictionary *)params
       success:(SuccessBlock)success
          fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getForget] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}
// 修改密码
+ (void)pwdChange:(NSDictionary *)params
          success:(SuccessBlock)success
             fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getPwdChange] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}
// 银行卡列表
+ (void)bankCardList:(NSDictionary *)params
             success:(SuccessBlock)success
                fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getBankCardList_URL] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}
// 银行列表
+ (void)bankList:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getBankList_URL] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];

}
// 更改银行卡
+ (void)changeBankCard:(NSDictionary *)params
               success:(SuccessBlock)success
                  fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getChangeBankCard_URL] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}
// 获取金额
+ (void)getMoney:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getMoney_URL] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}
// 意见反馈
+ (void)chatUs:(NSDictionary *)params
       success:(SuccessBlock)success
          fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getChatUS_URL] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}
// 修改密码
+ (void)changePass:(NSDictionary *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getChangePwd2_URL] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}
// 图片上传(wei)
+ (void)upload:(NSDictionary *)params
        images:(NSArray *)images
       success:(SuccessBlock)success
          fail:(AFNErrorBlock)fail
       progess:(CurrentProgress)progess {
    [AFNManager uploadWithparam:[NSString getRequestparamWithDict:params] UrlString:[NSString getUplodeImage_URL] fileArrya:images successBlock:^(id requestData) {
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

// 审核图片
+ (void)fileautograph:(NSDictionary *)params
                image:(AFNFileModel *)image
              success:(SuccessBlock)success
                 fail:(AFNErrorBlock)fail
              progess:(CurrentProgress)progess {
    [AFNManager uploadWithparam:[NSString getRequestparamWithDict:params] UrlString:[NSString get_fileautograph_url] fileArrya:@[image] successBlock:^(id requestData) {
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
// 图片上传后要上传的(wei)
+ (void)saveRealName:(NSDictionary *)params
             success:(SuccessBlock)success
                fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getSaveRealName_URL] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}

// 微信二维码(wei)
+ (void)weiChatPay:(NSDictionary *)params
           success:(SuccessBlock)success
              fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getWeiChat_URL] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}

// 支付宝二维码(wei)
+ (void)alipyPay:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getAlipy_URL] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
}
// 获取支付状态(wei)
+ (void)payState:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getPayState_URL] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
        if (success) {
            success(requestData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    } progress:nil];
    
}
//(提款处)余额   (通)
+ (void)moneyInfo:(NSDictionary *)params
          success:(SuccessBlock)success
             fail:(AFNErrorBlock)fail {
    
    [AFNManager GET:[NSString getMoneyInfo_URL] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
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
    [AFNManager GET:[NSString getMoneyDetail_URL] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
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
+ (void)moneyNow:(NSDictionary *)params
         success:(SuccessBlock)success
            fail:(AFNErrorBlock)fail {
    [AFNManager GET:[NSString getMoneyNow_URL] param:[NSString getRequestparamWithDict:params] success:^(id requestData) {
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
