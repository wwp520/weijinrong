//
//  CreditInfoView.h
//  weijinrong
//
//  Created by ouda on 17/5/12.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardManagerDetailModel.h"
#import "CardArrangeModel.h"


@interface CreditInfoView : UITableView

@property(nonatomic,strong)CardArrangeMonthModel *model;

- (void)setDelegateToSelf;

@end
