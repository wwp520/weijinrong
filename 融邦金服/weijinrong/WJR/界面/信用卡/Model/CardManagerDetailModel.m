//
//  CardManagerDetailModel.m
//  weijinrong
//
//  Created by ouda on 17/5/11.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CardManagerDetailModel.h"

@implementation CardManagerBillListModel

@end

@implementation CardManagerDetailModel

@end

@implementation CardManagerDetailListModel

+(void)load{
    [CardManagerDetailModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"DetailsList":@"CardManagerDetailListModel",
                 @"BillDetailList":@"CardManagerBillListModel"
                };
    }];
}
@end

