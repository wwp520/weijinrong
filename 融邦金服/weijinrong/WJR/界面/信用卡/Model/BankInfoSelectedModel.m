//
//  BankInfoSelectedModel.m
//  weijinrong
//
//  Created by ouda on 17/5/26.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BankInfoSelectedModel.h"


@implementation BankInfoSelectedListModel

@end

@implementation CardTypeListModel
+ (void)load {
    // How to map
    [CardTypeListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"desc" : @"description"
                 };
    }];
}
@end

@implementation cardLevellModel
+ (void)load {
    
    // How to map
    [cardLevellModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"desc" : @"description"
                 };
    }];
}
@end
//全部银行
@implementation BankInfoSelectedModel
+ (void)load {
    
    
    [BankInfoSelectedModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"bank" : @"BankInfoSelectedListModel",
                 @"cardType" : @"CardTypeListModel",
                 @"cardLevell" : @"cardLevellModel"
                 };
    }];
}
@end



