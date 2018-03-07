//
//  NewPhotoController.m
//  chengzizhifu
//
//  Created by RY on 16/12/28.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "NewPhotoController.h"
#import "PhotoView.h"

#pragma mark 声明
@interface NewPhotoController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) PhotoView *photo;
@end

#pragma mark 实现
@implementation NewPhotoController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
- (void)createUI {
    [self scroll];
    [self photo];
    [self setNavTitle:@"上传图片"];
}
- (UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
        _scroll.delegate = self;
        [self.view addSubview:_scroll];
    }
    return _scroll;
}
- (PhotoView *)photo {
    if (!_photo) {
        _photo = [PhotoView initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _photo.nameStr     = self.nameStr;
        _photo.IDStr       = self.IDStr;
        _photo.emailStr    = self.emailStr;
        _photo.cardStr     = self.cardStr;
        _photo.bankCode    = self.bankCode;
        _photo.bankName    = self.bankName;
        _photo.province_id = self.province_id;
        _photo.city_id     = self.city_id;
        _photo.longitude   = self.longitude;
        _photo.latitude    = self.latitude;
        _photo.address     = self.address;
        _photo.shopStr     = self.shopStr;
        _photo.mobilephone = self.mobilephone;
        _photo.password    = self.password;
        [self.scroll addSubview:_photo];
        [self.scroll setContentSize:CGSizeMake(0, 510)];
    }
    return _photo;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


@end
