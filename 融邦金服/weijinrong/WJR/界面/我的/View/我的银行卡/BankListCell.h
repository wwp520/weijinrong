//
//  BankListCell.h
//  chengzizhifu
//
//  Created by RY on 17/1/18.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bank;
@property (weak, nonatomic) IBOutlet UILabel *four;
@property (weak, nonatomic) IBOutlet UILabel *name;

+ (instancetype)initWithTable:(UITableView *)table ;

@end
