//
//  AdvisoryBtn.m
//  weijinrong
//
//  Created by RY on 17/6/14.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "AdvisoryBtn.h"

@implementation AdvisoryBtn

+ (instancetype)initWithFrame:(CGRect)frame {
    AdvisoryBtn *view = [[AdvisoryBtn alloc] initWithFrame:frame];
    [view icon];
    [view name];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(view.width, 0, 1, view.height)];
    line1.backgroundColor = RGB(233, 233, 233, 1);
    [view addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, view.height, view.width, 1)];
    line2.backgroundColor = RGB(233, 233, 233, 1);
    [view addSubview:line2];
    
    return view;
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.frame = CGRectMake(1, 0, self.width / 3, self.height);
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_icon];
    }
    return _icon;
}
- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] initWithFrame:({
            CGFloat x = CGRectGetMaxX(_icon.frame) + 3;
            CGRectMake(x, 0, self.width - x - 1, self.height);
        })];
        _name.font = [UIFont systemFontOfSize:11];
        [self addSubview:_name];
    }
    return _name;
}

@end




