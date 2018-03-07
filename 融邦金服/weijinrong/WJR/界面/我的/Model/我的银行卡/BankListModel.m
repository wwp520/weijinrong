//
//  BankListModel.m
//  chengzizhifu
//
//  Created by 快易 on 15/1/26.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "BankListModel.h"

@implementation BankListModel

@end

@implementation BankListInfoModel

+ (void)load {
    [BankListModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list" : @"BankListInfoModel"
                 };
    }];
}


@end

