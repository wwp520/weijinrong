//
//  WeiChatCoderModel.h
//  chengzizhifu
//
//  Created by RY on 16/5/17.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "BaseModel.h"

@interface WeiChatCoderModel : BaseModel
@property (nonatomic, copy) NSString *codeUrl;  //二维码地址
@property (nonatomic, copy) NSString *merchantNo;
@property (nonatomic, copy) NSString *orderNum;
@property (nonatomic, copy) NSString *terminalId;
@end
