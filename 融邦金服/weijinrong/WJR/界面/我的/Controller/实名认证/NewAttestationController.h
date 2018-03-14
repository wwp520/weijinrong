//
//  NewAttestationController.h
//  chengzizhifu
//
//  Created by RY on 16/12/28.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAttestationController : BaseViewController

@property(nonatomic,strong) NSString *flag;

@property (nonatomic, assign) NSInteger hiddenBar;//5的话不隐藏
@property (nonatomic, strong) NSString *mobilephone;//手机号
@property (nonatomic, assign) NSInteger isRegister;//是否是注册  5是注册
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *backReason;
@end
