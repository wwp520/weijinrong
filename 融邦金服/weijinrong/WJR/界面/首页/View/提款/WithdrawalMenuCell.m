//
//  WithdrawalMenuCell.m
//  chengzizhifu
//
//  Created by RY on 17/1/7.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "WithdrawalMenuCell.h"

#pragma mark 声明
@interface WithdrawalMenuCell ()
@property (weak, nonatomic) IBOutlet UILabel *bankNum;
@property (weak, nonatomic) IBOutlet UILabel *order;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *user;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *bank;
@property (weak, nonatomic) IBOutlet UIView *bj;
@end

#pragma mark 实现
@implementation WithdrawalMenuCell

#pragma mark 初始化
+ (instancetype)initWithTable:(UITableView *)table {
    WithdrawalMenuCell *cell = [table dequeueReusableCellWithIdentifier:@"WithdrawalMenuCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"WithdrawalMenuCell" owner:nil options:nil].firstObject;
    }
    cell.bj.layer.cornerRadius = 10;
    cell.bj.layer.masksToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)setDict:(NSDictionary *)dict {
    _dict = dict;
    _bank.text = [NSString stringWithFormat:@"提现至%@",dict[@"bankName"]];
    _money.text = [NSString stringWithFormat:@"%.2f",[dict[@"money"] floatValue]];
    _name.text = dict[@"name"];
    _order.text = dict[@"orderNum"];
    _bankNum.text = [NSString stringWithFormat:@"尾号: %@",dict[@"tail"]];
    
}


@end

