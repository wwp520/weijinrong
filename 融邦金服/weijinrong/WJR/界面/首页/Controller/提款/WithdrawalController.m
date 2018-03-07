//
//  WithdrawalViewController.m
//  chengzizhifu
//
//  Created by RY on 17/1/5.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "WithdrawalController.h"
#import "WithdrawalView.h"
#import "WithdrawalMenuController.h"
#import "MySelfModel.h"
#import "BankModel.h"
#import "LoginModel.h"


#pragma mark 声明
@interface WithdrawalController ()
@property (nonatomic, strong) WithdrawalView *withdrawal;
@property (nonatomic, strong) BankModel *model;
@end

#pragma mark 实现
@implementation WithdrawalController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self getInfo];
}
- (void)createUI {
    [self setNavTitle:@"提款"];
    [self withdrawal];
    // 分享
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:({
        UIButton *scanBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [scanBtn setImage:[UIImage imageNamed:@"newReg_menu"] forState:UIControlStateNormal];
        scanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [scanBtn addTarget:self action:@selector(menu) forControlEvents:UIControlEventTouchUpInside];
        scanBtn;
    })];
}
- (WithdrawalView *)withdrawal {
    if (!_withdrawal) {
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight )];
        [scroll setContentSize:CGSizeMake(ScreenWidth, 370)];
        [self.view addSubview:scroll];

        _withdrawal = [WithdrawalView initWithFrame:CGRectMake(0, 0, ScreenWidth, 370)];
        [scroll addSubview:_withdrawal];
    }
    return _withdrawal;
}

#pragma mark 按钮点击
- (void)menu {
    WithdrawalMenuController *vc = [[WithdrawalMenuController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 网络
// 银行卡
- (void)getInfo {
    __weak WithdrawalController *weak = self;
    [self showHudLoadingView:@"正在获取..."];
    
    [DongManager bankCardList:nil success:^(id requestData) {
        [self hiddenHudLoadingView];
        _model = [BankModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            _withdrawal.model = _model;
            [weak setInfo];
        }else{
            [weak showHudLoadingView:_model.retMessage];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}
// 可提款余额
- (void)setInfo {
    [self showHudLoadingView:@"正在加载数据"];
    
    [DongManager moneyInfo:nil success:^(id requestData) {
        [self hiddenHudLoadingView];
        MySelfModel *model = [MySelfModel decryptBecomeModel:requestData];
        // 判断
        if (model.retCode == 0) {
            [_withdrawal.hadMoney setText:[NSString stringWithFormat:@"可提款金额: %.2f元",[model.amount floatValue]]];
            [_withdrawal setHadMoneyStr:model.amount];
            NSLog(@"-----------------%@可提款金额",requestData);
        }else {
            [self showTitle:model.retMessage delay:1];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}




@end

