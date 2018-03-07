//
//  ReceiptViewController.h
//  chengzizhifu
//
//  Created by RY on 17/1/6.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "BaseViewController.h"
#import "TransDayModel.h"

@interface ReceiptViewController : BaseViewController
@property (nonatomic, strong) TransDaySubModel *model;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, assign) NSInteger typeM;
@end
