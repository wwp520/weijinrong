//
//  WelcomeViewController.h
//  chengzizhifu
//
//  Created by 快易 on 15/1/21.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "BaseViewController.h"

@interface WelcomeViewController : BaseViewController
@property (nonatomic,copy) void (^foregroundBlock)(void);
@end
