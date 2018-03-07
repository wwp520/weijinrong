//
//  CardInputList.m
//  weijinrong
//
//  Created by RY on 17/6/13.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CardInputList.h"

#pragma mark - 声明
@interface CardInputList ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

#pragma mark - 实现
@implementation CardInputList


- (void)displayAnimation:(CGFloat)height {
    self.height = 0;
    [UIView animateWithDuration:.3f animations:^{
        self.height = height;
    }];
}
- (void)hiddenAnimation {
    [UIView animateWithDuration:.3f animations:^{
        self.height = 0;
    }];
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


@end

