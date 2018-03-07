//
//  WebLinkController.h
//  weijinrong
//
//  Created by ouda on 17/6/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseViewController.h"
#import "CardWelfareModel.h"

@interface WebLinkController : BaseViewController
@property(nonatomic,strong)NSURL  * url;
@property(nonatomic,strong)CardWelfareListModel * model;
@property(nonatomic,strong)NSString * cardLink;
@end
