//
//  TransDChooseView.m
//  chengzizhifu
//
//  Created by RY on 17/1/5.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "TransDChooseView.h"

#pragma mark 声明
@interface TransDChooseView ()
@property (nonatomic, copy) KKIntBlock click;
@end

#pragma mark 实现
@implementation TransDChooseView

#pragma mark 初始化
+ (instancetype)initWithFrame:(CGRect)frame click:(KKIntBlock)click {
    TransDChooseView *view = [[NSBundle mainBundle] loadNibNamed:@"TransDChooseView" owner:nil options:nil].firstObject;
    view.frame = frame;
    view.click = click;
    [view bussClick:({
        UIButton *btn = [UIButton new];
        btn.tag = 1;
        btn;
    })];
    return view;
}

#pragma mark 按钮点击
- (IBAction)bussClick:(UIButton *)sender {
    for (int i=1; i<=3; i++) {
        UIButton *btn = [self viewWithTag:i];
        btn.selected = sender.tag == i;
        sender.tag == i ? [self selectBtn1:btn] : [self normalBtn1:btn];
        
    }
    if (_click) {
        _click(sender.tag);
    }
}


- (void)selectBtn1:(UIButton *)btn {
    btn.layer.borderWidth = 1;// 边框宽度
    btn.layer.borderColor = RGB(233, 233, 233, 1).CGColor;// 边框颜色
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;// 边框颜色

}
- (void)normalBtn1:(UIButton *)btn {
    btn.layer.borderWidth = 1;// 边框宽度
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;// 边框颜色
}


@end

