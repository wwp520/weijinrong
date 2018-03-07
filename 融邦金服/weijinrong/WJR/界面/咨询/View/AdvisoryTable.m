//
//  AdvisoryTable1.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "AdvisoryTable.h"
#import "AdvisoryCell.h"
#import "LinkURLController.h"
#import "CardLinkController.h"

#pragma mark 声明
@interface AdvisoryTable ()<UITableViewDelegate,UITableViewDataSource>

@end

#pragma mark 实现
@implementation AdvisoryTable

+ (instancetype)initWithFrame:(CGRect)frame {
    AdvisoryTable *table = [[AdvisoryTable alloc] initWithFrame:frame style:UITableViewStylePlain];
    table.delegate = table;
    table.dataSource = table;
    table.showsVerticalScrollIndicator = NO;
    table.showsHorizontalScrollIndicator = NO;
    [table setLineHide];
    [table setLineAll];
    return table;
}


- (void)setDataArray:(NSMutableArray<CardWelfareListModel *> *)dataArray{
    _dataArray = dataArray;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdvisoryCell *cell = [AdvisoryCell loadWithTable1:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count > indexPath.row) {
        cell.model = self.dataArray[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WebController * cardVC = [[WebController alloc]init];
    cardVC.url = self.dataArray[indexPath.row].content;
    cardVC.navTitle = @"咨询";
    [self.viewController.navigationController pushViewController:cardVC animated:YES];
}

@end






