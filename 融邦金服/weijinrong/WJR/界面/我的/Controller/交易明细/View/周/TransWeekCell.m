//
//  TransWeekCell.m
//  chengzizhifu
//
//  Created by RY on 17/1/7.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "TransWeekCell.h"

#pragma mark 声明
@interface TransWeekCell ()
@property (weak, nonatomic) IBOutlet UILabel *money;

@property (weak, nonatomic) IBOutlet UILabel *date;
@end

#pragma mark 实现
@implementation TransWeekCell

#pragma mark 初始化
+ (instancetype)initWithTable:(UITableView *)table {
    TransWeekCell *cell = [table dequeueReusableCellWithIdentifier:@"TransWeekCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle] loadNibNamed:@"TransWeekCell" owner:nil options:nil].firstObject;
    }
    return cell;
}

- (void)setDict:(NSDictionary *)dict {
    _dict = dict;
//    _date.text = dict[@""];
    _date.text = dict[@"dealTime"];
    _money.text = [NSString stringWithFormat:@"交易金额: %.2f元",[dict[@"money"] floatValue]];
}

- (void)setModel:(TransDaySubModel *)model {
    _model = model;
    _date.text = model.dealTime;
    _money.text = [NSString stringWithFormat:@"交易金额: %@元",model.money];
}



@end

