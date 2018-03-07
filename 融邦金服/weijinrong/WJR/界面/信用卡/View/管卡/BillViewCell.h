//
//  BillViewCell.h
//  weijinrong
//
//  Created by ouda on 17/5/9.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
