//
//  TransMonthView.h
//  chengzizhifu
//
//  Created by RY on 17/1/5.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransMonthModel.h"

@interface TransMonthView : UIView

@property (nonatomic, strong) TransMonthModel *model;

+ (instancetype)initWithFrame:(CGRect)frame;

@end
