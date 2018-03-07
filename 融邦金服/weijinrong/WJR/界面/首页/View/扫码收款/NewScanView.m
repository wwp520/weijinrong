//
//  NewScanView.m
//  chengzizhifu
//
//  Created by RY on 17/1/5.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "NewScanView.h"
//#import "NewScanKeyController.h"

#pragma mark 声明
@interface NewScanView ()
@property (weak, nonatomic) IBOutlet UILabel *alipyT;
@property (weak, nonatomic) IBOutlet UILabel *weiT;
@property (nonatomic, strong) UIButton *shadow;
@property (nonatomic, copy) KKIntBlock click;
@end

#pragma mark 实现
@implementation NewScanView

#pragma mark 初始化
+ (instancetype)initWithClick:(KKIntBlock)click {
    NewScanView *view = [[NSBundle mainBundle] loadNibNamed:@"NewScanView" owner:nil options:nil].firstObject;
    view.frame = CGRectMake(0, 0, ScreenWidth - 40, ScreenWidth / 3 * 2);
    view.center =  [UIApplication sharedApplication].keyWindow.center;
    view.click = click;
    [view shadow];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view show];
    
    
    view.weiT.layer.cornerRadius = 5;
    view.weiT.layer.masksToBounds = YES;
    view.alipyT.layer.cornerRadius = 5;
    view.alipyT.layer.masksToBounds = YES;
    
    return view;
}
- (UIButton *)shadow {
    if (!_shadow) {
        _shadow = [UIButton buttonWithType:UIButtonTypeCustom];
        _shadow.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _shadow.backgroundColor = [RGB(50, 50, 50, 1) colorWithAlphaComponent:0.5];
        [_shadow addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:_shadow];
    }
    return _shadow;
}

- (void)show {
    self.alpha = 0;
    self.shadow.alpha = 0;
    [UIView animateWithDuration:.2f animations:^{
        self.alpha = 1;
        self.shadow.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)hide {
    [UIView animateWithDuration:.2f animations:^{
        self.alpha = 0;
        self.shadow.alpha = 0;
    } completion:^(BOOL finished) {
        [_shadow removeFromSuperview];
        _shadow = nil;
        [self removeFromSuperview];
    }];
}

#pragma mark 按钮点击
- (IBAction)payClick:(UIButton *)sender {
    if (_click) {
        _click(sender.tag);
    }
    [self hide];
}


@end
