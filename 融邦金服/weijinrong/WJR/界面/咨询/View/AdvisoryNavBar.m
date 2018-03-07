//
//  AdvisoryNavBar.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "AdvisoryNavBar.h"
#import "AdvisoryBtn.h"

#pragma mark 声明
@interface AdvisoryNavBar ()
@property (weak, nonatomic) IBOutlet UIView *line;
@property (nonatomic, copy) KKIntBlock click;
@end

#pragma mark 实现
@implementation AdvisoryNavBar

+ (instancetype)initWithFrame:(CGRect)frame click:(KKIntBlock)click {
    AdvisoryNavBar *view = [[NSBundle mainBundle] loadNibNamed:@"AdvisoryNavBar" owner:nil options:nil].firstObject;
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

