//
//  RunCardModel.m
//  weijinrong
//
//  Created by ouda on 17/5/24.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "RunCardModel.h"



@implementation RunCardModel

@end


@implementation RunCardListModel
+(void)load{
    [RunCardModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list":@"RunCardListModel"
                 };
    }];
}
@end
