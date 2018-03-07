//
//  HomeFooter.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "HomeFooter.h"
#import "SDCycleScrollView.h"

#pragma mark 声明
@interface HomeFooter ()<SDCycleScrollViewDelegate>
@property (nonatomic, copy  ) KKIntBlock click;
@property (nonatomic, strong) SDCycleScrollView *images;
@end

#pragma mark 实现
@implementation HomeFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    [self images];
}

- (SDCycleScrollView *)images {
    if (!_images) {
        _images = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 375.f*150) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _images.currentPageDotImage = [UIImage imageNamed:@"pageControl"];
        _images.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        [self addSubview:_images];
        [_images setClickItemOperationBlock:^(NSInteger index) {
            if (_click) {
                _click(index);
            }
        }];
    }
    return _images;
}

- (void)setImageArr:(NSArray *)imagesUrl click:(KKIntBlock)click {
    _images.imageURLStringsGroup = imagesUrl;
    _click = click;
}



@end

