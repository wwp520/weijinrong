//
//  PushController.h
//  weijinrong
//
//  Created by RY on 17/6/16.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseViewController.h"
#import "UserPushModel.h"

@interface PushController : BaseViewController

@property (nonatomic, strong) UserPushModel *model;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
