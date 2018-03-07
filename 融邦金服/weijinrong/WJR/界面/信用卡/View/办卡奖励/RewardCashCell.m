//
//  RewardCashCell.m
//  weijinrong
//
//  Created by ouda on 17/6/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "RewardCashCell.h"

@implementation RewardCashCell

- (void)setModel:(RewardBankListModel *)model {
    _model = model;
    _name.text = [NSString stringWithFormat:@"%@(%@)",model.headquartersbank,model.shortbankcardnumber];
}

- (void)setSelectImage:(BOOL)isImage {
    if (isImage) {
        _icon.image = [UIImage imageNamed:@"资源 65.png"];
    }else {
        _icon.image = [UIImage imageNamed:@"资源 66.png"];
    }
}

@end
