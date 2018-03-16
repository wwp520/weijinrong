//
//  AdvisoryController.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "AdvisoryController.h"
#import "AdvisoryNavBar.h"
#import "AdvisoryScroll.h"
#import "AdvisoryTable.h"
#import "AdvisoryPlan.h"
#import "HomeLocation.h"
#import "HomeBtn.h"
#import "CardWelfareModel.h"
#import "CardWelfareTable.h"
#import "AllBankinfoModel.h"
#import "AdvisoryPlan.h"
#import "CardWelfareModel.h"


#pragma mark 声明
@interface AdvisoryController (){
    NSInteger curPage1;
    NSInteger curPage2;
    NSInteger curPage3;
}
@property (nonatomic, strong) AdvisoryNavBar *navBar;
@property (nonatomic, strong) AdvisoryScroll *scroll;
@property (nonatomic, strong) AdvisoryTable *table1;
@property (nonatomic, strong) AdvisoryTable *table2;
@property (nonatomic, strong) AdvisoryTable *table3;
@property (nonatomic, strong) AdvisoryPlan *plan;      //
@property (nonatomic, strong) CardWelfareTable *table;  
@property (nonatomic, strong) HomeLocation *location;
@property (nonatomic, strong) AllBankinfoModel *bankmodel;
@property (nonatomic, strong) NSMutableArray<CardWelfareListModel *> * dataArray;
@property (nonatomic, strong) NSMutableArray<CardWelfareListModel *> * dataArray2;
@property (nonatomic, strong) NSMutableArray<CardWelfareListModel *> * dataArray3;
@property (nonatomic, strong) NetFailView *netfail;
@end

#pragma mark 实现
@implementation AdvisoryController


- (NSMutableArray<CardWelfareListModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (NSMutableArray<CardWelfareListModel *> *)dataArray2{
    if (!_dataArray2) {
        _dataArray2 = [[NSMutableArray alloc]init];
    }
    return _dataArray2;
}

- (NSMutableArray<CardWelfareListModel *> *)dataArray3{
    if (!_dataArray3) {
        _dataArray3 = [[NSMutableArray alloc]init];
    }
    return _dataArray3;
}

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    curPage1 = 1;
    curPage2 = 1;
    curPage3 = 1;
    [self.navigationItem setTitleView:[self navBar]];
    [self scroll];
    [self table1];
    [self table2];
    [self table3];
    [self setupRefresh1];
    [self setupRefresh2];
    [self setupRefresh3];
}

/********************************************************/
#pragma mark--刷新
- (void)setupRefresh1 {
    _table1.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing1)];
    _table1.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerLoading1)];
}

//进入刷新状态
- (void)headerRefreshing1{
    curPage1=1;
    [self.dataArray removeAllObjects];
    [self getTEInfo:curPage1];
    [_table1.mj_header endRefreshing];
}
//进入加载状态
- (void)footerLoading1{
    curPage1 ++;
    [self getTEInfo:curPage1];
    [_table1.mj_footer endRefreshing];
}


//刷新
- (void)setupRefresh2 {
    _table2.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing2)];
    _table2.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerLoading2)];
}
//进入刷新状态
- (void)headerRefreshing2{
    curPage2=1;
    [self.dataArray2 removeAllObjects];
    [self getLCInfo:curPage2];
    [_table2.mj_header endRefreshing];
}
//进入加载状态
- (void)footerLoading2{
    curPage2 ++;
    [self getLCInfo:curPage2];
    [_table2.mj_footer endRefreshing];
}


//刷新
- (void)setupRefresh3 {
    _table3.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing3)];
    _table3.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerLoading3)];
}

//进入刷新状态
- (void)headerRefreshing3 {
    curPage3=1;
    [self.dataArray3 removeAllObjects];
    [self getTKInfo:curPage3];
    [_table3.mj_header endRefreshing];
}

//进入加载状态
- (void)footerLoading3 {
    curPage3 ++;
    [self getTKInfo:curPage3];
    [_table3.mj_footer endRefreshing];
}

/*****************************************************************/
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    static int i = 0;
    if (i == 0) {
        i = 1;
        [self getTEInfo:curPage1];
    }
}

//无用注掉
- (void)getDownLoad {
    [DongManager AllBankInfo:nil success:^(id requestData) {
        [self hiddenHudLoadingView];
        _bankmodel = [AllBankinfoModel decryptBecomeModel:requestData];
        if (_bankmodel.retCode == 0) {
            [_plan setModel:_bankmodel];
        }else{
            [self showTitle:_bankmodel.retMessage delay:1.f];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}


- (void)getTKInfo:(NSInteger)page{
    [self  showHudLoadingView:@"正在获取。。。"];
    
    CGFloat  lat = [KKStaticParams sharedKKStaticParams].lat;
    CGFloat  lot = [KKStaticParams sharedKKStaticParams].lot;
//    NSInteger cityId = [KKStaticParams sharedKKStaticParams].cityId;
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   @(lot),@"bdlng",   //经度
                                                   @(lat) ,@"bdlat",   //纬度
                                                   @(page),@"pageNum", //当前页
                                                   @"10",@"pageSize",  //显示条数
                                                   @"03",@"type", nil]];  //类型
        [KKTools encryptionJsonString:str];
    })];
    
    
    [DongManager  CardBenefit:oldParam success:^(id requestData) {
        [self  hiddenHudLoadingView];
        
        //解析数据
        CardWelfareModel *model = [CardWelfareModel  decryptBecomeModel:requestData];
        if (model.retCode == 0) {
            
            [self.dataArray3 addObjectsFromArray:model.list];
            [_table3 setDataArray:self.dataArray3];
            
        }else {
            [self showTitle:model.retMessage delay:1.5f];
        }
        
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
    
}

- (void)getLCInfo:(NSInteger)page{
    [self showHudLoadingView:@"正在获取。。。"];
    
    CGFloat  lat = [KKStaticParams sharedKKStaticParams].lat;
    CGFloat  lot = [KKStaticParams sharedKKStaticParams].lot;
//    NSInteger cityId = [KKStaticParams sharedKKStaticParams].cityId;
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   @(lot),@"bdlng",   //经度
                                                   @(lat) ,@"bdlat",   //纬度
                                                   @(page),@"pageNum", //当前页
                                                   @"10",@"pageSize",  //显示条数
                                                   @"02",@"type", nil]];  //类型
        [KKTools encryptionJsonString:str];
    })];
    
    
    [DongManager  CardBenefit:oldParam success:^(id requestData) {
        [self hiddenHudLoadingView];
        //解析数据
        CardWelfareModel *model = [CardWelfareModel  decryptBecomeModel:requestData];
        if (model.retCode == 0) {
            [self.dataArray2 addObjectsFromArray:model.list];
            [_table2 setDataArray:self.dataArray2];
            
        }else {
            [self showTitle:model.retMessage delay:1.5f];
        }
        
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
    
}

- (void)getTEInfo:(NSInteger)page{
    
    [self  showHudLoadingView:@"正在获取。。。"];
    
    CGFloat  lat = [KKStaticParams sharedKKStaticParams].lat;
    CGFloat  lot = [KKStaticParams sharedKKStaticParams].lot;
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   @(page),@"pageNum", //当前页
                                                   @"10",@"pageSize",  //显示条数
                                                   @"01",@"type",
                                                   @(lot),@"bdlng",   //经度
                                                   @(lat) ,@"bdlat",   //纬度
                                                   nil]];  //类型
        [KKTools encryptionJsonString:str];
    })];
    
    
    [DongManager CardBenefit:oldParam success:^(id requestData) {
        [self hiddenHudLoadingView];
        //解析数据
        CardWelfareModel *model = [CardWelfareModel  decryptBecomeModel:requestData];
        
        if (model.retCode == 0) {
            [self.dataArray addObjectsFromArray:model.list];
            [_table1 setDataArray:self.dataArray];
        }else {
            [self showTitle:model.retMessage delay:1.5f];
        }
        
    } fail:^(NSError *error) {
//        [self getDownLoad];
        [self showNetFail];
    }];
    
}

- (AdvisoryNavBar *)navBar {  
    if (!_navBar) {
        _navBar = [AdvisoryNavBar initWithFrame:CGRectMake(0, 0, ScreenWidth, 44) click:^(NSInteger i) {
            [_scroll setContentOffset:CGPointMake(ScreenWidth * (i - 1), 0) animated:YES];
            if (i == 1) {
                if (self.dataArray.count == 0) {
                    [self headerRefreshing1];
                }
            }else if (i == 2) {
                if (self.dataArray2.count == 0) {
                    [self headerRefreshing2];
                }
            }else if (i == 3) {
                if (self.dataArray3.count == 0) {
                    [self headerRefreshing3];
                }
            }
        }];
    }
    return _navBar;
}


- (AdvisoryScroll *)scroll {
    if (!_scroll) {
        _scroll = [AdvisoryScroll initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) click:^(NSInteger i) {
            [_navBar changeClick1:i];
            if (i == 0) {
                if (self.dataArray.count == 0) {
                    [self headerRefreshing1];
                }
            }else if (i == 1) {
                if (self.dataArray2.count == 0) {
                    [self headerRefreshing2];
                }
            }else if (i == 2) {
                if (self.dataArray3.count == 0) {
                    [self headerRefreshing3];
                }
            }
        }];
        [_scroll setContentSize:CGSizeMake(ScreenWidth * 3, ScreenHeight - 64 - 49)];
        [_scroll setPagingEnabled:YES];
        _scroll.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scroll];
    }
    return _scroll;
}

- (AdvisoryTable *)table1 {
    if (!_table1) {
        _table1 = [AdvisoryTable initWithFrame:CGRectMake(0, 0, ScreenWidth, self.scroll.height)];
        [self.scroll addSubview:_table1];
    }
    return _table1;
}
- (AdvisoryTable *)table2 {
    if (!_table2) {
        _table2 = [AdvisoryTable initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, self.scroll.height)];
        [self.scroll addSubview:_table2];
    }
    return _table2;
}
- (AdvisoryTable *)table3 {
    if (!_table3) {
        _table3 = [AdvisoryTable initWithFrame:CGRectMake(ScreenWidth * 2, 0, ScreenWidth, self.scroll.height)];
        [self.scroll addSubview:_table3];
    }
    return _table2;
}


//提额通道已废弃
- (AdvisoryPlan *)plan {
    if (!_plan) {
        _plan = [AdvisoryPlan loadFromFrame:CGRectMake(0, CGRectGetMaxY(_table1.frame), ScreenWidth, self.scroll.height - self.table1.height) click:^(NSInteger i) {
            
        }];
        _plan.height = 40 + 4 * 3 + (ScreenWidth - 9) / 2;
        _table1.height = self.scroll.height - _plan.height;
        _plan.y = CGRectGetMaxY(_table1.frame);
        _plan.alpha = 0;
        [self.scroll addSubview:_plan];
    }
    return _plan;
}

@end

