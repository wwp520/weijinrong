//
//  ZYTable.m
//  weijinrong
//
//  Created by ouda on 2018/3/13.
//  Copyright © 2018年 oudapay. All rights reserved.
//

#import "ZYTable.h"
#import "CreditUsedViewController.h"
#import "ZYBankListController.h"
#import "ZYWebController.h"

@interface ZYTable ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSArray *contentArray;
@property (nonatomic,strong) NSArray *iconArray;
@end

@implementation ZYTable

+ (instancetype)initWithFrame:(CGRect)frame{
    ZYTable *table = [[ZYTable alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    table.delegate = table;
    table.dataSource = table;
  //  table.index = 1;
    table.separatorStyle = UITableViewCellSelectionStyleNone;
    table.showsVerticalScrollIndicator = NO;
    table.showsHorizontalScrollIndicator = NO;
    [table setLineHide];
    [table setLineAll];
    return table;
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZYPTCell *cell = [ZYPTCell loadWithTable1:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.bmgBtn.userInteractionEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.icon.image = [UIImage imageNamed:self.iconArray[indexPath.row]];
    cell.titleLb.text = self.titleArray[indexPath.row];
    cell.contentLb.text = self.contentArray[indexPath.row];
//    if (self.dataArray.count > indexPath.row) {
//        cell.model = self.dataArray[indexPath.row];
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CreditUsedViewController * VC = [[CreditUsedViewController alloc]init];
        [self.viewController.navigationController pushViewController:VC animated:YES];
    }else if(indexPath.row == 1){
        ZYBankListController * ZYVC = [[ZYBankListController alloc]init];
        ZYVC.navTitle = @"信用卡列表";
        [self.viewController.navigationController pushViewController:ZYVC animated:YES];
    }else{
        ZYWebController * zyVC = [[ZYWebController alloc]init];
        zyVC.navTitle = @"云服务";
        [self.viewController.navigationController pushViewController:zyVC animated:YES];
    }
}

#pragma mark--懒加载
- (NSArray *)iconArray{
    if (!_iconArray) {
        _iconArray = @[@"zy_danka@2X.png",@"zy_yinhang@2X.png",@"zy_rongbang@2X.png"];
    }
    return _iconArray;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"单卡通道",@"银行通道",@"融邦金服"];
    }
    return _titleArray;
}

- (NSArray *)contentArray{
    if (!_contentArray) {
        _contentArray = @[@"单个信用卡推广",@"单银行所有卡推广",@"平台所有卡推广"];
    }
    return _contentArray;
}


@end
