//
//  wwpViewCell.m
//  信用卡详情界面搭建
//
//  Created by ouda on 17/5/12.
//  Copyright © 2017年 ouda. All rights reserved.
//

#import "wwpViewCell.h"

@implementation wwpViewCell

- (void)setModel:(CardArrangeDayModel *)model {
    _model = model;
    self.tradeDate.text = model.tradeDate;
    self.amount.text = model.amount;
    self.merchantName.text = model.merchantName;
}

@end
