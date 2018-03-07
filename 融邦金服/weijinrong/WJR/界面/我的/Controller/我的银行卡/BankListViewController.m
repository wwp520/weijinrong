//
//  BankListViewController.m
//  chengzizhifu
//
//  Created by 快易 on 15/1/26.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "BankListViewController.h"
#import "BankListModel.h"
#import "Unity.h"

@interface BankListViewController ()<UITableViewDataSource,UITableViewDelegate> {
    NSInteger curPage;//当前页
    NSInteger totalPages;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, strong) BankListModel *model;
@end

@implementation BankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self createArray];
    totalPages=10;
    curPage=1;
    [self createTableView];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setupRefresh];
    [self getInfo:curPage totalPages:totalPages];
    // Do any additional setup after loading the view.
}
- (void)createNavigation{
    [self setNavTitle:@"银行列表"];
}
- (void)createArray{
    self.dataArray=[NSMutableArray array];
}

- (void)setupRefresh {
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerLoading)];
}
//进入刷新状态
- (void)headerRefreshing{
    curPage=1;
    [self.dataArray removeAllObjects];
    [self getInfo:1 totalPages:10];
    [_tableView.mj_header endRefreshing];
}
//进入加载状态
- (void)footerLoading{
    curPage ++;
    [self getInfo:curPage totalPages:totalPages];
    [_tableView.mj_footer endRefreshing];
}
- (void)createTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cell";
    UITableViewCell * cell= [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [Unity imageviewAddsuperview_superView:cell.contentView _subViewFrame:CGRectMake(ScreenWidth-[Unity countcoordinatesX:40/2]-[Unity countcoordinatesX:16/2], 60/2-[Unity countcoordinatesY:27/2]/2,[Unity countcoordinatesX:16/2],[Unity countcoordinatesY:27/2]) _imageName:@"arrow_right.png" _backgroundColor:[UIColor clearColor]];
    }
    if (self.dataArray.count!=0) {
        BankListInfoModel * model=self.dataArray[indexPath.row];
        cell.textLabel.text=model.bankname;
        cell.textLabel.font=[UIFont systemFontOfSize:15];
    }
    
    return cell;
}

//银行列表
- (void)getInfo:(NSInteger)page totalPages:(NSInteger)pages{
    [self showHudLoadingView:@"正在等待"];
    NSDictionary *params=[[NSDictionary alloc]initWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%ld",(long)page],@"pageNum",
                          [NSString stringWithFormat:@"%ld",(long)pages],@"pageSize", nil];
    
    
    [DongManager bankList:params success:^(id requestData) {
        [self hiddenHudLoadingView];
        _model = [BankListModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            [self.dataArray addObjectsFromArray:_model.list];
            [_tableView reloadData];
            NSLog(@"*****************************");
        }else {
            [self showTitle:_model.retMessage delay:1];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BankListInfoModel * model=self.dataArray[indexPath.row];
    self.changeBlock(model.bankname,model.bankid);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
