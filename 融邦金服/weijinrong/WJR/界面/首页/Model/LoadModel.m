//
//  LoadModel.m
//  chengzizhifu
//
//  Created by RY on 16/5/13.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "LoadModel.h"

@implementation LoadModel
- (instancetype)initWithIconStr:(NSString *)iconStr title:(NSString *)title detailTitle:(NSString *)detailTitle titleColor:(UIColor *)color{
    self.iconStr = iconStr;
    self.title = title;
    self.detailTitle = detailTitle;
    self.titleColor = color;
    return self;
}
@end
