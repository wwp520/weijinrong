//
//  UITextField+Extension.m
//  weijinrong
//
//  Created by RY on 17/4/7.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

- (void)setLeftTitle:(NSString *)title {
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:15];
        label;
    });
}
- (void)setLeftImage:(NSString *)image width:(CGFloat)width {
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = ({
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.frame = CGRectMake(0, 0, width, self.height - 20);
        imageV;
    });
}
- (void)setRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}
- (void)setLines:(UIColor *)color {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 1;
}

- (void)setImage:(NSString *)image width:(CGFloat)width radius:(CGFloat)radius color:(UIColor *)color {
    [self setLeftImage:image width:width];
    [self setRadius:radius];
    [self setLines:color];
}

@end
