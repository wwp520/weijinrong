//
//  文件名: LoanFinTable.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/5
//

#import "LoanFinTable.h"
#import "LoanFinTableCell.h"

#pragma mark - 声明
@interface LoanFinTable()<UITableViewDelegate,UITableViewDataSource>

@end

#pragma mark - 实现
@implementation LoanFinTable

#pragma mark - 初始化
// code init
+ (instancetype)loadCode:(CGRect)frame {
    LoanFinTable *view = [[LoanFinTable alloc] initWithFrame:frame];
    [view table];
    return view;
}
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.bounces = NO;
        [self addSubview:_table];
    }
    return _table;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoanFinTableCell *cell = [LoanFinTableCell loadWithTable:tableView];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
