//
//  BankUsedView.h
//  weijinrong
//
//  Created by ouda on 17/5/23.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseView.h"
#import "BankInfoSelectedModel.h"

@interface BankUsedView : BaseView
@property(nonatomic,strong)BankInfoSelectedModel * model;
@property(nonatomic,strong)UITableView *tableView;

- (void)hide;
+ (instancetype)loadCode:(CGRect)frame click:(KKIntBlock)click ;
@end
