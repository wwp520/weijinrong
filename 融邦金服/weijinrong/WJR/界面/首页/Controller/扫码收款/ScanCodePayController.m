//
//  ScanCodePayController.m
//  weijinrong
//
//  Created by ouda on 17/6/12.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "ScanCodePayController.h"
#import "ScanCodePayHeadView.h"
#import "WithdrawalController.h"
#import "NewAttestationController.h"
#import "TransDetailsController.h"
#import "WithdrawalSuccController.h"
#import "NewGetCashController.h"
#import "ScanDrawMoneyModel.h"
#import "HomeBtn.h"
#import "ScanCodeView.h"
#import "ScanCodeTool.h"
#import "NewScanKeyController.h"

@interface ScanCodePayController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) ScanCodePayHeadView * headView;
@property (nonatomic, strong) NSArray * titleArray;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) ScanDrawMoneyModel * model;
@property (nonatomic, strong) ScanCodeView * erview;
@end

@implementation ScanCodePayController

- (ScanCodeView *)erview{
    if (!_erview) {
        _erview = [[NSBundle mainBundle]loadNibNamed:@"ScanCodeView" owner:nil options:nil].lastObject;
        _erview.icon.image = [ScanCodeTool getImageWithtitle:QRURL];
        
        CGFloat width = ScreenWidth;
        CGFloat height = width * 532/400.f;
        _erview.frame = CGRectMake(0, 0, width, height);
        [self.view  addSubview:_erview];
        _erview.click = ^(){
            // 长按
            
        };
    }
    return _erview;
}

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"余额提现",@"实名认证",@"交易明细",@"绑定银行卡",@"我的收款码"];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeBtn *homeBtn = [HomeBtn initWithTitle:@"提现" icon:nil];
    UIButton *btn = (UIButton *)homeBtn.customView;
    self.navigationItem.rightBarButtonItem = homeBtn;
    [btn addTarget:self action:@selector(DrawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navTitle = @"扫码支付";
    //    [self  showTitle:@"" delay:<#(CGFloat)#>];
    [self tableView];
    [self erview];
    [self getInfo];
    //  QRURL
}

// 提现
- (void)DrawBtnClick:(UIButton *)btn{
    WithdrawalController  * wdVC = [[WithdrawalController  alloc]init];
    [self.navigationController pushViewController:wdVC animated:YES];
}

- (void)getInfo{
    [DongManager ScanDrawMoney:nil success:^(id requestData) {
        _model = [ScanDrawMoneyModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            NSLog(@"*******获取余额********");
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_model.amount) {
                    _headView.amount.text = [NSString stringWithFormat:@"%@元",_model.amount];
                }else{
                    _headView.amount.text = @"0.00元";
                }
            });
        }else{
            [self showTitle:_model.retMessage delay:1.f];
        }
        
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}


#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {//余额提现
        //        WithdrawalController  * wdVC = [[WithdrawalController  alloc]init];
        //        [self.navigationController pushViewController:wdVC animated:YES];
        NewGetCashController * newVC = [[NewGetCashController alloc]init];
        [self.navigationController pushViewController:newVC animated:YES];
    }
    if (indexPath.row == 1) { //实名认证
        // 实名认证
        NewAttestationController * newVC = [[NewAttestationController alloc]init];
        [self.navigationController pushViewController:newVC animated:YES];
    }
    if (indexPath.row == 2) { //交易明细
        TransDetailsController * transVC = [[TransDetailsController alloc]init];
        [self.navigationController pushViewController:transVC animated:YES];
    }
    if (indexPath.row == 3) { //绑定银行卡
        
    }
    if (indexPath.row == 4) { //我的收款码
        //        WithdrawalSuccController *successVC = [[WithdrawalSuccController alloc]init];
        //        successVC.merchatName = @"王卫平";
        //        successVC.payAmount = @"100";      //金额
        //        successVC.tradingHours = ({        //时间
        //            NSDate *date = [NSDate date];
        //            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        //            formatter.dateFormat = @"yyyy-MM-dd:HH:mm:ss";
        //            [formatter stringFromDate:date];
        //        });
        //        successVC.orderNumber = @"wwp1234567890";
        ////        if (_model.orderNumber != nil) {
        ////        }
        //        [self.navigationController pushViewController:successVC animated:YES];
    }
}

#pragma mark--懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [_tableView setLineHide];
        [_tableView setLineAll];
        _headView = [[NSBundle mainBundle]loadNibNamed:@"ScanCodePayHeadView" owner:nil options:nil].firstObject;
        _headView.frame = CGRectMake(0, 0, ScreenWidth, 130);
        _tableView.tableHeaderView = _headView;
        _tableView.tableFooterView = [self erview];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
