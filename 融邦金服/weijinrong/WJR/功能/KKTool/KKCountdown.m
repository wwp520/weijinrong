//
//  KKCountdown.m
//  weijinrong
//
//  Created by RY on 17/4/12.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "KKCountdown.h"

#pragma mark 声明
@interface KKCountdown ()
@property (nonatomic, assign) NSInteger seconds;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy  ) KKStrBlock click;
@end

#pragma mark 实现
@implementation KKCountdown
singleton_implementation(KKCountdown)

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (_click) {
                _seconds -= 1;
                if (_seconds > 0) {
                    _click([@(_seconds) description]);
                }else {
                    _click(@"发送验证码");
                    [timer invalidate];
                    timer = nil;
                }
            }
        }];
    }
    return _timer;
}
- (void)startTimer:(KKStrBlock)click {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _seconds = 120;
    _click = click;
    [self timer];
}


- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

@end

