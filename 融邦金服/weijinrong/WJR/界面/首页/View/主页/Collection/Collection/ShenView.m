//
//  ShenView.m
//  weijinrong
//
//  Created by ouda on 17/6/26.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "ShenView.h"
#import "HomeDataSource.h"
#import "HomeCell.h"
#import "HomeHeader.h"
#import "HomeFooter.h"
#import "ScanCodePayController.h"
#import "SDCycleScrollView.h"

@interface ShenView ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,HomeDataSourceDelegate>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) HomeDataSource *collectionSource;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *images;
@end


@implementation ShenView

+ (instancetype)initWithFrame:(CGRect)frame {
    ShenView *view = [[NSBundle mainBundle] loadNibNamed:@"ShenView" owner:nil options:nil].firstObject;
    view.frame = frame;
    [view imagesCreate];
    return view;
}

- (void)imagesCreate {
    _images.currentPageDotImage = [UIImage imageNamed:@"pageControl"];
    _images.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    [self addSubview:_images];
    _images.localizationImageNamesGroup = @[
                                     [UIImage imageNamed:@"shen1"],
                                     [UIImage imageNamed:@"shen2"]];
    
    [_images setClickItemOperationBlock:^(NSInteger index) {
        if (index == 0) {
            CGFloat lat = [KKStaticParams sharedKKStaticParams].lat;
            CGFloat lot = [KKStaticParams sharedKKStaticParams].lot;
            NSString *token = [SaveManager   getStringForKey:@"mercId"];
            WebController *vc = [[WebController alloc] init];
            vc.url = [NSString stringWithFormat:@"http://wx.17u.cn/traincooperators?RefId=98106537&token=%@&lat=%f&lot=%f",token,lat,lot];;
            vc.navTitle = @"火车票";
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }else {
            WebController *vc = [[WebController alloc] init];
            vc.url = @"https://m.ly.com/flightnew/?refid=98106537";
            vc.navTitle = @"飞机票";
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
    }];
}

- (IBAction)ScanCodeBtn:(id)sender {
    // 是否登录
    if ([KKStaticParams sharedKKStaticParams].currentLogin == NO) {
        [self.viewController pushLoginVc:^{
            ScanCodePayController *scanVC = [[ScanCodePayController alloc] init];
            [self.viewController.navigationController pushViewController:scanVC animated:YES];
        } close:^{
            
        }];
    }else {
        // 扫码收款
        ScanCodePayController *scanVC = [[ScanCodePayController alloc] init];
        [self.viewController.navigationController pushViewController:scanVC animated:YES];
    }
}

- (IBAction)busticket:(id)sender {
    // 飞机票
    WebController *vc = [[WebController alloc] init];
    vc.url = @"https://m.ly.com/flightnew/?refid=98106537";
    vc.navTitle = @"飞机票";
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (IBAction)trainTikect:(id)sender {
    NSString *token = [SaveManager   getStringForKey:@"mercId"];
    WebController *vc = [[WebController alloc] init];
    vc.url = [NSString stringWithFormat:@"http://wx.17u.cn/traincooperators?RefId=98106537&token=%@",token];;
    vc.navTitle = @"火车票";
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (IBAction)tuanClick:(UIButton *)sender {
    
    // 美团
    WebController *vc = [[WebController alloc] init];
    vc.url = @"http://r.union.meituan.com/link/bora6u";
    vc.navTitle = @"美团";
    [self.viewController.navigationController pushViewController:vc animated:YES];
}


@end
