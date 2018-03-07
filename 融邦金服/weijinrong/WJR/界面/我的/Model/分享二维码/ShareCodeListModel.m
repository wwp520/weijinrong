//
//  ShareCodeListModel.m
//  weijinrong
//
//  Created by RY on 17/5/24.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "ShareCodeListModel.h"

@implementation ShareCodeListSubModel

@end


@implementation ShareCodeListModel
+ (void)load {
    [ShareCodeListModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list":@"ShareCodeListSubModel"
                 };
    }];
}
@end
