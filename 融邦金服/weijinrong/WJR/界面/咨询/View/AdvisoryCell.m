//
//  AdvisoryCell.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "AdvisoryCell.h"
#import "CardWelfareModel.h"

#pragma mark 声明
@interface AdvisoryCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconRight;

@end

#pragma mark 实现
@implementation AdvisoryCell

#pragma mark 初始化
+ (instancetype)loadWithTable1:(UITableView *)table {
    AdvisoryCell *cell = [AdvisoryCell loadWithTable:table];
    return cell;
}

- (void)setModel:(CardWelfareListModel *)model {
    _model = model;
    
    self.title.text = model.title;
    self.content.text = model.body;
    if (model.logo && model.logo.length != 0) {
        self.iconWidth.constant = self.height - 20;
        self.iconRight.constant = self.height - 20;
        [self.icon sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"moren"]];
    }else {
        self.iconWidth.constant = 0;
        self.iconRight.constant = 0;
    }
    
}


@end

