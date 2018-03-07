//
//  DoctorController.m
//  chengzizhifu
//
//  Created by RY on 16/11/22.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "DoctorController.h"

#pragma mark 声明
@interface DoctorController ()
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *call;
@end

#pragma mark 实现
@implementation DoctorController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self scroll];
    [self imageView];
}

- (UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0 , ScreenWidth, ScreenHeight -64)];
        _scroll.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scroll];
    }
    return _scroll;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        NSString *str;
        if (_type == 0) {
            str = [[NSBundle mainBundle] pathForResource:@"健康在线" ofType:@"jpg"];
        }else {
            str = [[NSBundle mainBundle] pathForResource:@"水族服务" ofType:@"jpg"];
        }
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.image = [UIImage imageWithContentsOfFile:str];
        [_imageView sizeToFit];
        CGFloat scale = _imageView.width / ScreenWidth;
        _imageView.height = _imageView.height / scale;
        _imageView.width = ScreenWidth;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scroll addSubview:_imageView];
        self.scroll.contentSize = CGSizeMake(0, _imageView.height);
    }
    return _imageView;
}

#pragma mark 没用的
- (void)createNavigation{
    
    self.view.backgroundColor = RGB(233, 233, 233, 1);
    if (_type == 0) {
        self.navTitle=@"聆听心灵";
    }else {
        self.navTitle=@"水族服务";
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)leftBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end

