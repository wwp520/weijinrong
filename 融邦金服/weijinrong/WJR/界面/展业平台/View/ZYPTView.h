//
//  ZYPTView.h
//  weijinrong
//
//  Created by ouda on 2018/3/13.
//  Copyright © 2018年 oudapay. All rights reserved.
//

#import "BaseView.h"

@interface ZYPTView : UIView

+ (instancetype)initWithFrame:(CGRect)frame click:(KKIntBlock)click;
- (void)changeClick1:(NSInteger)count;

@end
