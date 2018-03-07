//
//  WithdrawalModel.h
//  chengzizhifu
//
//  Created by RY on 17/1/21.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "BaseModel.h"

@interface WithdrawalModel : BaseModel

@property (nonatomic, copy) NSString *orderNumber;

@property (nonatomic, strong) NSArray *drawings;

@end
