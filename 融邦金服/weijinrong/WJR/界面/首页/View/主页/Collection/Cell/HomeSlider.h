//
//  HomeSlider.h
//  weijinrong
//
//  Created by RY on 17/6/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseView.h"

@interface HomeSlider : BaseView

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic, copy) KKIntBlock click;

+ (instancetype)loadFromFrame:(CGRect)frame click:(KKIntBlock)click;

@end
