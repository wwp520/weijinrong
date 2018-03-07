//
//  UserPushModel.m
//  weijinrong
//
//  Created by RY on 17/6/16.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "UserPushModel.h"

@implementation UserPushModel

+ (void)load {
    [UserPushModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"title" : @"aps.alert.title",
                 @"body" : @"aps.alert.body"
                 };
    }];
    
//    @"ID" : @"id",
//    @"desc" : @"desciption",
//    @"oldName" : @"name.oldName",
//    @"nowName" : @"name.newName",
//    @"nameChangedTime" : @"name.info[1].nameChangedTime",
//    @"bag" : @"other.bag"
    
}

@end
