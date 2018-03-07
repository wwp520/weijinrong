//
//  RewardListModel.h
//  weijinrong
//
//  Created by ouda on 17/6/14.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

@interface RewardListListModel : BaseModel
@property(nonatomic,strong)NSString *  tradeType;//类型
@property(nonatomic,strong)NSString *  payAmount;//金额
@property(nonatomic,strong)NSString *  tradeDate;//时间
@property(nonatomic,strong)NSString *  bankName;//银行名称
@end


@interface RewardListModel : BaseModel
@property(nonatomic,retain)NSArray <RewardListListModel *>*apply;
@end
