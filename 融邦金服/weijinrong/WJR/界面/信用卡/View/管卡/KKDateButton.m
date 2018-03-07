//
//  KKDateButton.m
//  AAAA
//
//  Created by RY on 17/5/9.
//  Copyright © 2017年 OuDa. All rights reserved.
//

#import "KKDateButton.h"

#pragma mark - 声明
@interface KKDateButton()
@property (nonatomic, strong) UILabel *month;
@property (nonatomic, strong) UILabel *year;
@end

#pragma mark - 实现
@implementation KKDateButton

// 初始化
+ (instancetype)initWithFrame:(CGRect)frame {
    KKDateButton *view = [KKDateButton buttonWithType:UIButtonTypeCustom];
    [view setFrame:frame];
    [view month];
    [view year];
    [view.layer setCornerRadius:5];
    [view.layer setMasksToBounds:YES];
    return view;
}

- (UILabel *)month {
    if (!_month) {
        _month = [[UILabel alloc] initWithFrame:({
            CGFloat padding = 5;
            CGFloat width = self.frame.size.width;
            CGFloat height = (self.frame.size.height - padding * 2) / 2;
            CGRectMake(0, padding, width, height);
        })];
        _month.textAlignment = NSTextAlignmentCenter;
        _month.font = [UIFont fontWithName:[UIFont fontNamesForFamilyName:@"Courier"][0] size:15];
        _month.textColor = [UIColor lightGrayColor];
        [self addSubview:_month];
    }
    return _month;
}
//Courier
- (UILabel *)year {
    if (!_year) {
        _year = [[UILabel alloc] initWithFrame:({
            CGFloat width = self.frame.size.width;
            CGFloat height = self.month.frame.size.height;
            CGRectMake(0, CGRectGetMaxY(self.month.frame), width, height);
        })];
        _year.font = [UIFont fontWithName:[UIFont fontNamesForFamilyName:@"Courier"][0] size:15];
        _year.textAlignment = NSTextAlignmentCenter;
        _year.textColor = [UIColor  lightGrayColor];
        [self addSubview:_year];
    }
    return _year;
}

- (void)setMonthStr:(NSString *)monthStr {
    _monthStr = monthStr;
    _month.text = monthStr;
}
- (void)setYearStr:(NSString *)yearStr {
    _yearStr = yearStr;
    _year.text = yearStr;
}

@end
