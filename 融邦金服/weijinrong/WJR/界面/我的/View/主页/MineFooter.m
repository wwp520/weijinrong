//
//  MineFooter.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "MineFooter.h"

#pragma mark 声明
@interface MineFooter()
@property (nonatomic, copy) KKBlock click;
@end

#pragma mark 实现
@implementation MineFooter

+ (instancetype)loadFromFrame:(CGRect)frame click:(KKBlock)click {
    MineFooter *view = [MineFooter loadFromFrame:frame];
    view.frame  = frame;
    view.click  = click;
    view.height = 60;
    return view;
}

//退出登录
- (IBAction)quitClick:(UIButton *)sender {
    if (_click) {
        _click();
    }
}

@end
