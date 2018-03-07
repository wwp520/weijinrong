//
//  WithdrawalSuccController.h
//  chengzizhifu
//
//  Created by RY on 17/1/17.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "BaseViewController.h"

@interface WithdrawalSuccController : BaseViewController
@property (nonatomic,copy) NSString * merchatName;   //用户名
@property (nonatomic,copy) NSString * payAmount;     //金额
@property (nonatomic,copy) NSString * orderNumber;   //订单号
@property (nonatomic,copy) NSString * tradingHours;  // 时间
@property (nonatomic, strong) NSString *successStr;
@property(nonatomic,strong)NSString * type;
@end
