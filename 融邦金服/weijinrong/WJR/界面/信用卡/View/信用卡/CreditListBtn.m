//
//  CreditListBtn.m
//  weijinrong
//
//  Created by ouda on 17/5/23.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CreditListBtn.h"

@implementation CreditListBtn

+ (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text {
    CreditListBtn *btn = [CreditListBtn buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor  whiteColor];
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.alpha = 0.6;
    btn.layer.borderWidth = 1;
    
    CGFloat iconW = 25;
    CGFloat nameW = btn.width - iconW;
    btn.icon = [[UIImageView alloc]initWithFrame:CGRectMake(nameW, 0, iconW, 40)];
    btn.icon.contentMode = UIViewContentModeScaleAspectFit;
    btn.icon.backgroundColor = [UIColor whiteColor];
    btn.icon.image = [UIImage imageNamed:@"资源 下拉@0.5x"];
    [btn addSubview:btn.icon];
    
    btn.name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, nameW, 40)];
    btn.name.backgroundColor = [UIColor groupTableViewBackgroundColor];
    btn.name.text = text;
    btn.name.textAlignment = NSTextAlignmentCenter;
    btn.name.font = [UIFont systemFontOfSize:15];
    btn.name.textColor = [UIColor blackColor];
    [btn addSubview:btn.name];
    
    return btn;
}

@end
