//
//  CreditCell6.h
//  weijinrong
//
//  Created by RY on 17/5/17.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCardModel.h"

@interface CreditCell6 : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *titles;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UIButton *kmLb;
@property (weak, nonatomic) IBOutlet UILabel *storename;


@property(nonatomic,strong)NSString * map;
@property(nonatomic,strong)CreditCardListModel * cardmodel;
//@property(nonatomic,strong)CreditCardModel * cardmodel;
@end
