//
//  MineHeader.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "MineHeader.h"

#pragma mark 声明
@interface MineHeader()
@property (nonatomic, copy) KKBlock icon;
@property (nonatomic, copy) KKBlock login;
@end

#pragma mark 实现
@implementation MineHeader

+ (instancetype)loadFromFrame:(CGRect)frame icon:(KKBlock)icon login:(KKBlock)login {
    MineHeader *view = [MineHeader loadFromFrame:frame];
    view.frame = frame;
    view.height = ScreenWidth / 2;
    view.icon = icon;
    view.login = login;
    view.name.text = GetAccount;
    return view;
}
- (IBAction)iconClick:(UIButton *)sender {
    if (_icon) {
        _icon();
    }
}
- (IBAction)loginClick:(UIButton *)sender {
    if (_login) {
        _login();
    }
}

//认证状态 
- (IBAction)statusBtn:(id)sender {
    
    
}


@end
