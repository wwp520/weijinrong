//
//  文件名: CreditInfoController.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "CreditInfoController.h"
#import "CreditInfoTable.h"
#import "CreditCurMonth.h"
#import "CardManagerDetailModel.h"
#import "CreditInfoCell.h"
#import "CardManagerHead.h"
#import "CreditInfoHead.h"
#import "CardArrangeModel.h"

#pragma mark - 声明
@interface CreditInfoController()
@property (nonatomic, strong) CreditInfoTable *table;
@property (nonatomic, strong) CreditCurMonth *month;
@property (nonatomic, strong) CardArrangeModel *model;
@end

#pragma mark - 实现
@implementation CreditInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"详情"];
    [self table];
    [self month];
    [self loadInfo];
}

- (void)setManmodel:(CardManagerInfoModel *)manmodel{
    _manmodel = manmodel;
}




//详情
- (void)loadInfo {
    [self showHudLoadingView:@"正在获取..."];
//    NSString *oldParam = [NSString stringWithFormat:@"requestData=%@",({
//        NSString *str = [KKTools dictionaryToJson:
//                         @{@"mercId":[SaveManager getStringForKey:@"mercId"],
//                           @"cardNo":_cardNo,
//                           @"bankName":_manmodel.bankName
//                           }];
//        [KKTools encryptionJsonString:str];
//    })];
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [SaveManager  getStringForKey:@"mercId"],@"mercId",
                             _manmodel.bankName,@"bankName",
                              _cardNo , @"cardNo",
                              nil];
        NSString *str = [KKTools dictionaryToJson:dict];  //类型
        [KKTools encryptionJsonString:str];
    })];

    
    
    [DongManager getBankCardListDelteil:oldParam success:^(id requestData) {
        [self  hiddenHudLoadingView];
        // 解析数据
        CardManagerDetailModel *model = [CardManagerDetailModel decryptBecomeModel:requestData];
        // 成功
        if (model.retCode == 0) {
            // 整理数据
            [self.model arrangeModel:model];
            // 设置数据
            [_table setModel:_model];
            [_month setModel:_model];
            // 刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                [_table.table reloadData];
            });
        }else {
            [self showTitle:model.retMessage delay:2];
            [self popDelay];
        }
        NSLog(@"----------------------%@",requestData);
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}

- (CreditInfoTable *)table {
    if (!_table) {
        _table = [CreditInfoTable loadCode:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.month.height)];
        _table.url = _url;
        _table.countDown = _countDown;
        _table.huanDate = _huanDate;
        [self.view addSubview:_table];
    }
    return _table;
}
// 最下方view
- (CreditCurMonth *)month {
    if (!_month) {
        _month = [CreditCurMonth loadFromFrame:CGRectMake(0, ScreenHeight - 67, ScreenWidth, 67)];
        [self.view addSubview:_month];
    }
    return _month;
}
// 数据
- (CardArrangeModel *)model {
    if (!_model) {
        _model = [[CardArrangeModel alloc] init];
    }
    return _model;
}

@end
