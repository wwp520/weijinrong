//
//  ZYTable.h
//  weijinrong
//
//  Created by ouda on 2018/3/13.
//  Copyright © 2018年 oudapay. All rights reserved.
//

#import "BaseView.h"
#import "ZYPTCell.h"

@interface ZYTable : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) NSInteger index;

+ (instancetype)initWithFrame:(CGRect)frame;

@end
