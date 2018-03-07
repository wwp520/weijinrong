//
//  文件名: CreditInfoTable.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "CreditInfoTable.h"
#import "CreditInfoHead.h"
#import "CreditInfoCell.h"
#import "CardManagerDetailModel.h"
#import "CreditCurMonth.h"

#pragma mark - 声明
@interface CreditInfoTable()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) CreditInfoHead *head;
@end

#pragma mark - 实现
@implementation CreditInfoTable

+ (instancetype)loadCode:(CGRect)frame {
    CreditInfoTable *view = [[CreditInfoTable alloc] initWithFrame:frame];
    [view table];
    return view;
}
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        [_table setDelegate:self];
        [_table setDataSource:self];
        [_table setTableHeaderView:[self head]];
        [_table setLineHide];
        [_table setLineAll];
        [self addSubview:_table];
    }
    return _table;
}
- (void)setCountDown:(NSString *)countDown {
    _countDown = countDown;
    
    _head.lastDay.text = _countDown;
}
- (void)setHuanDate:(NSString *)huanDate {
    _huanDate = huanDate;
    _head.huanDate.text = huanDate;
}


- (CreditInfoHead *)head {
    if (!_head) {
        _head = [CreditInfoHead loadFromFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 750.f * 420)];
    }
    _head.model = _model;
    return _head;
}

- (void)setModel:(CardArrangeModel *)model {
    _model = model;
    _head.model = _model;
}
- (void)setUrl:(NSString *)url {
    _url = url;
    _head.bankUrl = url;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *monthArray = _model.monthList[[_model.monthList allKeys][indexPath.section]];
    CardArrangeMonthModel *monthModel = monthArray[indexPath.row];
    if (indexPath.row == 0 && indexPath.section == 0) {
        // 未出账单的Cell
//        return monthModel.isUnfolded == NO ? 50 : 200;
        return 0;
    }else {
        // 普通的Cell
        return monthModel.isUnfolded == NO ? 50 : 50 + monthModel.dayList.count * 30;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0 : 40.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    [tableView beginUpdates];
    
    // 设置标识
    NSMutableArray *monthArray = _model.monthList[[_model.monthList allKeys][indexPath.section]];
    CardManagerDetailListModel *model = monthArray[indexPath.row];
    model.unfolded = !model.unfolded;
    // 旋转三角
    CreditInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell rotateTriangle];
    
    [tableView endUpdates];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_model.monthList allKeys].count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *monthArray = _model.monthList[[_model.monthList allKeys][section]];
    return monthArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CreditInfoCell *cell = [CreditInfoCell loadWithTable:tableView click:^{
        if (indexPath.row == 0 && indexPath.section == 0) {
            // 未出账单授权按钮被点击
            NSLog(@"test");
        }
    }];
    // Cell数据
    [cell setModel:({
        NSMutableArray *monthArray = _model.monthList[[_model.monthList allKeys][indexPath.section]];
        CardArrangeMonthModel *model = monthArray[indexPath.row];
        model;
    })];
    // 是否是未出账单
    [cell setAleardyOrder:indexPath.section == 0 && indexPath.row == 0];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    [view setBackgroundColor:RGB(233, 233, 233, 1)];
    [view addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth, 40)];
        label.text = [_model.monthList allKeys][section];
        label.textColor = [UIColor darkGrayColor];
        label;
    })];
    return view;
}

@end










