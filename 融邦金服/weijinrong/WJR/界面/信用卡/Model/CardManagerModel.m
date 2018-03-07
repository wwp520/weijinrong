//
//  CardManagerModel.m
//  weijinrong
//
//  Created by RY on 17/5/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CardManagerModel.h"

@implementation CardManagerModel

@end


@implementation CardManagerInfoModel

+(void)load{
    [CardManagerModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list":@"CardManagerInfoModel"
                 };
    }];
}

@end
