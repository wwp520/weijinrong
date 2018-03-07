//
//  文件名: IntegralController.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/6
//

#import "IntegralController.h"
#import "IntegralListTable.h"
#import "IntegralShop.h"
#import "IntegralModel.h"
#import "IntegralShopModel.h"
#import "HomeLocation.h"


#pragma mark - 声明
@interface IntegralController(){
   NSInteger curPage;
}
@property (nonatomic, strong) IntegralListTable *table;
@property (nonatomic, strong) IntegralShop *shop;
@property(nonatomic,strong)IntegralModel * model;
@property(nonatomic,strong)IntegralShopModel * models;
@property(nonatomic,strong)NSMutableArray<IntegralListModel *> * dataArray;
@end

#pragma mark - 实现
@implementation IntegralController

-(NSMutableArray<IntegralListModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     curPage = 1;
    [self setNavTitle:@"积分"];
    [self table];
//    [self shop];
    [self  getInfo:curPage];
//    [self  downLoadData];
    [self setupRefresh];
}


//积分(通)
-(void)getInfo:(NSInteger)page{
    [self  showHudLoadingView:@"正在获取。。。"];
    
    NSInteger cityId = [KKStaticParams sharedKKStaticParams].cityId;
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [SaveManager  getStringForKey:@"mercId"],@"mercId",
//                                                   @(cityId),@"bdcitycode",
                                          @(page),@"pageNum", //当前页
                                         @"10",@"pageSize",  //显示条数
                                        @"10",@"type", nil]];  //类型
        [KKTools encryptionJsonString:str];
    })];
   
    [DongManager  Integral:oldParam success:^(id requestData) {
        [self  hiddenHudLoadingView];
        
        //解析数据
        _model = [IntegralModel  decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            
            [_table  setModel:_model];
            [self.dataArray addObjectsFromArray:_model.list];
            [_table setDataArray:self.dataArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_table.table reloadData];
            });

        }
        
    } fail:^(NSError *error) {
        [self  showNetFail];
    }];

}


//刷新
- (void)setupRefresh {
    _table.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    _table.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerLoading)];
}
//进入刷新状态
- (void)headerRefreshing{
    curPage = 1;
    [self.dataArray removeAllObjects];
    [self getInfo:curPage];
    [_table.table.mj_header endRefreshing];
}
//进入加载状态
- (void)footerLoading{
    curPage ++;
    [self getInfo:curPage];
    [_table.table.mj_footer endRefreshing];
}





//下方卡logo
-(void)downLoadData{
//    [self  showHudLoadingView:@"正在获取。。。"];
    
    NSInteger cityId = [KKStaticParams sharedKKStaticParams].cityId;

    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [SaveManager  getStringForKey:@"mercId"],@"mercId",@(cityId),@"bdcitycode",
                                                   @"10",@"type", nil]];  //类型
        [KKTools encryptionJsonString:str];
    })];
       
    
    [DongManager  Logo:oldParam success:^(id requestData) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            
            [self  hiddenHudLoadingView];
        });
        //解析数据
        _models = [IntegralShopModel  decryptBecomeModel:requestData];
        if (_models.retCode == 0) {
           [_shop  setModel:_models];
        }
    } fail:^(NSError *error) {
        [self  showNetFail];
    }];

    
}


- (IntegralListTable *)table {
    if (!_table) {
        _table = [IntegralListTable loadCode:CGRectMake(0, 0 , ScreenWidth, ScreenHeight )];
        [self.view addSubview:_table];
    }
    return _table;
}
- (IntegralShop *)shop {
    if (!_shop) {
        _shop = [IntegralShop loadCode:({
            CGFloat y = CGRectGetMaxY(self.table.frame);
            CGRectMake(0, y, ScreenWidth, ScreenWidth / 2.5 + 50);
        })];
        _shop.alpha = 0;
        [self.view addSubview:_shop];
    }
    return _shop;
}

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
