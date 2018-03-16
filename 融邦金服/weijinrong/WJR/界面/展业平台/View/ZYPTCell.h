//
//  ZYPTCell.h
//  weijinrong
//
//  Created by ouda on 2018/3/14.
//  Copyright © 2018年 oudapay. All rights reserved.
//

#import "BaseCell.h"

@interface ZYPTCell : BaseCell

+ (instancetype)loadWithTable1:(UITableView *)table;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (weak, nonatomic) IBOutlet UIButton *pushBtn;
@property (weak, nonatomic) IBOutlet UIButton *bmgBtn;

@end
