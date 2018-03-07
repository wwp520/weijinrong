//
//  HomeBtn.m
//  weijinrong
//
//  Created by RY on 17/3/30.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "HomeBtn.h"

@implementation HomeBtn

+ (HomeBtn *)initWithTitle:(NSString *)title icon:(NSString *)icon {
    HomeBtn *btn = [[HomeBtn alloc] initWithCustomView:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, 80, 25)];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        if (icon) {
            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        }
        btn;
    })];
    return btn;
}


+ (HomeBtn *)initLeftTitle:(NSString *)title icon:(NSString *)icon {
    HomeBtn *btn = [[HomeBtn alloc] initWithCustomView:({
        UIImage *image = [UIImage imageNamed:icon];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, 80, 25)];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        if (icon) {
            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        }
        
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width-50)];
        btn.imageView.width = 25;
        btn;
    })];
    return btn;
}

@end
