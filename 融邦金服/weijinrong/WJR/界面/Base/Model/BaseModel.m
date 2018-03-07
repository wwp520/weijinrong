//
//  BaseModel.m
//  BusinessPeople
//
//  Created by RY on 17/1/17.
//  Copyright © 2017年 RY. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (__kindof instancetype)decryptBecomeModel:(id)requestData {
    NSString *requestDataStr = requestData;
    NSString *name = NSStringFromClass(self);
    // requestData为空时
    if (requestDataStr.length == 0) {
        BaseModel *model = [[BaseModel alloc] init];
        model.retCode = 67;
        model.retMessage = @"无返回数据";
        return model;
    }
    NSMutableDictionary *newData = [NSMutableDictionary dictionaryWithDictionary:[KKTools dictionaryWithJsonString:requestData]];
    
    // 获取成功
    if ([newData[@"retCode"] isEqualToString:@"0"]) {
        // 保存token,session
        [self saveSessionToken:newData];
        // 解析
        NSString *requestStr = [KKTools decryptJsonString:newData[@"outParam"]];
        if ([requestStr isEqualToString:@"数据错误"]) {
            BaseModel *model = [[BaseModel alloc] init];
            model.retCode = 66;
            model.retMessage = @"无返回数据";
            return model;
        }
        Class modelClass = NSClassFromString(name);
        BaseModel *model = [modelClass mj_objectWithKeyValues:requestStr];
        return model;
    }
    // 令牌过期
    else if ([newData[@"retCode"] isEqualToString:@"1"]) {
        // 取消自动登录
        AutoLogin(@"0");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenOut" object:newData[@"retMsg"]];
        BaseModel *model = [[BaseModel alloc] init];
        model.retCode = 1;
        model.retMessage = newData[@"retMsg"];
        return model;
    }
    // 请登录
    else if ([newData[@"retCode"] isEqualToString:@"2"]) {
        //
        BaseModel *model = [[BaseModel alloc] init];
        model.retCode = 2;
        model.retMessage = newData[@"retMsg"];
        return model;
    }
    // 转发异常
    else {
        BaseModel *model = [[BaseModel alloc] init];
        model.retCode = [newData[@"retCode"] integerValue];
        model.retMessage = newData[@"retMsg"];
        return model;
    }
    
}
+ (__kindof instancetype)decryptXiaoModel:(id)requestData {
    NSString *name     = NSStringFromClass(self);
    Class modelClass   = NSClassFromString(name);
    NSString *resStr   = [KKTools decryptJsonString:requestData];
    NSDictionary *dict = [KKTools dictionaryWithJsonString:resStr];
    BaseModel *model   = [modelClass mj_objectWithKeyValues:dict];
    return model;
}

+ (void)saveSessionToken:(NSDictionary *)newData {
    // 保存token
    if (newData) {
        NSString *token = newData[@"token"];
        if (token && token.length != 0) {
            [SaveManager saveString:token forKey:@"token"];
        }
    }
    // 保存session
    if (newData) {
        NSString * session = newData[@"session"];
        if (session && session.length!= 0) {
            [SaveManager  saveString:session forKey:@"session"];
        }
    }
}

@end
