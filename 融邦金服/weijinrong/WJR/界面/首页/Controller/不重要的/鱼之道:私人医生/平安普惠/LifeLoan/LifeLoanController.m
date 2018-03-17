//
//  LifeLoanController.m
//  chengzizhifu
//
//  Created by RY on 16/5/16.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "LifeLoanController.h"
#import "OwnerLifeController.h"
#import "Unity.h"

@interface LifeLoanController ()

@end

@implementation LifeLoanController

#pragma mark - 父类重写
- (void)createNavigation{
    self.navTitle= @"寿险贷";
    
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
    [Unity buttonAddsuperview_superView:self.view _subViewFrame:CGRectMake((self.view.width-80)/2, 40, 80, 35) _tag:nil _action:nil _string:@"寿险贷" _imageName:@"蓝色块"];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.view addSubview:lineView];
    
    //其他信息
    UILabel *firstLabel = [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame)+10, self.view.width, 20) _string:@"额    度：最高年缴保费30万，最高可贷50万" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentCenter];
    
    [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(0, CGRectGetMaxY(firstLabel.frame), self.view.width, 20) _string:@"月综合费率：0.92%-2.22%" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentCenter];
    
    [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(20, CGRectGetMaxY(lineView.frame)+60, self.view.width-40, 20) _string:@"1.寿险保单的投保人;" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentLeft];
    UILabel *detailTwo = [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(20, CGRectGetMaxY(lineView.frame)+80, self.view.width-40, 20) _string:@"2.保费在2400以上；" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentLeft];
    UILabel *detailThree = [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(20, CGRectGetMaxY(detailTwo.frame), self.view.width-40, 40) _string:@"3.传统型、分红型保单购买时间满半年。万能型保单购买时间满两年;" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentLeft];
    detailThree.numberOfLines = 0;
    UILabel *detailFour = [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(20, CGRectGetMaxY(detailThree.frame), self.view.width-40, 40) _string:@"备注：申请贷款的客户请按照实际情况如实填写。如需办理请积极配合准备资料及审批;" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentLeft];
    detailFour.numberOfLines = 0;
    
    UIButton *commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(detailFour.frame)+20, 130, 30)];
    commitBtn.centerX = self.view.centerX;
    [commitBtn setTitle:@"立即申请" forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"橘色块"] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
}

#pragma makr - 事件
- (void)commitAction {
    OwnerLifeController *life = [[OwnerLifeController alloc]init];
    [self.navigationController pushViewController:life animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
