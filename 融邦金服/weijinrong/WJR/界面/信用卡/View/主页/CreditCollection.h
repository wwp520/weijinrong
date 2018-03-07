//
//  CreditCollection.h
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCardModel.h"
#import "CardBenifitModel.h"
#import "BankLinkInfoModel.h"
#import "CreditHeaderView.h"
#import "CarTypeModel.h"

@interface CreditCollection : UIView

+ (instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic, strong) UICollectionView *collection;
@property(nonatomic, strong) CreditCardModel * model;
@property(nonatomic, strong) CardBenifitModel * models;
@property(nonatomic, strong) BankLinkInfoModel * modell;
@property(nonatomic, strong) CardBenifitListModel * listmodel;
@property(nonatomic, strong) CarTypeModel * typemodel;

@property(nonatomic,strong)NSString *amount;
@property(nonatomic,strong)NSString *sumAmount;

@end
