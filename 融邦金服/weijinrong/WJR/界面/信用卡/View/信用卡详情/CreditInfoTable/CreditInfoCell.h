//
//  CreditInfoCell.h
//  weijinrong
//
//  Created by RY on 17/4/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseCell.h"
#import "CardManagerDetailModel.h"
#import "wwpViewCell.h"
#import "CardArrangeModel.h"


@interface CreditInfoCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *countAmount;      //总金额
@property (weak, nonatomic) IBOutlet UILabel *Date;             //日期
@property (weak, nonatomic) IBOutlet UILabel *countTime;        //时间

@property (nonatomic, strong) CardArrangeMonthModel *model;    // Cell数据


+ (instancetype)loadWithTable:(UITableView *)table click:(KKBlock)click ;

// 旋转三角
- (void)rotateTriangle;
// Cell初始化的时候是正三角还是倒三角
- (void)setTrianglePositive:(BOOL)isPositive;
// 是否是未出账单
- (void)setAleardyOrder:(BOOL)order;

@end
