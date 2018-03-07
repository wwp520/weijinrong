//
//  IntegralListTable.h
//  weijinrong
//
//  Created by RY on 17/5/17.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegralModel.h"

@interface IntegralListTable : UIView
@property (nonatomic, strong) UITableView *table;

@property(nonatomic,strong)IntegralModel * model;
@property(nonatomic,strong)NSMutableArray <IntegralListModel * >* dataArray;

// code init
+ (instancetype)loadCode:(CGRect)frame;


@end
