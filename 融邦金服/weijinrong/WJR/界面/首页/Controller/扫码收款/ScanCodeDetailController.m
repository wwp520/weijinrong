//
//  ScanCodeDetailController.m
//  weijinrong
//
//  Created by ouda on 17/6/13.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "ScanCodeDetailController.h"
#import "CardHeadView.h"
#import "RewardCell.h"
#import "CardSectionHead.h"
#import "BankRewardModel.h"
#import "RewardCashController.h"

@interface ScanCodeDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)CardHeadView *headView;
@property(nonatomic,strong)CardSectionHead * head;
@property(nonatomic,strong)BankRewardModel * model;
@end

@implementation ScanCodeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"支付明细";
    [self tableView];
    [self  getInfo];
}

- (void)getInfo {
    [self  showTitle:@"正在获取" delay:1];
    [DongManager  BankCardReward:nil success:^(id requestData) {
        _model = [BankRewardModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            _headView.model = _model;
            NSLog(@"&&&&&&&&&&办卡奖励接口请求成功&&&&&&&&&&&&");
        }else{
            [self showTitle:_model.retMessage delay:1];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}

#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _model.list.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    RewardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RewardCell" owner:nil options:nil].lastObject;
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _head = [[NSBundle mainBundle]loadNibNamed:@"CardSectionHead" owner:nil options:nil].lastObject;
    if (_model && _model.list.count - 1 >= section) {
        _head.date.text = _model.list[section].date;
        _head.balance.text = [NSString stringWithFormat:@"累积奖励+%@",_model.list[section].balance];
        _head.drawingBalance.text = [NSString stringWithFormat:@"累积提现-%@",_model.list[section].balance];
    }
    return _head;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _headView = [[CardHeadView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 180)];
        [_tableView setLineHide];
        _headView.backgroundColor = [UIColor redColor];
        _headView = [[NSBundle  mainBundle]loadNibNamed:@"CardHeadView" owner:nil options:nil].lastObject;
        [_tableView setTableHeaderView:self.headView];
        [self.view  addSubview:_tableView];
    }
    return _tableView;
}


@end
