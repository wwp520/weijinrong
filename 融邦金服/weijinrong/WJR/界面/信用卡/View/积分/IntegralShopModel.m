//
//  IntegralShopModel.m
//  weijinrong
//
//  Created by ouda on 17/5/17.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "IntegralShopModel.h"

@implementation IntegralShopModel

@end


@implementation IntegralShopListModel
+(void)load{
    [IntegralShopModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"bank":@"IntegralShopListModel"
                 };
    }];
}

@end
