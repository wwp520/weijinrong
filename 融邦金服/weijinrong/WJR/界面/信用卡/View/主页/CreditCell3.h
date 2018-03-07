//
//  CreditCell3.h
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardBenifitModel.h"


@interface CreditCell3 : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *titles;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (weak, nonatomic) IBOutlet UILabel *cardCount;

@property(nonatomic,strong)CardBenifitListModel * model;
@property (nonatomic, strong)NSString *ids;

@end
