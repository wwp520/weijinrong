//
//  CreditCardController.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CreditCardController.h"
#import "CreditCollection.h"
#import "CreditCardModel.h"
#import "RunCardViewController.h"
#import "CardBenifitModel.h"
#import "BankLinkInfoModel.h"
#import "CarTypeModel.h"
#import "HomeBtn.h"
#import "CreditHeaderView.h"
#import "NewMyQrViewController.h"
#import "ShareCodeController.h"
#import "BankRewardModel.h"


#pragma mark 声明
@interface CreditCardController ()
@property (nonatomic, strong) CreditCollection *collection;
@property(nonatomic,strong)CreditCardModel * model;
@property(nonatomic,strong)CardBenifitModel * models;
@property(nonatomic,strong)BankLinkInfoModel * modell;
@property(nonatomic,strong)CarTypeModel * typemodel;
@property(nonatomic,strong)CreditHeaderView * headerView;
@end

#pragma mark 实现
@implementation CreditCardController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self collection];
    [self setNavTitle:@"信用卡"];
    HomeBtn *homeBtn = [HomeBtn initWithTitle:@"赚红包" icon:nil];
    UIButton *btn = (UIButton *)homeBtn.customView;
    self.navigationItem.rightBarButtonItem = homeBtn;
    [btn addTarget:self action:@selector(DrawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//推荐码
- (void)DrawBtnClick:(UIButton *)btn{
   
//    NewMyQrViewController *vc = [[NewMyQrViewController alloc] init];
////    vc.model = _model;
//    [self.navigationController pushViewController:vc animated:YES];
    
    ShareCodeController * shareVC = [[ShareCodeController alloc]init];
    [self.navigationController pushViewController:shareVC animated:YES];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getInfo];
}


//精卡推荐（推荐办卡）
- (void)getInfo {
    [self showHudLoadingView:@"正在获取。。。"];
    
    NSInteger cityId = [KKStaticParams sharedKKStaticParams].cityId;
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                            [SaveManager getStringForKey:@"mercId"],@"mercId",
                            @(cityId),@"bdcitycode",
                            @"11",@"type", nil]];  //类型
        [KKTools encryptionJsonString:str];
    })];
    
    [DongManager CardRecommend:oldParam success:^(id requestData) {
        //解析数据
        _models = [CardBenifitModel decryptBecomeModel:requestData];
        if (_models.retCode == 0) {
            [_collection setModels:_models];
        }
        // 请登录
        else if (_models.retCode == 2) {
            // 跳转登录页面
            [self pushLoginVc:^{
                // 登陆成功
                [self getInfo];
            }close:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else {
            [self showTitle:_models.retMessage delay:1.5f];
        }
        
        [self getBankInfo];
    } fail:^(NSError *error) {
        [self getBankInfo];
    }];
}

//银行信息(银行链接)
- (void)getBankInfo {
   
    [DongManager BankLinkInfo:nil success:^(id requestData) {
        [self DownLoadData];
        // 解析数据
        _modell = [BankLinkInfoModel decryptBecomeModel:requestData];
        if (_modell.retCode == 0) {
            [_collection setModell:_modell];
        }else {
            [self showTitle:_modell.retMessage delay:1.5f];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collection.collection reloadData];
        });
    } fail:^(NSError *error) {
        [self DownLoadData];
    }];
}

//卡惠精选
- (void)DownLoadData {
//    [self  showHudLoadingView:@"正在获取。。。"];
    
    CGFloat  lat = [KKStaticParams sharedKKStaticParams].lat;
    CGFloat  lot = [KKStaticParams sharedKKStaticParams].lot;
    NSInteger cityId = [KKStaticParams sharedKKStaticParams].cityId;
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                        [SaveManager  getStringForKey:@"mercId"],@"mercId",@(cityId),@"bdcitycode",
                            @(lot),@"bdlng",   //经度
                            @(lat) ,@"bdlat",   //纬度
                            @"11",@"type", nil]];  //类型
        [KKTools encryptionJsonString:str];
    })];
    
    [DongManager  CardBenefitSelect:oldParam success:^(id requestData) {
        [self  getCarTypeInfo];
        //解析数据
        _model = [CreditCardModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            [_collection setModel:_model];
            NSLog(@"%@",requestData);
        }
    } fail:^(NSError *error) {
//        [self  showNetFail];
        [self  getCarTypeInfo];
    }];
}

//车主卡
- (void)getCarTypeInfo{
    
    [DongManager CarCardType:nil success:^(id requestData) {
        [self getHeaderInfo];
        _typemodel = [CarTypeModel decryptBecomeModel:requestData];
        if (_typemodel.retCode == 0) {
            [_collection setTypemodel:_typemodel];
            NSLog(@"&&&&&&&&&&车主卡接口请求成功&&&&&&&&&&&&");
        }else{
            [self showTitle:_typemodel.retMessage delay:1];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collection.collection reloadData];
        });
    } fail:^(NSError *error) {
        [self getHeaderInfo];
    }];
}


//头视图余额查询
- (void)getHeaderInfo {
    [DongManager BankCardReward:nil success:^(id requestData) {
        [self hiddenHudLoadingView];
        BankRewardModel *model = [BankRewardModel decryptBecomeModel:requestData];
        if (model.retCode == 0) {
            _collection.amount = [NSString stringWithFormat:@"%@元",model.amount];
            _collection.sumAmount = [NSString stringWithFormat:@"累计奖励+%@元",model.sumAmount];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_collection.collection reloadData];
            });
        } else {
            [self showTitle:_model.retMessage delay:1];
        }
        
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}


- (CreditCollection *)collection {
    if (!_collection) {
        _collection = [CreditCollection initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
        [self.view addSubview:_collection];
    }
    return _collection;
}

- (void)setAmount:(NSString *)amount{
    _amount = amount;
}

- (void)setSumAmount:(NSString *)sumAmount{
    _sumAmount = sumAmount;
}


@end
