//
//  NewBankListController.m
//  chengzizhifu
//
//  Created by RY on 17/1/18.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "NewBankListController.h"
#import "BankModel.h"
#import "BankListCell.h"
#import "NewChangeBankController.h"
#import "SaveManager.h"

#pragma mark 声明
@interface NewBankListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) BankModel *model;
@end

#pragma mark 实现
@implementation NewBankListController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self getInfo];
}

#pragma mark 网络接口
//银行卡列表
- (void)getInfo {
    [self showHudLoadingView:@"正在获取..."];

    [DongManager bankCardList:nil success:^(id requestData) {
        [self hiddenHudLoadingView];
        _model = [BankModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            [_table reloadData];
            NSLog(@"****************%@*****************",requestData);
        }else{
            [self showTitle:_model.retMessage delay:1];
        }
    } fail:^(NSError *error) {    
        [self showNetFail];
    }];
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewChangeBankController *vc = [[NewChangeBankController alloc] init];
    vc.vc = self;
    vc.shortName = _model.name;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model ? 1 : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BankListCell *cell = [BankListCell initWithTable:tableView];
    cell.bank.text = _model.bank;
    cell.name.text = _model.name;
    cell.four.text = _model.tail;
    return cell;
}

- (void)createNavigation {
    [self setNavTitle:@"我的银行卡"];
    _table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


@end










