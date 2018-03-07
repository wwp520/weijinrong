//
//  TransDayModel.h
//  chengzizhifu
//
//  Created by RY on 17/1/19.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "BaseModel.h"


@interface TransDaySubModel : BaseModel
@property (nonatomic, strong) NSString *dealTime;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *orderNum;
@end


@interface TransDayModel : BaseModel
@property (nonatomic, strong) NSString *sumMoney;
@property (nonatomic, strong) NSString *WeChatMoney;
@property (nonatomic, strong) NSString *WeChatStroke;
@property (nonatomic, strong) NSString *alipayMoney;
@property (nonatomic, strong) NSString *alipayStroke;
@property (nonatomic, strong) NSArray<TransDaySubModel *>  *WeChat;
@property (nonatomic, strong) NSArray<TransDaySubModel *>  *alipay;

@property (nonatomic, strong) NSString *status;
@end

/*
 {
 "sumMoney":"0",
 "WeChatMoney":"0",
 "WeChatStroke":"0",
 "alipayMoney":"0",
 "alipayStroke":"0",
 "WeChat":[
 
 ],
 "retCode":0,
 "retMessage":"成功"
 }
 */
