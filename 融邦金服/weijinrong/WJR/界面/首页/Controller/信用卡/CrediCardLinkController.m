//
//  CrediCardLinkController.m
//  weijinrong
//
//  Created by ouda on 17/6/2.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CrediCardLinkController.h"
#import "CreditLinkModel.h"
#import "CardBenifitModel.h"
#import "CreditUsedCell.h"

@interface CrediCardLinkController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)CreditLinkModel *LinkModel;
@property(nonatomic,strong)CardBenifitModel * model;
@end

@implementation CrediCardLinkController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"信用卡"];
    [self tableView];
    [self getInfo];
}

- (void)getInfo{
    [self showHudLoadingView:@"正在加载数据"];
    
    [DongManager ApplyCreditLink:nil success:^(id requestData) {
        [self hiddenHudLoadingView];
        _model = [CardBenifitModel decryptBecomeModel:requestData];
        // 判断
        if (_model.retCode == 0) {
            [_tableView reloadData];
            NSLog(@"-----------------%@--------------",requestData);
        }else {
            [self showTitle:_model.retMessage delay:1];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
    
}

- (void)setModel:(CardBenifitModel *)model {
    _model = model;
}


#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CreditUsedCell * cell = [CreditUsedCell loadWithTable:tableView];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.name.text = _model.list[indexPath.row].title;
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:_model.list[indexPath.row].logo] placeholderImage:[UIImage  imageNamed:@"moren.png"]];
    cell.desc.text = _model.list[indexPath.row].body;
    cell.number.text = [NSString  stringWithFormat:@"%@人",_model.list[indexPath.row].countCard];
    cell.benifitModel = _model.list[indexPath.row];      //跳转到
    return cell;
}


#pragma mark--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [_tableView setLineHide];
        [self.view  addSubview:_tableView];
    }
    return _tableView;
}

@end
