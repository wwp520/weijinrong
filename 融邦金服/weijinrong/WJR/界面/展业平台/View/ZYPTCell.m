//
//  ZYPTCell.m
//  weijinrong
//
//  Created by ouda on 2018/3/14.
//  Copyright © 2018年 oudapay. All rights reserved.
//

#import "ZYPTCell.h"

@implementation ZYPTCell

+ (instancetype)loadWithTable1:(UITableView *)table {
    ZYPTCell *cell = [ZYPTCell loadWithTable:table];
    cell.bmgBtn.layer.cornerRadius = 5;
    cell.bmgBtn.layer.masksToBounds = YES;
    cell.bmgBtn.userInteractionEnabled = NO;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
