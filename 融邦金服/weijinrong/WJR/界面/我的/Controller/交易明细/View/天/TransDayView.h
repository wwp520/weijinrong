//
//  TransDayView.h
//  chengzizhifu
//
//  Created by RY on 17/1/5.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransDayModel.h"

@interface TransDayView : UIView

@property (nonatomic, strong) TransDayModel *model;
@property (nonatomic, assign) BOOL cellHidden;

+ (instancetype)initWithFrame:(CGRect)frame;

@end
