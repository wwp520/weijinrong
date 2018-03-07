//
//  TransDayDetailController.m
//  chengzizhifu
//
//  Created by RY on 17/1/6.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "TransDayDetailController.h"
#import "TransDetailCell.h"
#import "ReceiptViewController.h"
#import "TransDayDetailModel.h"
#import "AFNManager.h"
#import "Unity.h"

#pragma mark 声明
@interface TransDayDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *date1;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) TransDayDetailModel *model;
@end

#pragma mark 实现
@implementation TransDayDetailController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self setNetworking];
    _date1.text = _displayDate;
}
- (void)createUI {
    [self setNavTitle:@"单日明细"];
    [self.table setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}
- (void)leftBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 网络
- (void)setNetworking {
    [self showHudLoadingView:@"正在获取..."];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           _date,@"tradeDate",
                           [SaveManager getStringForKey:@"mercId"],@"mercId", nil];
    [DongManager moneySomeDay:param success:^(id requestData) {
        [self hiddenHudLoadingView];
        // 解析
        _model = [TransDayDetailModel decryptBecomeModel:requestData];
        // 数据
        if (_model.retCode == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_table reloadData];
                _number.text = [NSString stringWithFormat:@"交易数量: %ld笔",(long)_model.count];
                _money.text  = [NSString stringWithFormat:@"金额: %.2f元",[_model.sumMoney floatValue]];
            });
        }else {
            [self showTitle:_model.retMessage delay:1];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ReceiptViewController *vc = [[ReceiptViewController alloc] init];
    vc.dict = _model.alipay[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.alipay.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransDetailCell *cell = [TransDetailCell initWithTable:tableView];
    cell.dict = _model.alipay[indexPath.row];
    return cell;
}


@end










