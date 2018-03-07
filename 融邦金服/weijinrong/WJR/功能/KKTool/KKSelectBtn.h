//
//  KKSelectBtn.h
//  weijinrong
//
//  Created by RY on 17/6/13.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKSelectBtn : UIButton

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, copy  ) KKBlock click;

+ (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text click:(KKBlock)click;

// 是否显示控件
+ (BOOL)isDisplayView:(UIView *)subview;

@end
