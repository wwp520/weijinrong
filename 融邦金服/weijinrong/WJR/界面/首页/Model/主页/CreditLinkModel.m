//
//  CreditLinkModel.m
//  weijinrong
//
//  Created by ouda on 17/6/2.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CreditLinkModel.h"

@implementation CreditLinkModel

@end


@implementation CreditLinkListModel
+ (void)load {
    [CreditLinkModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list" : @"CreditLinkListModel",
                 };
    }];
}
@end
