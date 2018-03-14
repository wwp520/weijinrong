//
//  ZYTable.m
//  weijinrong
//
//  Created by ouda on 2018/3/13.
//  Copyright © 2018年 oudapay. All rights reserved.
//

#import "ZYTable.h"

@implementation ZYTable

+ (instancetype)initWithFrame:(CGRect)frame{
    ZYTable *table = [[ZYTable alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    table.delegate = table;
    table.dataSource = table;
    table.separatorStyle = UITableViewCellSelectionStyleNone;
    table.showsVerticalScrollIndicator = NO;
    table.showsHorizontalScrollIndicator = NO;
    [table setLineHide];
    [table setLineAll];
    return table;
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYPTCell *cell = [ZYPTCell loadWithTable1:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 //   cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (self.dataArray.count > indexPath.row) {
//        cell.model = self.dataArray[indexPath.row];
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}


@end
