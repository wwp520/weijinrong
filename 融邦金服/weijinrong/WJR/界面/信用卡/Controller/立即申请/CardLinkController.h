//
//  CardLinkController.h
//  weijinrong
//
//  Created by ouda on 17/5/26.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseViewController.h"
#import "CardBenifitModel.h"
#import "CardWelfareModel.h"

@interface CardLinkController : BaseViewController
@property(nonatomic,strong)CardBenifitListModel *model;
@property(nonatomic,strong)NSString *openUrl;
@end


