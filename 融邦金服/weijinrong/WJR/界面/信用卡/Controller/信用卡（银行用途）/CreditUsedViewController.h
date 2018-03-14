//
//  CreditUsedViewController.h
//  weijinrong
//
//  Created by ouda on 17/5/22.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseViewController.h"
#import "BankLinkInfoModel.h"
#import "CarTypeModel.h"
#import "CardBenifitModel.h"

@interface CreditUsedViewController : BaseViewController



@property(nonatomic,assign) NSInteger type;
@property(nonatomic,strong) NSString *bankNo;
@property(nonatomic,strong) NSString *cardType;
@property(nonatomic,strong) NSString *cardLevel;

@property (nonatomic, strong) CarTypeListModel *cardTypeModel;//用途
@property (nonatomic, strong) CardBenifitListModel *bflistModel;//用途

@end
