//
//  IntegralModel.m
//  weijinrong
//
//  Created by ouda on 17/5/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "IntegralModel.h"

@implementation IntegralModel

@end


@implementation IntegralListModel
+(void)load{
    [IntegralModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list":@"IntegralListModel"
                 };
    }];
}
@end
