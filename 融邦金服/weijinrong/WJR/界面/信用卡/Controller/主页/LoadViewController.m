//
//  LoadViewController.m
//  weijinrong
//
//  Created by ouda on 17/6/16.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "LoadViewController.h"
#import "HomeBtn.h"
#import "ShareCodeController.h"

@interface LoadViewController ()

@end

@implementation LoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"推荐有礼";
    
    HomeBtn *homeBtn = [HomeBtn initWithTitle:@"赚红包" icon:nil];
    UIButton *btn = (UIButton *)homeBtn.customView;
    self.navigationItem.rightBarButtonItem = homeBtn;
    [btn addTarget:self action:@selector(DrawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//推荐码
- (void)DrawBtnClick:(UIButton *)btn{
    
    //    NewMyQrViewController *vc = [[NewMyQrViewController alloc] init];
    ////    vc.model = _model;
    //    [self.navigationController pushViewController:vc animated:YES];
    
    ShareCodeController * shareVC = [[ShareCodeController alloc]init];
    [self.navigationController pushViewController:shareVC animated:YES];
    
}


@end
