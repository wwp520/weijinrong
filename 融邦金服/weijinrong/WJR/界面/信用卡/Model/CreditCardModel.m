//
//  CreditCardModel.m
//  weijinrong
//
//  Created by ouda on 17/5/18.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CreditCardModel.h"

@implementation CreditCardModel

@end


@implementation CreditCardListModel
+(void)load{
    [CreditCardModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list":@"CreditCardListModel"
                 };
    }];
}

@end
