//
//  BaseModel.h
//  chengzizhifu
//
//  Created by 快易 on 15/1/5.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MODEL_DEBUG YES

#ifdef MODEL_DEBUG
#define L(STR) \
else\
{\
NSLog(@"解析错误:%@",STR);\
}
#else
#define L(STR)
#endif
@interface WJRModel : NSObject {
    NSDictionary * tmpdata;
}
@property (nonatomic, assign) NSInteger retCode;
@property (nonatomic, copy) NSString * retMessage;
- (void)parseModelData:(NSString *)data;
@end
