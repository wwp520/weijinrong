//
//  PushView.h
//  weijinrong
//
//  Created by RY on 17/6/16.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseView.h"
#import "UserPushModel.h"

@interface PushView : BaseView

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (nonatomic, strong) UserPushModel *model;
@property (nonatomic, copy) KKBlock click;

+ (instancetype)loadFromFrame:(CGRect)frame click:(KKBlock)click;

@end
