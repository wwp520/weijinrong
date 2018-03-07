//
//  WelcomeController.m
//  weijinrong
//
//  Created by ouda on 17/6/22.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "WelcomeController.h"
#import "WelcomeViewController.h"

@interface WelcomeController ()

@end

@implementation WelcomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self toLoginViewController];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}



- (void)toLoginViewController {
    
           UIImageView *imageView = [[UIImageView alloc] initWithFrame:ScreenBounds];
        imageView.image=[UIImage imageNamed:@"Default"];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:imageView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
             [self pushRootVC];
        });
}

- (void)pushRootVC{
    WelcomeViewController * welVC = [[WelcomeViewController alloc]init];
    [self.navigationController pushViewController:welVC animated:NO];
}

@end
