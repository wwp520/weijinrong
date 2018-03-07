//
//  TableDataSource.m
//  TableHeadChang
//
//  Created by ouda on 17/3/15.
//  Copyright © 2017年 ouda. All rights reserved.
//

#import "TableDataSource.h"

@implementation TableDataSource


// 数据
- (NSArray *)models {
    if (!_models) {
        _models = @[@"1",@"2",@"3",@"4"];
    }
    return _models;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.models[indexPath.row];
    return cell;
}

@end
