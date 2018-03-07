//
//  BaseModel.m
//  chengzizhifu
//
//  Created by 快易 on 15/1/5.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "WJRModel.h"
#import "Unity.h"
@implementation WJRModel

- (void)parseModelData:(NSString *)data {
    tmpdata=[Unity dictionaryWithJsonString:data];
    self.retCode=666;
    self.retMessage=@"数据错误";
    if (tmpdata != nil) {
        self.retCode = [[tmpdata objectForKey:@"retCode"]integerValue];
        self.retMessage = [tmpdata objectForKey:@"retMessage"];
    }
}

@end
