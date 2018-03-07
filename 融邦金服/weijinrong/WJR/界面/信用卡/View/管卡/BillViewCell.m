//
//  BillViewCell.m
//  weijinrong
//
//  Created by ouda on 17/5/9.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BillViewCell.h"

@implementation BillViewCell
+ (instancetype)initWithTable:(UITableView *)table {
    BillViewCell *cell = [table dequeueReusableCellWithIdentifier:@"BillViewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BillViewCell" owner:nil options:nil].firstObject;
    }
    
    
    return cell;
}
@end
