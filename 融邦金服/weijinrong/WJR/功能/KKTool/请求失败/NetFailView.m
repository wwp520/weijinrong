//
//  NetFailView.m
//  weijinrong
//
//  Created by RY on 17/5/16.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "NetFailView.h"

#pragma mark 声明
@interface NetFailView ()
@property (nonatomic, copy) KKBlock click;
@end

#pragma mark 实现
@implementation NetFailView

+ (instancetype)loadFromFrame:(CGRect)frame click:(KKBlock)click {
    NetFailView *view = [NetFailView loadFromFrame:frame];
    view.click = click;
    return view;
}
- (IBAction)netClick:(UIButton *)sender {
    if (_click) {
        _click();
    }
}




@end

