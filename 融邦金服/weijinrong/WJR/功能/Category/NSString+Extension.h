//
//  NSString+Extension.h
//  weijinrong
//
//  Created by RY on 17/4/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSString *)md5;
// 获取手机信息
+ (DeviceModel *)getPhoneInfo ;

@end
