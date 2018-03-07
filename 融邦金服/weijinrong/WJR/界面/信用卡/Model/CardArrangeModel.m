//
//  CardArrangeModel.m
//  weijinrong
//
//  Created by RY on 17/5/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CardArrangeModel.h"

@implementation CardArrangeDayModel
// model转换
+ (CardArrangeDayModel *)changeToDayModel:(CardManagerBillListModel *)model {
    CardArrangeDayModel *daymodel = [[CardArrangeDayModel alloc] init];
    daymodel.id = model.id;
    daymodel.billId = model.billId;
    daymodel.merchantName = model.merchantName;
    daymodel.tradeDate = model.tradeDate;
    daymodel.amount = model.amount;
    daymodel.tradeType = model.tradeType;
    return daymodel;
}
@end

@implementation CardArrangeMonthModel
// model转换
+ (CardArrangeMonthModel *)changeToMonthModel:(CardManagerDetailListModel *)model {
    CardArrangeMonthModel *monthmodel = [[CardArrangeMonthModel alloc] init];
    monthmodel.billId = model.billId;
    monthmodel.countAmount = model.countAmount;
    monthmodel.countTime = model.countTime;
    monthmodel.Date = model.Date;
    monthmodel.annual = model.annual;
    monthmodel.unfolded = monthmodel.unfolded;
    return monthmodel;
}
@end

@implementation CardArrangeModel
// 整理数据
- (void)arrangeModel:(CardManagerDetailModel *)model {
    
    // 其他数据
    self.creditLimit = model.creditLimit;
    self.integration = model.integration;
    self.cardNo = model.cardNo;
    self.bankNo = model.bankNo;
    self.repaymentAmount = model.repaymentAmount;
    self.minAmount = model.minAmount;
    
    
    // 月数据
    for (CardManagerDetailListModel *monthModel in model.DetailsList) {
        monthModel.unfolded = NO;
        // 月数据
        if (!self.monthList) {
            self.monthList = [[NSMutableDictionary alloc] init];
        }
        // 获取年
        NSMutableArray *array = self.monthList[monthModel.annual];
        if (!array) {
            array = [[NSMutableArray alloc] init];
        }
        [array addObject:[CardArrangeMonthModel changeToMonthModel:monthModel]];
        // 年为键, 数组为值
        [self.monthList setObject:array forKey:monthModel.annual];
    }
    // 日数据
    for (CardManagerBillListModel *daymodel in model.BillDetailList) {
        for (int i=0; i<[self.monthList allKeys].count; i++) {
            NSMutableArray *monthArray = self.monthList[[self.monthList allKeys][i]];
            for (CardArrangeMonthModel *monthModel in monthArray) {
                // ID相同
                if ([monthModel.billId isEqualToString:daymodel.billId]) {
                    if (!monthModel.dayList) {
                        monthModel.dayList = [[NSMutableArray alloc] init];
                    }
                    // 添加对应的monthModel中
                    [monthModel.dayList addObject:[CardArrangeDayModel changeToDayModel:daymodel]];
                }
            }
        }
    }
    // 添加未出账单model
    NSMutableArray *firstYear = self.monthList[[self.monthList allKeys][0]];
    [firstYear insertObject:({
        CardArrangeMonthModel *month = [[CardArrangeMonthModel alloc] init];
        month.unfolded = YES;
        month.Date = @"";
        month.countTime = @"未出账单";
        month.countAmount = @"----";
        month;
    }) atIndex:0];
    
    
    
}
@end
