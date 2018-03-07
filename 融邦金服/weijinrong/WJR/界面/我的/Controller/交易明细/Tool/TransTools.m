//
//  TransTools.m
//  chengzizhifu
//
//  Created by RY on 17/1/7.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "TransTools.h"

#pragma mark 声明
@interface TransTools ()

@end

#pragma mark 实现
@implementation TransTools

#pragma mark 初始化
+ (NSString *)dateWithStatu:(NSInteger)status comStr:(NSString *)str date:(NSDate *)date {
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    NSMutableString *format = [[NSMutableString alloc] init];
    if (status >= 0) {
        [format appendString:@"yyyy"];
        if ([str isEqualToString:@":"] || [str isEqualToString:@"-"]) {
            [format appendString:str];
        }else {
            [format appendString:@"年"];
        }
    }
    if (status >= 1) {
        [format appendString:@"MM"];
        if ([str isEqualToString:@":"] || [str isEqualToString:@"-"]) {
            [format appendString:str];
        }else {
            [format appendString:@"月"];
        }
    }
    if (status >= 2) {
        [format appendString:@"dd"];
        if ([str isEqualToString:@":"] || [str isEqualToString:@"-"]) {
            [format appendString:str];
        }else {
            [format appendString:@"日"];
        }
    }
    [form setDateFormat:format];
    return [form stringFromDate:date];
}


@end
