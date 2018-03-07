//
//  RunCardCell.h
//  weijinrong
//
//  Created by ouda on 17/5/19.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunCardModel.h"

@interface RunCardCell : BaseCell
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *credate;
@property (weak, nonatomic) IBOutlet UIImageView *status;
@property (weak, nonatomic) IBOutlet UILabel *upLoad;
@property (weak, nonatomic) IBOutlet UILabel *status1;

@property(nonatomic,strong)RunCardModel * model;

@end
