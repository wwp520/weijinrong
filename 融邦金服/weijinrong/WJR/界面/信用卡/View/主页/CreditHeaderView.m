//
//  CreditHeaderView.m
//  weijinrong
//
//  Created by ouda on 17/6/7.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CreditHeaderView.h"
#import "BankRewardController.h"
@interface CreditHeaderView ()
@property(nonatomic,strong)CreditHeaderView *headerView;
@end


@implementation CreditHeaderView
//跳转至办卡奖励界面
- (IBAction)pushBtn:(id)sender {
    BankRewardController *bankVC = [[BankRewardController alloc] init];
    
    [self.viewController.navigationController  pushViewController:bankVC animated:YES];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}


@end
