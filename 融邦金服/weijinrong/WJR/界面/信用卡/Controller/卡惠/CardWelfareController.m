//
//  文件名: CardWelfareController.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/6
//

#import "CardWelfareController.h"
#import "CardWelfareTable.h"
#import "HomeLocation.h"
#import "HomeBtn.h"
#import "UserModel.h"
#import "CardWelfareModel.h"
#import "BaseViewController.h"

#pragma mark - 声明
@interface CardWelfareController(){
    NSInteger curPage;
}

@property (nonatomic, strong) CardWelfareTable *table;
@property (nonatomic, strong) HomeLocation *location;
@property (nonatomic, strong) CardWelfareModel * model;
@property (nonatomic, strong) NSMutableArray<CardWelfareListModel*> * dataArray;

@end

#pragma mark - 实现
@implementation CardWelfareController

// 懒加载
-(NSMutableArray<CardWelfareListModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     curPage = 1;
    [self setNavTitle:@"卡惠"];
    [self table];
    [self location];
    [self getInfo:curPage];
    [self setupRefresh];
}

// 刷新
- (void)setupRefresh {
    _table.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    _table.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerLoading)];
}
// 进入刷新状态
- (void)headerRefreshing{
    curPage = 1;
    [self.dataArray removeAllObjects];
    [self getInfo:curPage];
    [_table.table.mj_header endRefreshing];
}
// 进入加载状态
- (void)footerLoading{
    curPage ++;
    [self getInfo:curPage];
    [_table.table.mj_footer endRefreshing];
}


// 卡惠
- (void)getInfo:(NSInteger)page {
    [self  showHudLoadingView:@"正在获取。。。"];
    
    CGFloat  lat = [KKStaticParams sharedKKStaticParams].lat;
    CGFloat  lot = [KKStaticParams sharedKKStaticParams].lot;
    NSInteger cityId = [KKStaticParams sharedKKStaticParams].cityId;
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [SaveManager  getStringForKey:@"mercId"],@"mercId",@(cityId),@"bdcitycode",
                              @(lot),@"bdlng",   //经度
                              @(lat) ,@"bdlat",   //纬度
                              @(page),@"pageNum", //当前页
                              @"10",@"pageSize",  //显示条数
                              @"11",@"type", nil];
        NSString *str = [KKTools dictionaryToJson:dict];  //类型
        [KKTools encryptionJsonString:str];
    })];
       
    
    [DongManager  CardBenefit:oldParam success:^(id requestData) {
        [self  hiddenHudLoadingView];
        
        //解析数据
        _model = [CardWelfareModel  decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            
//            [_table setModel:_model];
            
            [self.dataArray addObjectsFromArray:_model.list];
//            [_table setDataArray:self.dataArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_table.table reloadData];
            });
        }
        
    } fail:^(NSError *error) {
        [self  showNetFail];
    }];

}

- (CardWelfareTable *)table {
    if (!_table) {
        _table = [CardWelfareTable loadCode:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [self.view addSubview:_table];
    }
    return _table;
}


//定位
- (HomeLocation *)location {
    if (!_location) {
        _location = [HomeLocation sharedHomeLocation:^(NSString *city, NSString *address) {
            self.navigationItem.rightBarButtonItem = [HomeBtn initWithTitle:city icon:@"home_location"];
        } error:^{
            self.navigationItem.rightBarButtonItem = [HomeBtn initWithTitle:@"---" icon:@"home_location"];
        }];
    }
    return _location;
}


#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
