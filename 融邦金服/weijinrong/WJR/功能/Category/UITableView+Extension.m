//
//  UITableView+Extension.m
//  weijinrong
//
//  Created by RY on 17/4/5.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

// 隐藏多余线
- (void)setLineHide {
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
// 设置tableview横线
- (void)setLineAll {
    self.separatorInset = UIEdgeInsetsZero;
}
// 设置tableview横线(有间隙)
- (void)setLinePadding {
    self.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
}

@end
