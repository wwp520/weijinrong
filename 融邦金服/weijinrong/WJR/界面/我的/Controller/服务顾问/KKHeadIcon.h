//
//  KKHeadIcon.h
//  chengzizhifu
//
//  Created by RY on 17/1/17.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KKHeadIcon : NSObject

// 保存头像
+ (void)savePhoneIcon:(NSString *)phone image:(UIImage *)image;
// 取出头像
+ (UIImage *)getPhoneIcon:(NSString *)phone;

@end
