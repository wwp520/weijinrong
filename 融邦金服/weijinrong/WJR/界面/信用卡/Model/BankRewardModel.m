//
//  BankRewardModel.m
//  weijinrong
//
//  Created by ouda on 17/6/12.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BankRewardModel.h"


@implementation BankRewardListModel

@end


@implementation BankRewardModel
+(void)load{
    [BankRewardModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list":@"BankRewardListModel"
                 };
    }];
}
@end
