//
//  WeiChatPayModel.h
//  chengzizhifu
//
//  Created by RY on 16/5/16.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "BaseModel.h"

@interface WeiChatPayModel : BaseModel
@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *responseCode;
@property (nonatomic, copy) NSString *responseMsg;

@end

@interface WeiChatPayState : BaseModel
@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *responseCode;
@property (nonatomic, copy) NSString *responseMsg;
@end
