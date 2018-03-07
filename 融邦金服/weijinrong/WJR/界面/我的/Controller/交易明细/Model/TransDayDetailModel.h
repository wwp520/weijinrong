//
//  TransDayDetailModel.h
//  chengzizhifu
//
//  Created by RY on 17/1/20.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "BaseModel.h"

@interface TransDayDetailModel : BaseModel
@property (nonatomic, strong) NSString *sumMoney;
@property (nonatomic, strong) NSArray *alipay;
@property (nonatomic, assign) NSInteger count;
@end
