//
//  CardSelectController.m
//  weijinrong
//
//  Created by ouda on 17/6/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CardSelectController.h"
#import "RewardCashCell.h"
#import "AddCardController.h"
#import "RewardBankModel.h"

@interface CardSelectController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)RewardBankModel *model;
@property(nonatomic,strong)NSMutableArray *selectCell;//选中Cell
@property(nonatomic,strong)RewardBankListModel *selectModel;// 用于返回上一页
@end

@implementation CardSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"选择银行卡";
    [self tableView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self checkBank];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (_modelBlock) {
        _modelBlock(_selectModel);
    }
}
- (NSMutableArray *)selectCell {
    if (!_selectCell) {
        _selectCell = [[NSMutableArray alloc] init];
        [_selectCell removeAllObjects];
        for (RewardBankListModel *model in _model.list) {
            [_selectCell addObject:@"0"];
        }
        [_selectCell addObject:@"0"];
    }
    return _selectCell;
}

// 查询银行卡
- (void)checkBank {
    [self showHudLoadingView:@"正在获取"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"1",@"pageNum",
                          @"10",@"pageSize",
                          [SaveManager getStringForKey:@"mercId"],@"mercId", nil];
    [DongManager rewardBankCheck:dict success:^(id requestData) {
        [self hiddenHudLoadingView];
        _model = [RewardBankModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            _selectCell = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }else {
            [self showTitle:_model.retMessage delay:1.5f];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}
// 删除银行卡
- (void)deleteBank:(NSIndexPath *)indexPath {
    RewardBankListModel *model = _model.list[indexPath.row];
    [self showHudLoadingView:@"正在删除"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          model.clrMerc,@"bankCardNumber",
                          [SaveManager getStringForKey:@"mercId"],@"mercId", nil];
    [DongManager deleteBankCheck:dict success:^(id requestData) {
        [self hiddenHudLoadingView];
        BaseModel *model = [BaseModel decryptBecomeModel:requestData];
        [self showTitle:model.retMessage delay:1.5f];
        if (model.retCode == 0) {
            [self performSelector:@selector(checkBank) withObject:nil afterDelay:2.f];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}
// 修改银行卡
- (void)replaceBank {
    
}


#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.list.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RewardCashCell *cell = [RewardCashCell loadWithTable:tableView];
    if (indexPath.row != _model.list.count) {
        [cell setModel:_model.list[indexPath.row]];
        [cell setSelectImage:[self.selectCell[indexPath.row] isEqualToString:@"1"]];
    }else {
        [cell.name setText:@"增加新的银行卡"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    for (int i=0; i<self.selectCell.count; i++) {
        NSString *str = indexPath.row == i ? @"1" : @"0";
        [self.selectCell replaceObjectAtIndex:i withObject:str];
        RewardCashCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell setSelectImage:[str isEqualToString:@"1"]];
    }
    
    
    if (indexPath.row == _model.list.count) {
        //加判断,若是最后一行,则跳转到新增银行卡界面
        AddCardController * addVC = [[AddCardController alloc]init];
        [self.navigationController pushViewController:addVC animated:YES];
    }else {
        _selectModel = _model.list[indexPath.row];
    }
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [_tableView setLineHide];
        [_tableView setLineAll];
//        _tableView.tableFooterView = [UIView alloc];
        [self.view  addSubview:_tableView];
    }
    return _tableView;
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _model.list.count) {
        return UITableViewCellEditingStyleNone;
    }else {
        return  UITableViewCellEditingStyleDelete;
    }
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self deleteBank:indexPath];
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

@end
