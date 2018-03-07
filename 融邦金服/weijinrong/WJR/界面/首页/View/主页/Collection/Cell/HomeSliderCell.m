//
//  HomeSliderCell.m
//  weijinrong
//
//  Created by RY on 17/6/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "HomeSliderCell.h"
#import "HomeSlider.h"
#import "SGAdvertScrollView.h"

#pragma mark - 声明
@interface HomeSliderCell ()<UIScrollViewDelegate, SGAdvertScrollViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageW;
@property (weak, nonatomic) IBOutlet UIView *pageScroll;
@property (weak, nonatomic) IBOutlet UIView *line;// 线
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIImageView *adIcon;
@property (weak, nonatomic) IBOutlet SGAdvertScrollView *advertScrollView;
@end

#pragma mark - 实现
@implementation HomeSliderCell

- (void)setModels:(NSArray<LoginItemModel *> *)models {
    _models = models;
    
    NSInteger index = 4;
    NSInteger page = models.count % index == 0 ? models.count / index : models.count / index + 1;
    
    
    for (int i=0; i<models.count; i++) {
        HomeSlider *view = [HomeSlider loadFromFrame:({    //6个轮播按钮
            CGFloat width = ScreenWidth / index;
            CGFloat height = 80;
            CGFloat x = i * width;
            CGFloat y = 20;
            CGRectMake(x, y, width, height);
        }) click:^(NSInteger i) {
            if (_click) {
                _click(i);
            }
        }];
        view.tag = i;
        
        LoginItemModel *model = models[i];
        [view.icon sd_setImageWithURL:[NSURL URLWithString:model.imageurl] placeholderImage:[UIImage imageNamed:@"jiazaitu"]];
        [view.name setText:model.businessname];
        [_scroll addSubview:view];
        [_scroll setContentSize:CGSizeMake(page * ScreenWidth, 0)];
    }
    
    for (int i=1; i<page+1; i++) {
        UIView *view = [[UIView alloc] initWithFrame:({
            CGFloat width = 8;
            CGFloat x = (i-1)*(width+8);
            CGRectMake(x, 3, width, width);
        })];
        view.layer.borderWidth = 1;
        view.backgroundColor = i == 1 ? [UIColor redColor] : [UIColor whiteColor];
        view.layer.borderColor = [UIColor redColor].CGColor;
        view.layer.cornerRadius = view.height / 2;
        view.layer.masksToBounds = YES;
        view.tag = i;
        [_pageScroll addSubview:view];
        self.pageW.constant = CGRectGetMaxX(view.frame);
    }
    _pageX.constant = (ScreenWidth - self.pageW.constant) / 2;
}
- (void)setSelectPage:(NSInteger)page {
    for (int i=1; i<_models.count+1; i++) {
        UIView *view = [_pageScroll viewWithTag:i];
        if (page + 1 == i) {
            view.backgroundColor = [UIColor redColor];
        }else {
            view.backgroundColor = [UIColor whiteColor];
        }
    }
}
// 设置尺寸
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setAdView];
//    _advertScrollView.frame = ({
//        CGFloat x = CGRectGetMaxX(_line.frame);
//        CGFloat y = ScreenWidth / 75 * 26 + 20 + 20;
//        CGFloat height = ScreenWidth / 375.f * 154 - (y);
//        CGRectMake(x, y, ScreenWidth - x, height);
//    });
    //_line.centerY
//    _advertScrollView.centerY = _adIcon.centerY;
}

// 广告 滚动条
- (void)setAdView {
    // 例一
    _advertScrollView.titleColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _advertScrollView.scrollTimeInterval = 5;
//    _advertScrollView.backgroundColor = [UIColor redColor];
//    _advertScrollView.leftImageName = @"home_good";
    _advertScrollView.titles = @[@"融邦金服金管家正式上线啦", @"推荐办卡送福利", @"关注融邦金服公众号享受一站式服务"];
//    _advertScrollView.titleInvocation
    _advertScrollView.titleFont = [UIFont systemFontOfSize:14];
    _advertScrollView.delegateAdvertScrollView = self;
    _advertScrollView.isShowSeparator = NO;
//    [self addSubview:_advertScrollView];
}

// 代理方法: 改变按钮
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setSelectPage:scrollView.contentOffset.x / ScreenWidth];
}

// 代理方法
- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"点击了广告");
}

@end

