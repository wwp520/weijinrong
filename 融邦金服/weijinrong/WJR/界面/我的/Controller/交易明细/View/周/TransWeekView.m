//
//
//  chengzizhifu
//
//  Created by RY on 17/1/5.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "TransWeekView.h"
#import "TransDayDetailController.h"
#import "TransWeekCell.h"
#import "TransTools.h"

#pragma mark 声明
@interface TransWeekView ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITableView *table;



@end

#pragma mark 实现
@implementation TransWeekView

#pragma mark 初始化



+ (instancetype)initWithFrame:(CGRect)frame {
    TransWeekView *view = [[NSBundle mainBundle] loadNibNamed:@"TransWeekView" owner:nil options:nil].firstObject;
    view.frame = frame;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.borderWidth = 1;
    view.date.text = ({
        NSString *ago = [TransTools dateWithStatu:2 comStr:@"" date:[NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * -7]];
        NSString *now = [TransTools dateWithStatu:2 comStr:@"" date:[NSDate date]];
        [NSString stringWithFormat:@"%@-%@",ago,now];
    });
    view.table.tableHeaderView = ({
        UIView *view = [[NSBundle mainBundle] loadNibNamed:@"TransWeekView" owner:nil options:nil].lastObject;
        view;
    });
    view.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return view;
}

- (void)setModel:(TransWeekModel *)model {
    _model = model;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_table reloadData];
        _money.text = [NSString stringWithFormat:@"%.2f元",[model.sumMoney floatValue]];
    });
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.alipay.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransWeekCell *cell = [TransWeekCell initWithTable:tableView];
    cell.dict = _model.alipay[indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TransDayDetailController *vc = [[TransDayDetailController alloc] init];
    vc.date = ({
        NSString *dateStr1 = _model.alipay[indexPath.row][@"dealTime"];
        NSDateFormatter *datefor = [[NSDateFormatter alloc] init];
        [datefor setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [datefor dateFromString:dateStr1];
        NSDateFormatter *datefor2 = [[NSDateFormatter alloc] init];
        [datefor2 setDateFormat:@"yyyyMMdd"];
        [datefor2 stringFromDate:date];
    });
    vc.displayDate = _model.alipay[indexPath.row][@"dealTime"];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}


@end








