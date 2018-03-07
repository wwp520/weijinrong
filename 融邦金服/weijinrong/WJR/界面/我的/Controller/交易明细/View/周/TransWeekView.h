//
//  TransWeekView.h
//  chengzizhifu
//
//  Created by RY on 17/1/5.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransWeekModel.h"

@interface TransWeekView : UIView

@property (nonatomic, strong) TransWeekModel *model;

+ (instancetype)initWithFrame:(CGRect)frame;

@end
