//
//  UITextField+Extension.h
//  weijinrong
//
//  Created by RY on 17/4/7.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

- (void)setLeftTitle:(NSString *)title;
- (void)setLeftImage:(NSString *)image width:(CGFloat)width;
- (void)setRadius:(CGFloat)radius;
- (void)setLines:(UIColor *)color;
- (void)setImage:(NSString *)image width:(CGFloat)width radius:(CGFloat)radius color:(UIColor *)color ;

@end
