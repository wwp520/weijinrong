//
//  MakeThingController.m
//  weijinrong
//
//  Created by ouda on 17/6/20.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "MakeThingController.h"
#import "HomeBtn.h"

@interface MakeThingController ()

@end

@implementation MakeThingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"万人创业";
    
    
    [self.navigationItem setRightBarButtonItem:({
        HomeBtn *home = [HomeBtn initLeftTitle:@"" icon:@"HomeHelp"];
        UIButton *btn = (UIButton *)home.customView;
        [btn addTarget:self action:@selector(helpClick:) forControlEvents:UIControlEventTouchUpInside];
        home;
    })];

}

// 打电话的弹窗
- (void)helpClick:(UIButton *)btn {
    NSURL *url = [NSURL URLWithString:@"telprompt://4000029699"];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备暂时不支持拨号功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
