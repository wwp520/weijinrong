//
//  RewardCell.m
//  weijinrong
//
//  Created by ouda on 17/6/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "RewardCell.h"

@implementation RewardCell

- (void)setModel:(BankRewardListModel *)model {
    _model = model;
    _money.text = model.balance;
    _number.text = model.balance;
    _date.text = model.date;
}

@end
