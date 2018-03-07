//
//  HomeLocation.h
//  weijinrong
//
//  Created by RY on 17/3/30.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^KKLocationBlock)(NSString *city, NSString *address);

#pragma mark - 声明
@interface HomeLocation : NSObject
singleton_interface(HomeLocation)
@property(nonatomic,assign)NSInteger cityId;

+ (instancetype)sharedHomeLocation:(KKLocationBlock)city error:(KKBlock)error;

@end
