//
//  TransDetailCell.h
//  chengzizhifu
//
//  Created by RY on 17/1/6.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransDetailCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dict;

+ (instancetype)initWithTable:(UITableView *)table;

@end
