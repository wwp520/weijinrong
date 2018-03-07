//
//  NSString+Extension.m
//  weijinrong
//
//  Created by RY on 17/4/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation NSString (Extension)

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    CC_MD5(cStr, strlen(cStr), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


// 手机设备信息
+ (DeviceModel *)getPhoneInfo {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    NSString *strName = [[UIDevice currentDevice] name];
    NSLog(@"设备名称：%@", strName);//e.g. "My iPhone"
    NSString *strSysName = [[UIDevice currentDevice] systemName];
    NSLog(@"系统名称：%@", strSysName);// e.g. @"iOS"
    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"系统版本号：%@", strSysVersion);// e.g. @"4.0"
    NSString *strModel = [[UIDevice currentDevice] model];
    NSLog(@"设备模式：%@", strModel);// e.g. @"iPhone", @"iPod touch"
    NSString *strLocModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"本地设备模式：%@", strLocModel);// localized version of model //地方型号  （国际化区域名称）
    // App应用相关信息的获取
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    // CFShow(dicInfo);
    NSString *strAppName = [dicInfo objectForKey:@"CFBundleDisplayName"];
    NSLog(@"App应用名称：%@", strAppName);   // 当前应用名称
    NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"App应用版本：%@", strAppVersion);    // 当前应用软件版本  比如：1.0.1
    NSString *strAppBuild = [dicInfo objectForKey:@"CFBundleVersion"];
    NSLog(@"App应用Build版本：%@", strAppBuild);      // 当前应用版本号码   int类型
    
    DeviceModel *model = [[DeviceModel alloc] init];
    model.phoneModel = [platform getDeviceInfoStr];
    model.sysVersionNumber = strSysVersion;
    model.appName = strAppName;
    model.appVersion = strAppVersion;
    model.appBuild = strAppBuild;
    
    return model;
}
- (NSString *)getDeviceInfoStr {
    if ([self isEqualToString:@"iPhone3,1"]){
        return @"iPhone 4";
    }
    if ([self isEqualToString:@"iPhone3,2"]){
        return @"Verizon iPhone 4";
    }
    if ([self isEqualToString:@"iPhone4,1"]){
        return @"iPhone 4S";
    }
    if ([self isEqualToString:@"iPhone5,2"]){
        return @"iPhone 5";
    }
    if ([self isEqualToString:@"iPhone6,2"]){
        return @"iPhone 5S";
    }
    if ([self isEqualToString:@"iPhone6,1"]){
        return @"iPhone 5S";
    }
    if ([self isEqualToString:@"iPhone7,1"]){
        return @"iPhone 6";
    }
    if ([self isEqualToString:@"iPhone7,2"]){
        return @"iPhone 6";
    }
    return @"iPhone 6 or iPhone 6Plus";
}

@end
