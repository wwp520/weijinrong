//
//  HomeSlider.m
//  weijinrong
//
//  Created by RY on 17/6/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "HomeSlider.h"

@implementation HomeSlider


+ (instancetype)loadFromFrame:(CGRect)frame click:(KKIntBlock)click {
    HomeSlider *view = [HomeSlider loadFromFrame:frame];
    view.click = click;
    return view;
}


- (IBAction)sliderClick:(UIButton *)sender {
    if (_click) {
        _click(self.tag);
    }
    
}

@end
