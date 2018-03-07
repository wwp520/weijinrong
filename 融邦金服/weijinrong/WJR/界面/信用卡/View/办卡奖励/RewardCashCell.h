//
//  RewardCashCell.h
//  weijinrong
//
//  Created by ouda on 17/6/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseCell.h"
#import "RewardBankModel.h"

@interface RewardCashCell : BaseCell

@property(nonatomic,strong)RewardBankListModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

- (void)setSelectImage:(BOOL)isImage;

@end
