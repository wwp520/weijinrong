//
//  LoadModel.h
//  chengzizhifu
//
//  Created by RY on 16/5/13.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadModel : NSObject
@property (nonatomic, copy) NSString *iconStr;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detailTitle;
@property (nonatomic, strong) UIColor *titleColor;
- (instancetype)initWithIconStr:(NSString *)iconStr title:(NSString *)title detailTitle:(NSString *)detailTitle titleColor:(UIColor *)color;
@end
