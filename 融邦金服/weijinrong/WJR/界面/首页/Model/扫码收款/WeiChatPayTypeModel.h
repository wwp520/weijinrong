//
//  WeiChatPayTypeModel.h
//  chengzizhifu
//
//  Created by Mac on 16/8/29.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "BaseModel.h"

@interface WeiChatPayTypeModel : BaseModel
@property (nonatomic, copy) NSString *merchantNo;  //二维码地址
@property (nonatomic, copy) NSString *terminalId; //订单号
@property (nonatomic, copy) NSString *orderNum;
@property (nonatomic, copy) NSString *codeUrl;

@end
