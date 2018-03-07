//
//  CardBenifitModel.m
//  weijinrong
//
//  Created by ouda on 17/5/23.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CardBenifitModel.h"

@implementation CardBenifitModel

@end

@implementation CardBenifitListModel
+(void)load{
    [CardBenifitModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list":@"CardBenifitListModel"
                 };
    }];
}
@end
