//
//  ShenHe.h
//  weijinrong
//
//  Created by ouda on 17/6/21.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShenHe : NSObject
singleton_interface(ShenHe)

@property (nonatomic,strong) LoginModel *model;
@property (nonatomic,assign,getter=isSh) BOOL sh;// 是否在审核

/**
 是否在审核期内

 @return 是否在审核期内
 */
+ (BOOL)isShenHeDate;

@end
