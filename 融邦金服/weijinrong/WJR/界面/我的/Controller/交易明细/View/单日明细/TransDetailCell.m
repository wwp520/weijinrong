//
//  TransDetailCell.m
//  chengzizhifu
//
//  Created by RY on 17/1/6.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "TransDetailCell.h"

#pragma mark 声明
@interface TransDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *money;
@end

#pragma mark 实现
@implementation TransDetailCell

#pragma mark 初始化
+ (instancetype)initWithTable:(UITableView *)table {
    TransDetailCell *cell = [table dequeueReusableCellWithIdentifier:@"TransDetailCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TransDetailCell" owner:nil options:nil].firstObject;
    }
    return cell;
}


- (void)setDict:(NSDictionary *)dict {
    _dict = dict;
    NSString *money = dict[@"money"];
    _number.text = [NSString stringWithFormat:@"流水号: %@",dict[@"orderNum"]];
    _money.text  = [NSString stringWithFormat:@"金额: %.2f元",[money floatValue]];
    _date.text   = dict[@"dealTime"];
    if ([dict[@"paymentType"] isEqualToString:@"1"]) {
        _icon.image = [UIImage imageNamed:@"newPay_wei"];
    }else {
        _icon.image = [UIImage imageNamed:@"newPay_alipy"];
    }
    
}

@end

