//
//  CardWelfareModel.m
//  weijinrong
//
//  Created by ouda on 17/5/18.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CardWelfareModel.h"

@implementation CardWelfareModel

@end


@implementation CardWelfareListModel
+(void)load{
    [CardWelfareModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list":@"CardWelfareListModel"
                 };
    }];
}
@end




