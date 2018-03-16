//
//  ZYBankListController.m
//  weijinrong
//
//  Created by ouda on 2018/3/14.
//  Copyright © 2018年 oudapay. All rights reserved.
//

#import "ZYBankListController.h"
#import "BankLinkInfoModel.h"
#import "CreditCell1.h"
#import "ZYBankCell.h"
#import "CodeLinkController.h"
#import "CreditUsedViewController.h"

@interface ZYBankListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) BankLinkInfoModel *modell;
@end

@implementation ZYBankListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
    [self getBankInfo];
}

//银行信息(银行链接)
- (void)getBankInfo {
    
    [DongManager BankLinkInfo:nil success:^(id requestData) {
        // 解析数据
        _modell = [BankLinkInfoModel decryptBecomeModel:requestData];
        if (_modell.retCode == 0) {
            [self.dataArray addObjectsFromArray:_modell.bank];
        }else {
            [self showTitle:_modell.retMessage delay:1.5f];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}

#pragma mark--代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    ZYBankCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ZYBankCell" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSURL * url = [NSURL URLWithString:_modell.bank[indexPath.row].logoUrl];
    [cell.icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"moren.png"] completed:nil];
    cell.nameLb.text = _modell.bank[indexPath.row].bankName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // CodeLinkController * VC = [[CodeLinkController alloc]init];
    CreditUsedViewController * VC = [[CreditUsedViewController alloc]init];
    VC.bankNo = _modell.bank[indexPath.row].bankName;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark--tableView

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [self.view  addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


@end
