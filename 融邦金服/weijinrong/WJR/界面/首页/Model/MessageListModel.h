//
//  MessageListModel.h
//  chengzizhifu
//
//  Created by RY on 16/10/27.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface MessageListModel :BaseModel
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *platform;
@end
