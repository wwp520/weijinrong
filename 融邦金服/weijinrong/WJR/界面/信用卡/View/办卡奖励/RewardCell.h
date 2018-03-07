//
//  RewardCell.h
//  weijinrong
//
//  Created by ouda on 17/6/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseCell.h"
#import "BankRewardModel.h"

@interface RewardCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *money;// 奖励
@property (weak, nonatomic) IBOutlet UILabel *bank;// 银行
@property (weak, nonatomic) IBOutlet UILabel *number;// 金额
@property (weak, nonatomic) IBOutlet UILabel *date;// 日期

@property (nonatomic, strong) BankRewardListModel *model;

@end
