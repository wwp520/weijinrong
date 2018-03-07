//
//  PushView.m
//  weijinrong
//
//  Created by RY on 17/6/16.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "PushView.h"

@implementation PushView

+ (instancetype)loadFromFrame:(CGRect)frame click:(KKBlock)click {
    PushView *view = [PushView loadFromFrame:frame];
    view.click = click;
    return view;
}

- (void)setModel:(UserPushModel *)model {
    _model = model;
    _name.text = _model.title;
    _body.text = _model.body;
    _date.text = ({
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [formatter stringFromDate:date];
    });
}

- (IBAction)closeClick:(UIButton *)sender {
    [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.y = ScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (_click) {
            _click();
        }
    }];
}

@end
