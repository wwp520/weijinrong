//
//  TransDayView.m
//  chengzizhifu
//
//  Created by RY on 17/1/5.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "TransDayView.h"
#import "TransWeekCell.h"
#import "TransTools.h"
#import "TransDayCell.h"
#import "ReceiptViewController.h"

#define Formatter(a,b) [NSString stringWithFormat:a,b]

#pragma mark 声明
@interface TransDayView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) TransDayView *header;
@property (nonatomic, strong) TransDayView *header1;
@property (nonatomic, strong) TransDayView *header2;
@property (nonatomic, strong) TransDayView *header3;
@end

#pragma mark 实现
@implementation TransDayView

#pragma mark 初始化
+ (instancetype)initWithFrame:(CGRect)frame {
    TransDayView *view = [[NSBundle mainBundle] loadNibNamed:@"TransDayView" owner:nil options:nil].firstObject;
    [view setFrame:frame];
    [view.table setTableHeaderView:[view header]];
//    view.date.text = [TransTools dateWithStatu:2 comStr:@"" date:[NSDate date]];
//    view.wei.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    view.alipy.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return view;
}
- (TransDayView *)header {
    if (!_header) {
        _header = [[NSBundle mainBundle] loadNibNamed:@"TransDayView" owner:nil options:nil][1];
        UILabel *date = [self.header viewWithTag:1001];
        _header.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _header.layer.borderWidth = 1;
        date.text = ({
            NSDate *date = [NSDate date];
            NSDateFormatter *fora = [[NSDateFormatter alloc] init];
            [fora setDateFormat:@"yyyy-MM-dd"];
            [fora stringFromDate:date];
        });
        
    }
    return _header;
}
- (TransDayView *)header1 {
    if (!_header1) {
        _header1 = [[NSBundle mainBundle] loadNibNamed:@"TransDayView" owner:nil options:nil][2];
        _header1.hidden = NO;
        [(UIButton *)[_header1 viewWithTag:1001] addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _header1;
}
- (TransDayView *)header2 {
    if (!_header2) {
        _header2 = [[NSBundle mainBundle] loadNibNamed:@"TransDayView" owner:nil options:nil][3];
        _header2.hidden = NO;
        [(UIButton *)[_header2 viewWithTag:1001] addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _header2;
}
- (TransDayView *)header3 {
    if (!_header3) {
        _header3 = [[NSBundle mainBundle] loadNibNamed:@"TransDayView" owner:nil options:nil][4];
        _header3.hidden = NO;
        [(UIButton *)[_header3 viewWithTag:1001] addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _header3;
}

- (void)headerClick:(UIButton *)sender {
    [UIView animateWithDuration:.2f animations:^{
        UIImageView *image = [sender.superview viewWithTag:1005];
        image.transform = CGAffineTransformRotate(image.transform, M_PI / 4 * 5);
    }];
    if ([[_header1 viewWithTag:1001] isEqual:sender]) {
        NSLog(@"1");
        _header1.cellHidden = !_header1.cellHidden;
        [_table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if ([[_header2 viewWithTag:1001] isEqual:sender]) {
        NSLog(@"2");
        _header2.cellHidden = !_header2.cellHidden;
        [_table reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if ([[_header3 viewWithTag:1001] isEqual:sender]) {
        NSLog(@"3");
        _header3.cellHidden = !_header3.cellHidden;
        [_table reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)setModel:(TransDayModel *)model {
    _model = model;
    // 总金额
    UILabel *money = [self.header viewWithTag:1000];
    money.text = Formatter(@"%.2f元", [model.sumMoney floatValue]);
    // 刷新数组
    [_table reloadData];
    // 头视图赋值
    UILabel *money1 = [self.header1 viewWithTag:1002];
    money1.text = Formatter(@"交易金额: %.2f元", [model.WeChatMoney floatValue]);
    UILabel *count1 = [self.header1 viewWithTag:1003];
    count1.text = Formatter(@"共%@笔", model.WeChatStroke);
    
    
    UILabel *money2 = [self.header2 viewWithTag:1002];
    money2.text = Formatter(@"交易金额: %.2f元", [model.alipayMoney floatValue]);
    UILabel *count2 = [self.header2 viewWithTag:1003];
    count2.text = Formatter(@"共%@笔", model.alipayStroke);
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_table reloadData];
    });
}

#pragma mark UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [self header1];
    }
    else if (section == 1) {
        return [self header2];
    }
    else {
        return [self header3];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 54;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return _model.WeChat.count >= 3 ? 44 * 3 : _model.WeChat.count * 44;
    }else {
        return _model.alipay.count >= 3 ? 44 * 3 : _model.alipay.count * 44;
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && [self header1].cellHidden == NO) {
        return 1;
    }
    else if (section == 1 && [self header2].cellHidden == NO) {
        return 1;
    }
    else if (section == 2 && [self header3].cellHidden == NO) {
        return 1;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    TransDayCell *cell = [TransDayCell initWithTable:tableView identifier:Formatter(@"TransDayCell%ld", (long)indexPath.section)];
    cell.type = indexPath.section;
    if (indexPath.section == 0) {
        [cell setModelArr:_model.WeChat];
    }else {
        [cell setModelArr:_model.alipay];
    }
    return cell;
}



@end






