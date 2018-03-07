//
//  RewardListModel.m
//  weijinrong
//
//  Created by ouda on 17/6/14.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "RewardListModel.h"

@implementation RewardListListModel

@end

@implementation RewardListModel
+(void)load{
    [RewardListModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"apply":@"RewardListListModel"
                 };
    }];
}
@end
