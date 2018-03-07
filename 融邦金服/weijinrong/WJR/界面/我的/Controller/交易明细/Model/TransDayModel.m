//
//  TransDayModel.m
//  chengzizhifu
//
//  Created by RY on 17/1/19.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "TransDayModel.h"




/*
 
 @property (nonatomic, strong) NSString *sumMoney;
 @property (nonatomic, strong) NSString *WeChatMoney;
 @property (nonatomic, strong) NSString *WeChatStroke;
 @property (nonatomic, strong) NSString *alipayMoney;
 @property (nonatomic, strong) NSString *alipayStroke;
 @property (nonatomic, strong) NSArray  *WeChat;
 */
@implementation TransDayModel

+ (void)load{
    [TransDayModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"WeChat":@"TransDaySubModel",
                 @"alipay":@"TransDaySubModel",
                 };
    }];
}

@end

@implementation TransDaySubModel

@end
