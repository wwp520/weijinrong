//
//  wwpViewCell.h
//  信用卡详情界面搭建
//
//  Created by ouda on 17/5/12.
//  Copyright © 2017年 ouda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardManagerDetailModel.h"
#import "CardArrangeModel.h"


@interface wwpViewCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *tradeDate;     //交易类型
@property (weak, nonatomic) IBOutlet UILabel *merchantName;  //商户名称
@property (weak, nonatomic) IBOutlet UILabel *amount;   //金额

@property (nonatomic, strong) CardArrangeDayModel *model;

@end
