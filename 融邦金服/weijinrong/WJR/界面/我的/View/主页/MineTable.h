//
//  MineTable.h
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewSetModel.h"

@interface MineTable : UIView

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) NewSetModel *model;

+ (instancetype)initWithFrame:(CGRect)frame;

@end
