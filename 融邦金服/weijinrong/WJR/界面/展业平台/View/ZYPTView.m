//
//  ZYPTView.m
//  weijinrong
//
//  Created by ouda on 2018/3/13.
//  Copyright © 2018年 oudapay. All rights reserved.
//

#import "ZYPTView.h"


#pragma mark 声明
@interface ZYPTView ()
@property (weak, nonatomic) IBOutlet UIView *line;
@property (nonatomic, copy) KKIntBlock click;
@end

@implementation ZYPTView


+ (instancetype)initWithFrame:(CGRect)frame click:(KKIntBlock)click {
    ZYPTView *view = [[NSBundle mainBundle] loadNibNamed:@"ZYPTView" owner:nil options:nil].firstObject;
    view.frame = frame;
    view.click = click;
    return view;
}

- (IBAction)changeClick:(UIButton *)sender {
    if (_click) {
        _click(sender.tag);
    }
    [UIView animateWithDuration:.2f animations:^{
        _line.x = sender.x + (ScreenWidth / 3 - _line.width) / 2;
    }];
}

//scroll点击滑动
- (void)changeClick1:(NSInteger)count {
    [UIView animateWithDuration:.2f animations:^{
        _line.x = count * (ScreenWidth / 3 - 10) + (ScreenWidth / 3 - _line.width) / 2;
    }];
}


@end
