//
//  CardWelfaresCell.h
//  weijinrong
//
//  Created by ouda on 17/6/16.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCardModel.h"
#import "CardWelfareModel.h"

@interface CardWelfaresCell : BaseCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UIButton *kmBtn;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *bankname;

@property(nonatomic,strong)CardWelfareListModel * cardmodel;

// xib init
+ (instancetype)loadNib:(CGRect)frame;
@end
