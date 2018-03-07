//
//  KKSelectBtn.m
//  weijinrong
//
//  Created by RY on 17/6/13.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "KKSelectBtn.h"


@implementation KKSelectBtn

- (void)selectBtnClick:(UIButton *)btn {
    [UIView animateWithDuration:.3f animations:^{
        for (UIView *obj in self.superview.subviews) {
            if ([obj isKindOfClass:[KKSelectBtn class]]) {
                KKSelectBtn *selectBtn = (KKSelectBtn *)obj;
                if ([selectBtn isEqual:btn]) {
                    if (selectBtn.selected == YES) {
                        selectBtn.selected = NO;
                        selectBtn.icon.transform = CGAffineTransformMakeRotation(0);
                    }else {
                        selectBtn.selected = YES;
                        selectBtn.icon.transform = CGAffineTransformMakeRotation(M_PI);
                    }
                }else {
                    selectBtn.selected = NO;
                    selectBtn.icon.transform = CGAffineTransformMakeRotation(0);
                }
            }
        }
        
        if (_click) {
            _click();
        }
        
    }];
}

+ (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text click:(KKBlock)click {
    KKSelectBtn *btn = [KKSelectBtn buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.click = click;
    btn.backgroundColor = [UIColor whiteColor];
    btn.alpha = 0.6;
    [btn addTarget:btn action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat iconW = 25;
    btn.icon = [[UIImageView alloc]initWithFrame:CGRectMake(btn.name.right, 0, iconW, frame.size.height)];
    btn.icon.contentMode = UIViewContentModeScaleAspectFit;
    btn.icon.backgroundColor = [UIColor whiteColor];
    btn.icon.image = [UIImage imageNamed:@"资源 下拉@0.5x"];
    [btn addSubview:btn.icon];
    
    CGSize size = [self sizeWithTitle:text maxSize:CGSizeMake(MAXFLOAT, 0) font:[UIFont systemFontOfSize:15]];
    btn.name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, frame.size.height)];
    btn.name.text = text;
    btn.name.centerX = frame.size.width / 2;
    btn.name.textAlignment = NSTextAlignmentCenter;
    btn.name.font = [UIFont systemFontOfSize:15];
    btn.name.textColor = [UIColor lightGrayColor];
    [btn addSubview:btn.name];
    
    btn.icon.x = btn.name.right;
    
    [btn bringSubviewToFront:btn.name];
    
    
    return btn;
}

+ (CGSize)sizeWithTitle:(NSString *)title maxSize:(CGSize)maxSize font:(UIFont *)font {
    CGSize size = [title boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    return size;
}



// 是否显示控件
+ (BOOL)isDisplayView:(UIView *)subview {
    for (UIView *obj in subview.subviews) {
        if ([obj isKindOfClass:[KKSelectBtn class]]) {
            KKSelectBtn *selectBtn = (KKSelectBtn *)obj;
            if (selectBtn.selected == YES) {
                return YES;
            }
        }
    }
    return NO;
}


@end
