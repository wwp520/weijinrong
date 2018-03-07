//
//  BaseCell.m
//  BusinessPeople
//
//  Created by RY on 17/1/12.
//  Copyright © 2017年 RY. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

// 加载 xib 控件
+ (instancetype)loadWithTable:(UITableView *)table {
    NSString *name = NSStringFromClass(self);
    BaseCell *cell = (BaseCell *)[table dequeueReusableCellWithIdentifier:name];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil].firstObject;
    }
    return cell;
}
// 加载 xib 控件
+ (instancetype)loadLastNib:(UITableView *)table {
    NSString *name = NSStringFromClass(self);
    BaseCell *cell = (BaseCell *)[table dequeueReusableCellWithIdentifier:name];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil].lastObject;
    }
    return cell;
}

@end
