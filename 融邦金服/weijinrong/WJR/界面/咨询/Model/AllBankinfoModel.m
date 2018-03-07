//
//  AllBankinfoModel.m
//  weijinrong
//
//  Created by ouda on 17/6/14.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "AllBankinfoModel.h"

@implementation AllBankinfoListModel

@end

@implementation AllBankinfoModel
+ (void)load {
    [AllBankinfoModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"bank" : @"AllBankinfoListModel"
                 };
    }];
}
@end
