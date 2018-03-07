//
//  BankListViewController.h
//  chengzizhifu
//
//  Created by 快易 on 15/1/26.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "BaseViewController.h"

@interface BankListViewController : BaseViewController
@property (nonatomic,copy) void (^changeBlock)(NSString * bankNames,NSString *bankid);
@end
