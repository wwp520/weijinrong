//
//  CarLoanController.m
//  chengzizhifu
//
//  Created by RY on 16/5/16.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "CarLoanController.h"
#import "OwnerCarController.h"
#import "Unity.h"

@interface CarLoanController ()

@end

@implementation CarLoanController
#pragma mark - 父类重写
- (void)createNavigation{
    self.navTitle= @"车主贷";

    self.view.y += 64;
}

- (void)leftBtnPressed:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self showUI];
    
}

- (void)showUI {
    [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(20, 5, self.view.width-40, 20) _string:@"请选择您需要的贷款类型" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75] _textAlignment:NSTextAlignmentLeft];
    [Unity buttonAddsuperview_superView:self.view _subViewFrame:CGRectMake((self.view.width-80)/2, 40, 80, 35) _tag:nil _action:nil _string:@"车主贷" _imageName:@"蓝色块"];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.view addSubview:lineView];
    
    //其他信息
    UILabel *firstLabel = [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame)+10, self.view.width, 20) _string:@"额    度：2-15万" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentCenter];
    [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(0, CGRectGetMaxY(firstLabel.frame), self.view.width, 20) _string:@"月综合费率:1.22%-2.22%" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentCenter];
    [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(20, CGRectGetMaxY(lineView.frame)+60, self.view.width-40, 20) _string:@"1.年龄21-55周岁；" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentLeft];
    UILabel *detailTwo = [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(20, CGRectGetMaxY(lineView.frame)+80, self.view.width-40, 20) _string:@"2.名下有全款车;" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentLeft];
    detailTwo.numberOfLines = 0;
    [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(20, CGRectGetMaxY(detailTwo.frame), self.view.width-40, 20) _string:@"3.二手车过户满3个月;" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentLeft];
    UILabel *detailFour = [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(20, CGRectGetMaxY(detailTwo.frame)+20, self.view.width-40, 20) _string:@"4.有交强险和一种商业险;" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentLeft];
    
    UIButton *commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(detailFour.frame)+20, 130, 30)];
    commitBtn.centerX = self.view.centerX;
    [commitBtn setTitle:@"立即申请" forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"橘色块"] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
}

#pragma makr - 事件
- (void)commitAction {
    OwnerCarController *owner = [[OwnerCarController alloc]init];
    [self.navigationController pushViewController:owner animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
