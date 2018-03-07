//
//  AlipayField.m
//  chengzizhifu
//
//  Created by Mac on 16/10/20.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "AlipayField.h"

@implementation AlipayField

- (instancetype)init {
    return [super init];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if ([UIMenuController sharedMenuController]) {
        
        [UIMenuController sharedMenuController].menuVisible = NO;
        
    }
    
    return NO;
    
}

@end
