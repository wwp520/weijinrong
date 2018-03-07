//
//  KKDateButton.h
//  AAAA
//
//  Created by RY on 17/5/9.
//  Copyright © 2017年 OuDa. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 声明
@interface KKDateButton : UIButton

@property (nonatomic, copy) NSString *monthStr; // 月份
@property (nonatomic, copy) NSString *yearStr;  // 年份

// 初始化
+ (instancetype)initWithFrame:(CGRect)frame;

@end
