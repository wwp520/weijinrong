//
//  TransDayCell.h
//  chengzizhifu
//
//  Created by RY on 17/3/7.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransDayCell : UITableViewCell

@property (nonatomic, strong) NSArray *modelArr;
@property (nonatomic, assign) NSInteger type;// 0 微信 1支付宝

+ (instancetype)initWithTable:(UITableView *)table identifier:(NSString *)identifier;

@end
