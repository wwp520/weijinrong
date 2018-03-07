//
//  AdvisoryCell.h
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseCell.h"
#import "CardWelfareModel.h"

@interface AdvisoryCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property(nonatomic,strong)CardWelfareListModel * model;

+ (instancetype)loadWithTable1:(UITableView *)table;

@end
