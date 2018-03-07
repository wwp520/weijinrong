//
//  TransDayCell.m
//  chengzizhifu
//
//  Created by RY on 17/3/7.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "TransDayCell.h"
#import "TransDayModel.h"
#import "ReceiptViewController.h"
#import "TransWeekCell.h"

#pragma mark 声明
@interface TransDayCell ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

#pragma mark 实现
@implementation TransDayCell

#pragma mark 初始化
+ (instancetype)initWithTable:(UITableView *)table identifier:(NSString *)identifier {
    TransDayCell *cell = [table dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TransDayCell" owner:nil options:nil].firstObject;
    }
    cell.table.bounces = NO;
    [TransDayCell tableAllLine:cell.table];
    [TransDayCell tableHideOtherLine:cell.table];
    return cell;
}
- (void)setModelArr:(NSArray *)modelArr {
    _modelArr = modelArr;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_table reloadData];
    });
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TransDaySubModel *model = self.modelArr[indexPath.row];
    
    ReceiptViewController *vc = [[ReceiptViewController alloc] init];
    vc.model = model;
    vc.typeM = _type == 0 ? 0 : 1;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransWeekCell *cell = [TransWeekCell initWithTable:tableView];
    cell.model = self.modelArr[indexPath.row];
    return cell;
}


#pragma mark 123
// 设置tableview横线
+ (void)tableAllLine:(UITableView *)table {
    table.separatorInset = UIEdgeInsetsZero;
}
// 隐藏多余线
+ (void)tableHideOtherLine:(UITableView *)table {
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


@end

