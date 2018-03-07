//
//  CreditUsedCell.h
//  weijinrong
//
//  Created by ouda on 17/5/22.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardWelfareModel.h"
#import "CardBenifitModel.h"

@interface CreditUsedCell : BaseCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;

@property(nonatomic,strong)CardWelfareListModel *model;
@property(nonatomic,strong)CardBenifitListModel * benifitModel;
@end
