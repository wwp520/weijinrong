//
//  LoadInfoViewController.h
//  weijinrong
//
//  Created by ouda on 17/5/19.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseViewController.h"
#import "RunCardModel.h"
#import "LookUpdateInfoModel.h"

@interface LoadInfoViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UITextField *contactTF;
@property (weak, nonatomic) IBOutlet UITextField *photoTF;


@property(nonatomic,strong)RunCardListModel * model;
@property(nonatomic,strong)LookUpdateInfoModel * Modelss;
@end
