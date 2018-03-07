//
//  WithdrawalView.h
//  chengzizhifu
//
//  Created by RY on 17/1/5.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankModel.h"

@interface WithdrawalView : UIView

@property (weak, nonatomic) IBOutlet UILabel *hadMoney;//可提款金额
@property (nonatomic, strong) NSString *hadMoneyStr;//可提款金额
@property (nonatomic, strong) BankModel *model;

+ (instancetype)initWithFrame:(CGRect)frame ;

@end
