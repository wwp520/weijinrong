//
//  文件名: CardManagerTable.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "CardManagerTable.h"
#import "CardManagerHead.h"
#import "CardManagerFoot.h"
#import "CardManagerCell.h"
#import "LoanFinIcon.h"
#import "CreditAddController.h"
#import "CreditInfoController.h"
#import "BillViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CardEmailController.h"

#pragma mark - 声明
@interface CardManagerTable()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) CardManagerHead *head;
@property (nonatomic, strong) CardManagerFoot *foot;
@property (nonatomic, strong) LoanFinIcon *finIcon;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *models;
@end

#pragma mark - 实现
@implementation CardManagerTable

#pragma mark - 初始化
+ (instancetype)loadCode:(CGRect)frame {
    CardManagerTable *view = [[CardManagerTable alloc] initWithFrame:frame];
    [view table];
    return view;
}
- (UITableView *)table    {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableHeaderView = [self finIcon];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table setLineHide];
        [self addSubview:_table];
    }
    return _table;
}

- (LoanFinIcon *)finIcon  {
    if (!_finIcon) {
        _finIcon = [LoanFinIcon loadCode:CGRectMake(0, 64, ScreenWidth, 150)];
        [_finIcon setImageArr:({
//            @[@"http://img.blog.csdn.net/20161230153325161?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvSGVsbG9fSHdj/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast",
//              @"http://img.blog.csdn.net/20161230153522237?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvSGVsbG9fSHdj/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast"];
            @[@"管卡banner"];
        }) click:^(NSInteger i) {
            
        }];
    }
    return _finIcon;
}
- (CardManagerHead *)head {
    if (!_head) {
        _head = [CardManagerHead loadFromFrame:CGRectMake(0, 0, ScreenWidth, 0) click:^(NSInteger i) {
            // i: 0账单 1利息
            if (i == 0) {
                BillViewController * billVC = [[BillViewController  alloc]init];
                [self.viewController.navigationController  pushViewController:billVC animated:YES];
            }else {
                
            }
            _head.alpha = 0;
        }];
    }
    return _head;
}

//添加信用卡(点击事件跳转至邮箱导入)
- (CardManagerFoot *)foot {
    if (!_foot) {
        _foot = [CardManagerFoot loadFromFrame:CGRectMake(0, 0, ScreenWidth, 100) click:^{
//            CreditAddController *vc = [[CreditAddController alloc] init];
//            [self.viewController.navigationController pushViewController:vc animated:YES];
            CardEmailController * emailVC = [[CardEmailController alloc]init];
            [self.viewController.navigationController pushViewController:emailVC animated:YES];
        }];
    }
    return _foot;
}


- (void)setModel:(CardManagerModel *)model{
    _model = model;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _model.list.count == 0 ? 1 : _model.list.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_model.list.count >= 1) {
        CardManagerCell *cell = [CardManagerCell loadWithTable:tableView];
        // 数据
        cell.model = _model.list[indexPath.section];
        return cell;
    }else {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_model.list.count >= 1) {
        CreditInfoController *vc = [[CreditInfoController alloc] init];
        vc.url = _model.list[indexPath.section].url;
        vc.cardNo = _model.list[indexPath.section].cardNo;
        vc.manmodel = _model.list[indexPath.section];
        vc.countDown = _model.list[indexPath.section].RepaymentDate;
        vc.huanDate = _model.list[indexPath.section].RepaymentTime;
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_model.list.count >= 1) {
        return 110;
    }
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_model.list.count >= 1) {
        return section == _model.list.count - 1 ? 100 : 10;
    }else {
        return 100;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
//    return section == 0 ? 60 : 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section == 0 ? [self head] : [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (_model.list.count >= 1) {
        return section == _model.list.count - 1 ? [self foot] : [UIView new];
    }else {
        return [self foot];
    }
}

@end
