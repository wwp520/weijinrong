//
//  BankRewardController.m
//  weijinrong
//
//  Created by ouda on 17/6/7.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BankRewardController.h"
#import "CardHeadView.h"
#import "RewardCell.h"
#import "CardSectionHead.h"
#import "BankRewardModel.h"
#import "CardHeadView.h"
#import "CardInputList.h"
#import "KKSelectBtn.h"
#import "RewardListModel.h"
#import "HomeBtn.h"
#import "RewardCashController.h"
#import "InputFooterView.h"

@interface BankRewardController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) CardHeadView *headView;
@property (nonatomic, strong) BankRewardModel * model;
@property (nonatomic, strong) CardHeadView *header;
@property (nonatomic, strong) CardInputList *inputTable;
@property (nonatomic, strong) RewardListModel * listmodel;
@property (nonatomic, strong) NSMutableDictionary *monthModel;// 详细数据
@property(nonatomic,strong)InputFooterView * footView;
@end

@implementation BankRewardController
//懒加载
- (InputFooterView *)footView{
    if (!_footView) {
        _footView = [[InputFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-125)];
        _footView.backgroundColor = [UIColor whiteColor];
    }
    return _footView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"推荐办卡奖励"];
    [self tableView];
    [self getInfo];
    [self inputTable];
    
    [self.navigationItem setRightBarButtonItem:({
        HomeBtn *home = [HomeBtn initLeftTitle:@"提现" icon:@"资源 103"];
        UIButton *btn = (UIButton *)home.customView;
        [btn addTarget:self action:@selector(rewardClick) forControlEvents:UIControlEventTouchUpInside];
        home;
    })];
}

- (void)rewardClick {
    RewardCashController * rewardVC = [[RewardCashController alloc]init];
    rewardVC.amount = _model.amount;
    [self.navigationController pushViewController:rewardVC animated:YES];
}

- (CardHeadView *)header {
    if (!_header) {
        _header = [CardHeadView initWithFrame:CGRectMake(0, 64, ScreenWidth, 125) click:^(NSInteger i) {
            if ([KKSelectBtn isDisplayView:_header]) {
                [self.inputTable setY:_header.height + _tableView.contentOffset.y + 64];
                [self.inputTable displayAnimation:ScreenHeight - _inputTable.y];
            }else {
                [self.inputTable hiddenAnimation];
            }
        }];
    }
    return _header;
}

- (CardInputList *)inputTable {
    if (!_inputTable) {
        _inputTable = [[CardInputList alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        _inputTable.height = 0;
        _inputTable.backgroundColor = [UIColor redColor];
        [self.view addSubview:_inputTable];
        [_inputTable setY:_header.height + _tableView.contentOffset.y + 64];
    }
    return _inputTable;
}

- (void)setMonthModelData:(BankRewardModel *)models {
    if (!_monthModel) {
        _monthModel = [[NSMutableDictionary alloc] init];
    }
    for (BankRewardListModel *model in models.list) {
        NSMutableArray *arrm = _monthModel[model.date];
        if (!arrm) {
            arrm = [[NSMutableArray alloc] init];
        }
        [_monthModel setObject:arrm forKey:model.date];
    }
}

- (void)getInfo {
    [self showHudLoadingView:@"正在获取"];
    [DongManager BankCardReward:nil success:^(id requestData) {
        [self hiddenHudLoadingView];
        _model = [BankRewardModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            if (_model.list.count != 0) {
                _tableView.tableFooterView = [UIView new];
            }else {
                _tableView.tableFooterView = [self footView];
            }
            _header.BigDecimal.text = [NSString stringWithFormat:@"%@元",_model.amount];
            _header.sumAmount.text = [NSString stringWithFormat:@"累计奖励+%@元", _model.sumAmount];
            [self setMonthModelData:_model];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        } else {
            [self showTitle:_model.retMessage delay:1];
        }
       
    } fail:^(NSError *error) {
        [self showNetFail];
       
    }];
}


//办卡奖励列表
- (void)getSelectInfo:(NSString *)date {
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [SaveManager  getStringForKey:@"mercId"],@"mercId",
                          date,@"tradeDate",
                          @"1",@"pageNum",
                          @"10",@"pageSize", nil];
    [self showHudLoadingView:@"正在获取"];
    [DongManager BankCardRewardSelect:dict success:^(id requestData) {
        [self hiddenHudLoadingView];
        
        _listmodel = [RewardListModel decryptBecomeModel:requestData];
        if (_listmodel.retCode == 0) {
            if (_listmodel.apply.count != 0) {
                _tableView.tableFooterView = [UIView new];
            }else {
                _tableView.tableFooterView = [self footView];
            }
            NSMutableArray *arr = _monthModel[date];
            [arr removeAllObjects];
            [arr addObjectsFromArray:_listmodel.apply];
            [_monthModel setObject:arr forKey:date];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        } else {
            [self showTitle:_listmodel.retMessage delay:1];
        }
        
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
    
}

#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.monthModel.allKeys.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *arr = _monthModel[_monthModel.allKeys[section]];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *arr = _monthModel[_monthModel.allKeys[indexPath.section]];
    RewardListListModel *model = arr[indexPath.row];
    
    RewardCell *cell = [RewardCell loadWithTable:tableView];
    cell.bank.text = model.bankName;
    cell.money.text = model.tradeType;
    cell.date.text = model.tradeDate;
    if ([model.tradeType rangeOfString:@"提现"].location != NSNotFound) {
        cell.number.text = [NSString stringWithFormat:@"-%@元",model.payAmount];
        cell.number.textColor = [UIColor blackColor];
    }else {
        cell.number.text = [NSString stringWithFormat:@"+%@元",model.payAmount];
        cell.number.textColor = [UIColor redColor];
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
    
    CardSectionHead *head = [[NSBundle mainBundle]loadNibNamed:@"CardSectionHead" owner:nil options:nil].lastObject;
    head.headBtn.tag = section;
    [head.headBtn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (_model && _model.list.count - 1 >= section) {
        
        NSString *date = _monthModel.allKeys[section];
        for (BankRewardListModel *model in _model.list) {
            if ([model.date isEqualToString:date]) {
                head.date.text = model.date;
                head.balance.text = [NSString stringWithFormat:@"累积奖励+%@",model.balance];
                head.drawingBalance.text = [NSString stringWithFormat:@"累积提款-%@",model.drawingBalance];
            }
        }
        
        
        
    }
    return head;
}

- (void)headBtnClick:(UIButton *)btn {
    NSInteger row = btn.tag;
    NSString *time = _monthModel.allKeys[row];
    [self getSelectInfo:time];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setLineHide];
        _headView.backgroundColor = [UIColor redColor];
        [_tableView setTableHeaderView:[self header]];
        [_tableView  setTableFooterView:[self footView]];
        [self.view  addSubview:_tableView];
    }
    return _tableView;
}


@end
