//
//  BankListCell.m
//  chengzizhifu
//
//  Created by RY on 17/1/18.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "BankListCell.h"

@implementation BankListCell

+ (instancetype)initWithTable:(UITableView *)table {
    BankListCell *cell = [table dequeueReusableCellWithIdentifier:@"BankListCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BankListCell" owner:nil options:nil].firstObject;
    }
    return cell;
}

@end
