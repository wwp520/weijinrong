//
//  IntegralListTable.m
//  weijinrong
//
//  Created by RY on 17/5/17.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "IntegralListTable.h"
#import "IntegralListCell.h"
#import "LinkViewController.h"

#pragma mark - 声明
@interface IntegralListTable()<UITableViewDelegate,UITableViewDataSource>
@end

#pragma mark - 实现
@implementation IntegralListTable

#pragma mark - 初始化
// code init
+ (instancetype)loadCode:(CGRect)frame {
    IntegralListTable *view = [[IntegralListTable alloc] initWithFrame:frame];
    [view table];
    return view;
}
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        [_table setLineHide];
        [_table setLineAll];
        [self addSubview:_table];
    }
    return _table;
}

-(void)setModel:(IntegralModel *)model{
    _model = model;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_table reloadData];
    });
}


-(void)setDataArray:(NSMutableArray<IntegralListModel *> *)dataArray{
    _dataArray = dataArray;
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _model.list.count;
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IntegralListCell *cell = [IntegralListCell loadWithTable:tableView];
//    [cell.icon  sd_setImageWithURL:[NSURL  URLWithString:_model.list[indexPath.row].logo]];
//    cell.name.text = _model.list[indexPath.row].title;
//    cell.desc.text = _model.list[indexPath.row].body;
    if (self.dataArray.count > indexPath.row) {
        [cell.icon sd_setImageWithURL:[NSURL  URLWithString:self.dataArray[indexPath.row].logo]];
        cell.name.text = self.dataArray[indexPath.row].title;
        cell.desc.text = self.dataArray[indexPath.row].body;
    }
    return cell;
}

#pragma mark--UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LinkViewController * linkVC = [[LinkViewController  alloc]init];
    linkVC.content = self.dataArray[indexPath.row].content;
    [self.viewController.navigationController  pushViewController:linkVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


@end
