//
//  MySelfModel.h
//  chengzizhifu
//
//  Created by 快易 on 15/1/9.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "BaseModel.h"

@interface MySelfModel : BaseModel
@property (nonatomic,assign)NSInteger mercSts;
@property (nonatomic,copy) NSString * laLace;
@property (nonatomic,copy) NSString * mercStsMessage;
@property (nonatomic,copy) NSString *mercLevel;//等级

@property (nonatomic,copy) NSString * balance;
@property (nonatomic,copy) NSString * freezeBalance;
@property (nonatomic,copy) NSString * availableBalance;
@property (nonatomic,copy) NSString * backReason;
@property (nonatomic, copy) NSString *wechatbalance;    //微信余额

@property (nonatomic, strong) NSString *amount;

@end



@interface RedPacketModel : BaseModel
@property (nonatomic, copy) NSString *redPacked;
@end
