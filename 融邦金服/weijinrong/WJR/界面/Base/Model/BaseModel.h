//
//  BaseModel.h
//  BusinessPeople
//
//  Created by RY on 17/1/17.
//  Copyright © 2017年 RY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic, assign) NSInteger retCode;
@property (nonatomic, copy  ) NSString *retMessage;

+ (__kindof instancetype)decryptBecomeModel:(id)requestData;
+ (__kindof instancetype)decryptXiaoModel:(id)requestData;

@end
