//
//  RewardBankModel.m
//  weijinrong
//
//  Created by ouda on 17/6/13.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "RewardBankModel.h"

@implementation RewardBankListModel

@end

@implementation RewardBankModel
+ (void)load {
    [RewardBankModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list" : @"RewardBankListModel"
                 };
    }];
}
@end
