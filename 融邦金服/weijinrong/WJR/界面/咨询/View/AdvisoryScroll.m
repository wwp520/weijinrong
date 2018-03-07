//
//  AdvisoryScroll.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//
#import "AdvisoryScroll.h"

#pragma mark 声明
@interface AdvisoryScroll()<UIScrollViewDelegate>
@property (nonatomic, copy) KKIntBlock click;
@end

#pragma mark 实现
@implementation AdvisoryScroll

+ (instancetype)initWithFrame:(CGRect)frame click:(KKIntBlock)click {
    AdvisoryScroll *view = [[AdvisoryScroll alloc] initWithFrame:frame];
    view.frame = frame;
    view.delegate = view;
    view.click = click;
    return view;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    if (_click) {
        _click((scrollView.contentOffset.x + scrollView.width / 2) / scrollView.width);
    }
}
@end
