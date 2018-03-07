//
//  CardManagerModel.h
//  weijinrong
//
//  Created by RY on 17/5/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

@interface CardManagerInfoModel : BaseModel

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * bankName;//银行名称
@property(nonatomic,copy)NSString * cardNo;//信用卡后四位
@property(nonatomic,copy)NSString * userName;//持卡人姓名
@property(nonatomic,copy)NSString * billCycle;//账单周期
@property(nonatomic,copy)NSString * RepaymentDate;//还款日
@property(nonatomic,copy)NSString * billAmount;//本期账单
@property(nonatomic,copy)NSString * minAmount;//最低还款金额
@property(nonatomic,copy)NSString * repaymentAmount;//应还金额
@property(nonatomic,copy)NSString * mercId;//商户编号
@property(nonatomic,copy)NSString * url;//银行图片
@property(nonatomic,copy)NSString * RepaymentTime;//还款日期
@end

@interface CardManagerModel : BaseModel
@property(nonatomic,retain)NSArray<CardManagerInfoModel *>* list;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end
