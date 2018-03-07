//
//  文件名: CardWelfareTable.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/6
//

#import "CardWelfareTable.h"
#import "CardWelfareCell.h"
#import "IntegralListCell.h"
#import "IntegralModel.h"
#import "LinkViewController.h"
#import "CreditCell6.h"
#import "CardWelfaresCell.h"
#import "CardLinkController.h"
#import "CardWelfareController.h"

#pragma mark - 声明
@interface CardWelfareTable()<UITableViewDelegate,UITableViewDataSource>
@end

#pragma mark - 实现
@implementation CardWelfareTable

#pragma mark - 初始化
// code init
+ (instancetype)loadCode:(CGRect)frame {
    CardWelfareTable *view = [[CardWelfareTable alloc] initWithFrame:frame];
    [view table];
    return view;
}
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        [_table setLineHide];
        [_table setLineAll];
        [self addSubview:_table];
    }
    return _table;
}




//- (void)setModel:(CreditCardListModel *)model{
//    _model = model;
//}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _model.list.count;
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CardWelfaresCell *cell = [CardWelfaresCell loadWithTable:tableView];
    
    
    if (self.dataArray.count > indexPath.row) {
        CardWelfareListModel *model = self.dataArray[indexPath.row];
        [cell.icon sd_setImageWithURL:[NSURL  URLWithString:model.logo]];
        cell.title.text = model.title;
        cell.content.text = model.body;
        [cell.kmBtn setTitle:[NSString stringWithFormat:@"%@km",model.km] forState:UIControlStateNormal];
        cell.shopName.text = model.shopName;
        cell.bankname.text = model.bankName;
        cell.cardmodel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([model.shopName rangeOfString:model.title].location != NSNotFound) {
            NSString *str2 = [model.shopName stringByReplacingOccurrencesOfString:model.title withString:@""];
            str2 = [str2 stringByReplacingOccurrencesOfString:@"(" withString:@""];
            str2 = [str2 stringByReplacingOccurrencesOfString:@")" withString:@""];
            cell.shopName.text = str2;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else {
            cell.shopName.text = model.shopName;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark--UITableViewDelegate
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CardLinkController * linkVC = [[CardLinkController  alloc]init];
    linkVC.openUrl = self.dataArray[indexPath.row].content;
    [self.viewController.navigationController  pushViewController:linkVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


@end
