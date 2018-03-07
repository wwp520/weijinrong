//
//  RunCardViewController.m
//  weijinrong
//
//  Created by ouda on 17/5/19.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "RunCardViewController.h"
#import "RunCardCell.h"
#import "LoadInfoViewController.h"
#import "RunCardModel.h"
#import "RunCardView.h"

@interface RunCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView * views;
@property(nonatomic,strong)RunCardModel * model;
@property(nonatomic,strong)RunCardView * cardView;
@end

@implementation RunCardViewController

- (RunCardView *)cardView{
    if (!_cardView) {
        _cardView = [[RunCardView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-130)];
        _cardView.backgroundColor = [UIColor whiteColor];
    }
    return _cardView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"进度查询";
    [self  imageView];
    [self  tableView];
    [self views];
    [self  getInfo];
}

//查询所有信用卡
-(void)getInfo{
    [self  showHudLoadingView:@"正在获取。。。"];
    
    [DongManager  LookForCard:nil success:^(id requestData) {
        [self  hiddenHudLoadingView];
        
        _model = [RunCardModel decryptBecomeModel:requestData];
        //解析数据
        if (_model.retCode == 0) {
            if (_model.list.count != 0) {
                _tableView.tableFooterView = [UIView new];
            }else {
                _tableView.tableFooterView = [self cardView];
            }
            [_tableView reloadData];
            NSLog(@"%@",requestData);
        }
        
        
    } fail:^(NSError *error) {
        [self  showNetFail];
    }];

}


#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RunCardCell * cell = [RunCardCell  loadWithTable:tableView ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.logo sd_setImageWithURL:[NSURL  URLWithString:self.model.list[indexPath.row].logo]];
    cell.bankName.text = _model.list[indexPath.row].bankName;
    cell.credate.text = _model.list[indexPath.row].credate;
    cell.status1.text = _model.list[indexPath.row].status1;
    

    if ([_model.list[indexPath.row].status1  isEqual:@"上传信息"]) {  //申请中
//        [cell.status  setImage:[UIImage  imageNamed:@"资源 54.png"]];
    }
    if ([_model.list[indexPath.row].status1  isEqual:@"审核失败"]) { //未通过
//        [cell.status  setImage:[UIImage  imageNamed:@"资源 55.png"]];
    }
    if ([_model.list[indexPath.row].status1  isEqual:@"查看奖励"]) { //已发放
//        [cell.status  setImage:[UIImage  imageNamed:@"资源 53.png"]];
    }
    if ([_model.list[indexPath.row].status1  isEqual:@"正在审核"]) {//审核中
//        [cell.status  setImage:[UIImage  imageNamed:@"资源 52.png"]];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_model.list[indexPath.row].status1  isEqual:@"查看奖励"]) { //已发放
       //跳转至   我的-》交易查询（即云商平台的交易查询）
        
    }
}


#pragma mark--懒加载
-(UIView *)views{
    if (!_views) {
        _views = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), ScreenWidth, 10)];
        _views.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view  addSubview:_views];
    }
    return _views;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame)+10, ScreenWidth, ScreenHeight-130);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setLineHide];
        [_tableView setTableFooterView:[self cardView]];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView  alloc]init];
        _imageView.frame = CGRectMake(0, 0, ScreenWidth, 130);
        _imageView.backgroundColor = [UIColor redColor];
        _imageView.image = [UIImage imageNamed:@"进度查询banner2"];
        [self.view addSubview:_imageView];
    }
    return _imageView;
}
@end
