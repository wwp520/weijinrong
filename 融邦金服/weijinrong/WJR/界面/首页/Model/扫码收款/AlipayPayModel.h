//
//  AlipayPayModel.h
//  chengzizhifu
//
//  Created by Mac on 16/9/2.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "BaseModel.h"

@interface AlipayPayModel : BaseModel
//{"merchantNo":"997201608155868","terminalId":"","orderNum":"147277873530656084","resResult":"0","resultInfo":"成功","notifyUrl":"https://qr.alipay.com/bax03486u2yxgixk5ehh80ef"}
//{"retCode":"1","retMessage":"系统异常","merchantNo":"","orderNum":""}

//10月20号的
//{"merchantNo":"991201608150875","terminalId":"1","orderNum":"147694566037464070","retCode":"0","retMessage":"成功","codeUrl":"https://qr.alipay.com/bax06009ajjfhycjenjp4001"}

@property (nonatomic, copy) NSString *merchantNo;
@property (nonatomic, copy) NSString *terminalId;
@property (nonatomic, copy) NSString *orderNum;
//@property (nonatomic, copy) NSString *resResult;
//@property (nonatomic, copy) NSString *resultInfo;
@property (nonatomic, copy) NSString *codeUrl;

@end
