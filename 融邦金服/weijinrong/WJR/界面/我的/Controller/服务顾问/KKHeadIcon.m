//
//  KKHeadIcon.m
//  chengzizhifu
//
//  Created by RY on 17/1/17.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "KKHeadIcon.h"

@implementation KKHeadIcon

// 保存头像
+ (void)savePhoneIcon:(NSString *)phone image:(UIImage *)image {
    NSString *key  = [NSString stringWithFormat:@"%@Icon",phone];
    NSData *value = UIImagePNGRepresentation(image);
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
// 取出头像
+ (UIImage *)getPhoneIcon:(NSString *)phone {
    if (phone == nil) {
        return nil;
    }
    NSString *key  = [NSString stringWithFormat:@"%@Icon",phone];
    NSData *value  = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    if (value != nil) {
        return [UIImage imageWithData:value];
    }else {
        return nil;
    }
}

@end
