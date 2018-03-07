//
//  AdvisoryPlan.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "AdvisoryPlan.h"
#import "AdvisoryBtn.h"

#pragma mark 声明
@interface AdvisoryPlan ()

@property (nonatomic, copy) KKIntBlock click;

@end

#pragma mark 实现
@implementation AdvisoryPlan

#pragma mark 初始化

+ (instancetype)loadFromFrame:(CGRect)frame click:(KKIntBlock)click {
    AdvisoryPlan *view = [AdvisoryPlan loadFromFrame:frame];
    view.click = click;
    return view;
}

- (void)setModel:(AllBankinfoModel *)model {
    _model = model;
    for (int i=0; i<model.bank.count; i++) {
        AdvisoryBtn *btn = [AdvisoryBtn initWithFrame:({
            NSInteger row = i % 4;;
            NSInteger col = i / 4;
            CGFloat width = ScreenWidth / 4;
            CGFloat height = width / 2;
            CGRectMake(row * width, col * height + 40, width, height);
        })];
        [btn.icon sd_setImageWithURL:[NSURL URLWithString:model.bank[i].logoUrl] placeholderImage:[UIImage imageNamed:@"moren"]];
        [btn.name setText:model.bank[i].bankName];
        [self addSubview:btn];
//        btn.alpha = 0;
    }
}

- (IBAction)btnClick:(UIButton *)sender {
    if (_click) {
        _click(sender.tag);
    }
}


@end

