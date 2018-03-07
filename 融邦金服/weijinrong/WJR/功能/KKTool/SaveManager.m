//
//  SaveManager.m
//  BusinessPeople
//
//  Created by RY on 17/1/13.
//  Copyright © 2017年 RY. All rights reserved.
//

#import "SaveManager.h"

#pragma mark 声明
@interface SaveManager()
@end

#pragma mark 实现
@implementation SaveManager
static SaveManager *manager;

#pragma mark 初始化
+ (instancetype)shareInstance {
    //线程保护
    @synchronized(self){
        if (!manager) {
            manager = [[SaveManager alloc] init];
        }
    }
    return manager;
}

// 存值
+ (void)saveString:(NSString *)str forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
// 取值
+ (NSString *)getStringForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

@end
