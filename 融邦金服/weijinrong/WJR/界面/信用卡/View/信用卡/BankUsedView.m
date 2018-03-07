//
//  BankUsedView.m
//  weijinrong
//
//  Created by ouda on 17/5/23.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BankUsedView.h"
#import "BankUsedCell.h"
#import "CreditUsedCell.h"

@interface BankUsedView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)BankUsedView  *views;
@property(nonatomic,copy  )KKIntBlock click;

@end

@implementation BankUsedView

+ (instancetype)loadCode:(CGRect)frame click:(KKIntBlock)click {
    BankUsedView *view = [[BankUsedView alloc] initWithFrame:frame];
    [view setClick:click];
    [view tableView];
    return view;
}

- (void)hide{
    [_views  removeFromSuperview];
}

- (void)setModel:(BankInfoSelectedModel *)model{
    _model = model;
    [_tableView  reloadData];
}

//懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.height) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [_tableView setLineHide];
        [self addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tag == 99) {
        return _model.bank.count + 1;
    }else if (self.tag == 100) {
        return _model.cardType.count + 1;
    }else {
        return _model.cardLevell.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BankUsedCell *cell = [BankUsedCell loadWithTable:tableView];
    if (indexPath.row == 0) {
        if (self.tag == 99) {
            cell.title.text = @"全部银行";
            cell.title.textColor = [UIColor blackColor];
        }else if (self.tag == 100) {
            cell.title.text = @"全部用途";
            cell.title.textColor = [UIColor blackColor];
        }else {
            cell.title.text = @"全部种类";
            cell.title.textColor = [UIColor blackColor];
        }
    }else {
        if (self.tag == 99) {
            cell.title.text = _model.bank[indexPath.row - 1].bankName;
//            cell.content.text = _model.bank[indexPath.row - 1].bankNo;
        }else if (self.tag == 100) {
            cell.title.text = _model.cardType[indexPath.row - 1].key;
//            cell.content.text = _model.cardType[indexPath.row - 1].value;
        }else {
            cell.title.text = _model.cardLevell[indexPath.row - 1].key;
//            cell.content.text = _model.cardLevell[indexPath.row - 1].value;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_click) {
        _click(indexPath.row);
    }
}




@end
