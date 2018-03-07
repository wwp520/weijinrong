//
//  文件名: CardManagerController.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "CardManagerController.h"
#import "LoanFinIcon.h"
#import "CardManagerTable.h"
#import "DongManager.h"
#import "CardManagerModel.h"

#pragma mark - 声明
@interface CardManagerController()
@property (nonatomic, strong) CardManagerTable *table;
@property (nonatomic, strong) CardManagerModel *model;
@property (nonatomic, strong) NetFailView *netFail;
@end

#pragma mark - 实现
@implementation CardManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"管卡"];
    [self table];
//    [self netFail];
    [self  DownLoadData];
}

//账单管理,消息中心
- (NetFailView *)netFail {
    if (!_netFail) {
        _netFail = [NetFailView loadFromFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) click:^{
            [self DownLoadData];
        }];
        [self.view addSubview:_netFail];
        [self.view bringSubviewToFront:_netFail];
    }
    _netFail.alpha = 1;
    return _netFail;
}

#pragma mark--网络接口
//管卡出列表
- (void)DownLoadData {
    [self showHudLoadingView:@"正在获取..."];
    
    [DongManager  getBankCardList:nil success:^(id requestData) {
        [self hiddenHudLoadingView];
        _model = [CardManagerModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
//            [self showTitle:_model.retMessage delay:1];
            _table.model = _model;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_table.table reloadData];
            });
            NSLog(@"----------------------%@",requestData);
        }else{
         [self showTitle:_model.retMessage delay:1];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];

}



- (CardManagerTable *)table {
    if (!_table) {
        _table = [CardManagerTable loadCode:CGRectMake(0, 0 , ScreenWidth, ScreenHeight )];
        [self.view addSubview:_table];
    }
    return _table;
}



@end
