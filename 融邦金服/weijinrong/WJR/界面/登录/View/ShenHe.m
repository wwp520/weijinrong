//
//  ShenHe.m
//  weijinrong
//
//  Created by ouda on 17/6/21.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "ShenHe.h"

@implementation ShenHe
singleton_implementation(ShenHe)

+ (void)load {
    ShenHe *shen = [ShenHe sharedShenHe];
    shen.sh = YES;
}
- (BOOL)isSh {
    NSString *shenhe = [SaveManager getStringForKey:@"shenhe"];
    return [shenhe isEqualToString:@"1"];
    
    /**
    NSString *phone = GetAccount;
    if (!phone || [phone isEqualToString:@"15753099908"]) {
        return YES;
    }
    return NO;
    */
}
- (void)setModel:(LoginModel *)model {
    _sh = NO;
    // 是否在审核
    for (LoginItemModel *subModel in model.list) {
        if ([subModel.businesscode isEqualToString:@"A014"]) {
            if ([subModel.extends3 isEqualToString:SHENHE_NUMBER]) {
                _sh = YES;
            }else {
                _sh = NO;
            }
        }
    }
    _model = model;
    if (_sh == NO) {
        return;
    }
    // 删除 法律 更多
    [self removeSubModel:@"A041" model:model];
    [self removeSubModel:@"A016" model:model];
    // 更改广告图
    NSMutableArray *arrm = [[NSMutableArray alloc] init];
    for (LoginPageModel *submodel in model.ad) {
        submodel.picUrl = @"http://123.59.106.50:8052/Financial_app/notice/bxbanner.png";
        [arrm addObject:submodel];
    }
    model.ad = arrm;
    // 设置model
    _model = model;
}
- (void)removeSubModel:(NSString *)key model:(LoginModel *)model {
    for (LoginItemModel *subModel in model.list) {
        if ([subModel.businesscode isEqualToString:key]) {
            [model.list removeObject:subModel];
            return;
        }
    }
}


// 是否在审核期内
+ (BOOL)isShenHeDate {
    NSString *shenhe = [SaveManager getStringForKey:@"shenhe"];
    return [shenhe isEqualToString:@"1"];
    
    /**
    NSString *phone = GetAccount;
    if (!phone || [phone isEqualToString:@"15753099908"]) {
        return YES;
    }
    return NO;
     */
    
    /**
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYYMMdd"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSInteger nowtimeStr = [[formatter stringFromDate:datenow] integerValue];
    return nowtimeStr < SHENHE_DATE;
     */
}

@end
