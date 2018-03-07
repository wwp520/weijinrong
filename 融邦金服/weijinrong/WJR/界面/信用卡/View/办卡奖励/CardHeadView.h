//
//  CardHeadView.h
//  weijinrong
//
//  Created by ouda on 17/6/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseView.h"
#import "BankRewardModel.h"

@interface CardHeadView : BaseView
@property (weak, nonatomic) IBOutlet UILabel *BigDecimal;
@property (weak, nonatomic) IBOutlet UILabel *sumAmount;

@property(nonatomic,strong)BankRewardModel *model;

+ (instancetype)initWithFrame:(CGRect)frame click:(KKIntBlock)click ;

@end
