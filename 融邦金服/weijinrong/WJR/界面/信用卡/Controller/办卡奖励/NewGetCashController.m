//
//  NewGetCashController.m
//  weijinrong
//
//  Created by ouda on 17/6/13.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "NewGetCashController.h"
#import "GetCashModel.h"
#import "WithdrawalSuccController.h"

@interface NewGetCashController ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLb;
@property (weak, nonatomic) IBOutlet UITextField *passTF;
@property(nonatomic,strong)GetCashModel * model;

@end

@implementation NewGetCashController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"提款";
    _moneyLb.text = [NSString stringWithFormat:@"%@",_money];
}

- (void)setRewardmodel:(RewardBankListModel *)rewardmodel{
    _rewardmodel = rewardmodel;
}


//确认付款
- (IBAction)SureGetCashBtn:(id)sender {
    [self showHudLoadingView:@"正在获取..."];
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [SaveManager  getStringForKey:@"mercId"],@"mercId",
                                                   _moneyLb.text,@"balance",  ////金额
                                                   _passTF.text,@"password",  //密码
                                                   nil]];
        [KKTools encryptionJsonString:str];
    })];
    
    [DongManager  CreditGetCash:oldParam success:^(id requestData) {
        _model = [GetCashModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            [self showTitle:_model.retMessage delay:1];
            NSLog(@"^^^^^^^^^^^^^^^^^提款成功^^^^^^^^^^^^^^");
            WithdrawalSuccController *success = [[WithdrawalSuccController alloc]init];
            success.merchatName = _rewardmodel.settlementname;     //用户名
            success.payAmount = _moneyLb.text;      //金额
            success.tradingHours = ({        //时间
                NSDate *date = [NSDate date];
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                formatter.dateFormat = @"yyyy-MM-dd:HH:mm:ss";
                [formatter stringFromDate:date];
            });
            if (_model.orderNumber != nil) {
                success.orderNumber = _model.orderNumber;
            }
            [self.navigationController pushViewController:success animated:YES];
        }else{
           [self showTitle:_model.retMessage delay:1];  
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hiddenHudLoadingView];
        });

    } fail:^(NSError *error) {
        [self showNetFail];
    }];
    
}

- (void)setMoney:(NSString *)money{
    _money = money;
}

@end
