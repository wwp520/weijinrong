//
//  WithdrawalMenuController.m
//  chengzizhifu
//
//  Created by RY on 17/1/7.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "WithdrawalMenuController.h"
#import "WithdrawalMenuCell.h"
#import "WithdrawalModel.h"

#pragma mark 声明
@interface WithdrawalMenuController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) WithdrawalModel *model;
@end

#pragma mark 实现
@implementation WithdrawalMenuController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"提款明细"];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [_table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setNetworking];
}

#pragma mark 网络
- (void)setNetworking {
    [self showHudLoadingView:@"正在获取..."];
    
        
    [DongManager moneyDetail:nil success:^(id requestData) {
        [self hiddenHudLoadingView];
        _model = [WithdrawalModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_table reloadData];
            });
        }else {
            [self showTitle:_model.retMessage delay:1];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.drawings.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WithdrawalMenuCell *cell = [WithdrawalMenuCell initWithTable:tableView];
    cell.dict = _model.drawings[indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}


@end

