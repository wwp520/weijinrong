//
//  MessageListModel.m
//  chengzizhifu
//
//  Created by RY on 16/10/27.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "MessageListModel.h"
#import "MJExtension.h"

@implementation MessageListModel

+ (void)load {
    [MessageListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 };
    }];
}
@end
