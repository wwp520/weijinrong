//
//  BankRewardModel.h
//  weijinrong
//
//  Created by ouda on 17/6/12.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

@interface BankRewardListModel : BaseModel
@property(nonatomic,strong)NSString * date;//日期
@property(nonatomic,strong)NSString * balance;//每月对应的累计奖励金额
@property(nonatomic,strong)NSString * drawingBalance; //提款金额
@end


@interface BankRewardModel : BaseModel
@property(nonatomic,retain)NSArray <BankRewardListModel *>*list;
@property(nonatomic,strong)NSString * amount;//奖励总余额
@property(nonatomic,strong)NSString * sumAmount;//累计奖励总金额
@end
