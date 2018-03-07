//
//  BankLinkInfoModel.m
//  weijinrong
//
//  Created by ouda on 17/5/25.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BankLinkInfoModel.h"

@implementation BankLinkInfoModel
+ (void)load {
    [BankLinkInfoModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"bank" : @"BankLinkInfoListModel"
                 };
    }];
}
@end


@implementation BankLinkInfoListModel

@end
