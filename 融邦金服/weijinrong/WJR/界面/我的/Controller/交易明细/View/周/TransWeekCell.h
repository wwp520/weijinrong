//
//  TransWeekCell.h
//  chengzizhifu
//
//  Created by RY on 17/1/7.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransDayModel.h"

@interface TransWeekCell : UITableViewCell

@property (nonatomic, strong) TransDaySubModel *model;
@property (nonatomic, strong) NSDictionary *dict;

+ (instancetype)initWithTable:(UITableView *)table;

@end
