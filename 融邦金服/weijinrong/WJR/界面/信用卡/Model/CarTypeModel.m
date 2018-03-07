//
//  CarTypeModel.m
//  weijinrong
//
//  Created by ouda on 17/6/12.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CarTypeModel.h"

@implementation CarTypeModel
+ (void)load {
    // How to map
    [CarTypeListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"desc" : @"description"
                 };
    }];
}
@end

@implementation CarTypeListModel
+ (void)load {
    // How to map
    
    
    [CarTypeModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"cardType" : @"CarTypeListModel"
                 };
    }];
}
@end
