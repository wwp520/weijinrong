//
//  NewChangeBankController.h
//  chengzizhifu
//
//  Created by RY on 17/1/7.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "BaseViewController.h"
#import "NewBankListController.h"

@interface NewChangeBankController : BaseViewController

@property (nonatomic, weak) NewBankListController *vc;
@property (nonatomic, copy) NSString *shortName;

@end
