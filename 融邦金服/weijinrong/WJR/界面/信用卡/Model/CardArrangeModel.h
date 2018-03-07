//
//  CardArrangeModel.h
//  weijinrong
//
//  Created by RY on 17/5/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"
#import "CardManagerDetailModel.h"

// 日数据
@interface CardArrangeDayModel : BaseModel
@property(nonatomic,strong)NSString * id;           //主键
@property(nonatomic,copy  )NSString * billId;       //总金额
@property(nonatomic,copy  )NSString * merchantName; //商户名称
@property(nonatomic,copy  )NSString * tradeDate;    //交易日期
@property(nonatomic,copy  )NSString * amount;       //金额
@property(nonatomic,copy  )NSString * tradeType;    //交易类型
@end

// 月数据
@interface CardArrangeMonthModel : BaseModel
@property (nonatomic,copy  )NSString * billId;       //主键
@property (nonatomic,copy  )NSString * countAmount;  //总金额
@property (nonatomic,copy  )NSString * countTime;    //时间
@property (nonatomic,copy  )NSString * Date;         //日期
@property (nonatomic,copy  )NSString * annual;       //年
@property (nonatomic,assign,getter=isUnfolded)BOOL unfolded;    //是否展开
@property (nonatomic,strong)NSMutableArray<CardArrangeDayModel *> *dayList; //日数据
@end

// 最终整理的Model
@interface CardArrangeModel : BaseModel
@property (nonatomic, strong) NSMutableDictionary *monthList;   //月数据
@property (nonatomic, strong) NSString *creditLimit;            //额度
@property (nonatomic, strong) NSString *integration;            //积分
@property (nonatomic, strong) NSString *cardNo;
@property (nonatomic, strong) NSString *bankNo;
@property (nonatomic, strong) NSString *repaymentAmount;        //应还金额
@property (nonatomic, strong) NSString *minAmount;              //最低应还金额
// 整理数据
- (void)arrangeModel:(CardManagerDetailModel *)model;
@end
