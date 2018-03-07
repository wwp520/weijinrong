//
//  TransTools.h
//  chengzizhifu
//
//  Created by RY on 17/1/7.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransTools : NSObject

+ (NSString *)dateWithStatu:(NSInteger)status
                     comStr:(NSString *)str
                       date:(NSDate *)date;

@end
