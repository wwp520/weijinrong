//
//  ShareCodeController.m
//  weijinrong
//
//  Created by ouda on 17/5/23.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "ShareCodeController.h"
#import "MakeCodeController.h"
#import "ShareCodeListModel.h"

@interface ShareCodeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIButton * makeCode;
@property(nonatomic,strong)UIButton * AddBtn;
@property(nonatomic,strong)UIView * footerView;
@property(nonatomic,strong)UIView * line;
@property (nonatomic, strong) ShareCodeListModel *model;
@property(nonatomic,strong)UIImageView * imageView;
@end

@implementation ShareCodeController

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(10, 0,ScreenWidth-20 , 1)];
        _line.backgroundColor = [UIColor lightGrayColor];
        _line.alpha = 0.6;
    }
    return _line;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"我的推荐码"];
    [self tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getList];
}

//分享二维码列表
- (void)getList {
    [self showHudLoadingView:@"正在获取信息"];
    NSString *oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [SaveManager getStringForKey:@"mercId"],@"mercId", nil]];  //类型
        [KKTools encryptionJsonString:str];
    })];
   
    [DongManager shareQRList:oldParam success:^(id requestData) {
        [self hiddenHudLoadingView];
        
        _model = [ShareCodeListModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
        
    } fail:^(NSError *error) {
        [self  showNetFail];
    }];
}


- (void)delete:(ShareCodeListSubModel *)model {
    
    [self showHudLoadingView:@"正在删除比例"];
    NSString *oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [SaveManager getStringForKey:@"mercId"],@"mercId",
                                                   model.Id,@"id",nil]];
        [KKTools encryptionJsonString:str];
    })];
    
    [DongManager DeleteQRAdd:oldParam success:^(id requestData) {
        [self hiddenHudLoadingView];
        BaseModel *model = [BaseModel decryptBecomeModel:requestData];
        if (model.retCode == 0) {
            [self showTitle:model.retMessage delay:1];
            [self getList];
        }else {
            [self showTitle:model.retMessage delay:1];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}

- (void)addProfit:(UIButton *)btn {
    MakeCodeController * VC = [[MakeCodeController alloc]init];
    [self.navigationController  pushViewController:VC animated:YES];
}


// 生成二维码
- (void)btnClick:(UIButton *)btn {
    
}

#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _model.list[indexPath.row].profit;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MakeCodeController * VC = [[MakeCodeController alloc]init];
    VC.model = _model.list[indexPath.row];
    [self.navigationController  pushViewController:VC animated:YES];
}

#pragma mark--侧滑删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ShareCodeListSubModel *model = _model.list[indexPath.row];
        //请求接口
        [self delete:model];
    }
}

#pragma mark--懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setTableFooterView:self.footerView];
        [_tableView setLineAll];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame)+20, ScreenWidth, 60)];
        _footerView.backgroundColor = [UIColor  whiteColor];
        [_footerView addSubview:[self makeCode]];
        [_footerView addSubview:[self imageView]];
        [_footerView addSubview:[self line]];
    }
    return _footerView;
}
- (UIButton *)makeCode {
    if (!_makeCode) {
        _makeCode = [[UIButton  alloc]initWithFrame:CGRectMake(20, 25, ScreenWidth-40, 50)];
        [_makeCode  setTitle:@"生成二维码" forState:UIControlStateNormal];
        [_makeCode setTitleColor:[UIColor  redColor] forState:UIControlStateNormal];
        _makeCode.backgroundColor = [UIColor whiteColor];
        _makeCode.layer.masksToBounds = YES;
        [_makeCode addTarget:self action:@selector(addProfit:) forControlEvents:UIControlEventTouchUpInside];
        _makeCode.layer.cornerRadius = 5;
        _makeCode.layer.borderColor = [UIColor  redColor].CGColor;
        _makeCode.layer.borderWidth = 1;
    }
    return _makeCode;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_makeCode.frame)+50, ScreenWidth-20, 130)];
        _imageView.image = [UIImage imageNamed:@"赚红包说明"];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

@end
