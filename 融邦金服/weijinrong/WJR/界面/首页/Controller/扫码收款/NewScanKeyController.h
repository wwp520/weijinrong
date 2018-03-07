//
//  NewScanKeyController.h
//  chengzizhifu
//
//  Created by RY on 17/1/6.
//  Copyright © 2017年 ZYH. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CardBenifitModel.h"

@interface NewScanKeyController : BaseViewController
@property (nonatomic, retain) NSMutableArray<CardBenifitListModel *> *dataArray;
@property (nonatomic, assign) NSInteger type;
@end
