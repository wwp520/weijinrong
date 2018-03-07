//
//  AdvisoryNavBar.h
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvisoryNavBar : UIView

+ (instancetype)initWithFrame:(CGRect)frame click:(KKIntBlock)click;
- (void)changeClick1:(NSInteger)count;

@end
