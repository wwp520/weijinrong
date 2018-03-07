//
//  AdvisoryPlan.h
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseView.h"
#import "AllBankinfoModel.h"

@interface AdvisoryPlan : BaseView
@property (weak, nonatomic) IBOutlet UIButton *bankname;
@property (nonatomic, strong) AllBankinfoModel *model;

+ (instancetype)loadFromFrame:(CGRect)frame click:(KKIntBlock)click;

@end
