//
//  RBJFHeaderView.m
//  weijinrong
//
//  Created by ouda on 17/6/7.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "RBJFHeaderView.h"

@implementation RBJFHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //轮播图
        _lscrollView=[[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
        _lscrollView.backgroundColor = [UIColor whiteColor];
        _lscrollView.showPageControl = YES;
        _lscrollView.delegate = self;
        _lscrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _lscrollView.delegate = self;
        _lscrollView.currentPageDotColor = [UIColor whiteColor];
        _lscrollView.localizationImageNamesGroup = @[@"泰山.jpg",@"云南.jpg"];
       // [self addSubview:_lscrollView];
        
        
        //白色view
        //_whiteView = [[UIView  alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.lscrollView.frame) , ScreenWidth, 20)];
        _whiteView = [[UIView  alloc]initWithFrame:CGRectMake(0,CGRectGetMinY(self.lscrollView.frame) , ScreenWidth, 20)];
        _whiteView.backgroundColor = [UIColor  whiteColor];
        [self  addSubview:_whiteView];
        
        
        //定位信息
        _locBtn = [[UIButton  alloc]initWithFrame:CGRectMake(ScreenWidth/2-120, 0, 240, 20)];
        [_locBtn  setTitleColor:[UIColor  redColor] forState:UIControlStateNormal];
        _locBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_locBtn  setImage:[UIImage imageNamed:@"加载.png"] forState:UIControlStateNormal];
        [_whiteView addSubview:_locBtn];
        
        //label
        _label = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMinY(self.lscrollView.frame)+20, ScreenWidth, 30)];
        _label.font = [UIFont  systemFontOfSize:16];
        _label.textColor = [UIColor  lightGrayColor];
        _label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_label];
        
        [self location];
    }
    return self;
}

- (HomeLocation *)location {
    if (!_location) {
        _location = [HomeLocation sharedHomeLocation:^(NSString *city, NSString *address) {
            [_locBtn setTitle:address forState:UIControlStateNormal];
        } error:^{
            [_locBtn setTitle:@"获取位置信息失败" forState:UIControlStateNormal];
        }];
    }
    return _location;
}

@end
