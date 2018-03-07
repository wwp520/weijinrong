//
//  WelcomeViewController.m
//  chengzizhifu
//
//  Created by 快易 on 15/1/21.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//
#define USERPWD [SGSaveFile getObjectFromSystemWithKey:@"userpwd"]
#define SELECTEDINDEX [SGSaveFile getObjectFromSystemWithKey:@"selectedIndex"]
#define ISFIRSTJOIN [SGSaveFile getObjectFromSystemWithKey:@"isFirstjoin"]

#import "WelcomeViewController.h"
#import "LoginController.h"
#import "LoginModel.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "AppDelegate.h"
#import "ShenHe.h"

@interface WelcomeViewController ()
@property (nonatomic,retain) UIScrollView * scrollView;

@property (nonatomic,copy) NSString * phoneModel;
@property (nonatomic,copy) NSString * sysVersionNumber;
@property (nonatomic,copy) NSString * appName;
@property (nonatomic,copy) NSString * appVersion;
@property (nonatomic,copy) NSString * appBuild;
@property (nonatomic,strong) UIAlertView *alert;

@end

#pragma mark 实现
@implementation WelcomeViewController{
    NSString * app_Version;
    NSString * updateInfo;
    NSString * updateUrl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self toLoginViewController];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
- (void)toLoginViewController {
    
    if(!isFirstLogin && ![ShenHe isShenHeDate]){
        FirstLogin;
        [self.view addSubview:[self backScrollView]];
    }
    else{
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.image=[UIImage imageNamed:@"闪屏"];
        [self.view addSubview:imageView];
        [self poseView];
    }
}

- (UIScrollView *)backScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    NSArray * array;
    
    if ([UIScreen mainScreen].bounds.size.height>480) {
        array=@[@"引导1.jpg",@"引导2.jpg",@"引导3.jpg"];
    }else {
        array=@[@"引导1.jpg",@"引导2.jpg",@"引导3.jpg"];
    }
    
    
    
    for (int i = 0; i<array.count; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0+self.scrollView.width*i, 0, self.scrollView.width, self.scrollView.height)];
        imageview.image = [UIImage imageNamed:[array objectAtIndex:i]];
        if (i == array.count-1) {
            imageview.userInteractionEnabled = YES;
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(poseView:)];
            [imageview addGestureRecognizer:recognizer];
            
        }
        [self.scrollView addSubview:imageview];
    }
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * array.count, ScreenHeight);
    return self.scrollView;
}
- (void)poseView {
   [KKTools becomeTabController];
//    LoginController *lvc = [[LoginController alloc]init];
//    [self.navigationController pushViewController:lvc animated:NO];
}
- (void)poseView:(UITapGestureRecognizer*)recognizer {
    [KKTools becomeTabController];
//    LoginController *lvc = [[LoginController alloc]init];
//    [self.navigationController pushViewController:lvc animated:NO];
}

- (void)poseView_swip:(UISwipeGestureRecognizer *)swip {
    if (swip.direction == UISwipeGestureRecognizerDirectionLeft) {
        LoginController * lvc = [[LoginController alloc]init];
        [self.navigationController pushViewController:lvc animated:NO];
    }
}



@end
