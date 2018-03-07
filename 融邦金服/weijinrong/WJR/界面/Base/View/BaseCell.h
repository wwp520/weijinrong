//
//  BaseCell.h
//  BusinessPeople
//
//  Created by RY on 17/1/12.
//  Copyright © 2017年 RY. All rights reserved.
//

#import "BaseView.h"

@interface BaseCell : UITableViewCell

/** 加载 xib 控件 */
+ (instancetype)loadWithTable:(UITableView *)table ;

// 加载最后一个控件
+ (instancetype)loadLastNib:(UITableView *)table;

@end
