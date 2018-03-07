//
//  CreditInfoView.m
//  weijinrong
//
//  Created by ouda on 17/5/12.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CreditInfoView.h"
#import "wwpViewCell.h"
#import "CardManagerDetailModel.h"

@interface CreditInfoView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CreditInfoView

- (void)setDelegateToSelf {
    [self setDelegate:self];
    [self setDataSource:self];
    [self setLineHide];
}

-(void)setModel:(CardArrangeMonthModel *)model{
    _model = model;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.dayList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    wwpViewCell *cell = [wwpViewCell loadWithTable:tableView];
    cell.model = _model.dayList[indexPath.row];
    return cell;
}

#pragma mark--UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}


@end
