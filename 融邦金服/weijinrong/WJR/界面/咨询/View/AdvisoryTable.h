//
//  AdvisoryTable1.h
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardWelfareModel.h"

@interface AdvisoryTable : UITableView

+ (instancetype)initWithFrame:(CGRect)frame;

@property(nonatomic,strong)NSMutableArray <CardWelfareListModel*>* dataArray;

@end
