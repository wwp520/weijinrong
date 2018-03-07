//
//  MineHeader.h
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseView.h"

@interface MineHeader : BaseView
// 登录前
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
// 登录后
@property (weak, nonatomic) IBOutlet UIView *logined;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusW;

+ (instancetype)loadFromFrame:(CGRect)frame icon:(KKBlock)icon login:(KKBlock)login;

@end
