//
//  ReceiptViewController.m
//  chengzizhifu
//
//  Created by RY on 17/1/6.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "ReceiptViewController.h"
#import "TransDayModel.h"
#import "AFNManager.h"
#import "TransDayDetailModel.h"
#import "Unity.h"

#pragma mark 声明
@interface ReceiptViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *type;
// 交易状态
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tradeL;
@end

#pragma mark 实现
@implementation ReceiptViewController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    if (_model != nil) {
        _money.text  = [NSString stringWithFormat:@"收入: %.2f元",[_model.money floatValue]];
        _number.text = _model.orderNum;
        _date.text = _model.dealTime;
        if (_typeM == 0) {
            _type.text = @"微信收款";
            _icon.image = [UIImage imageNamed:@"newPay_wei"];
        }else {
            _type.text = @"支付宝收款";
            _icon.image = [UIImage imageNamed:@"newPay_alipy"];
        }
    }else if (_dict != nil) {
        _money.text  = [NSString stringWithFormat:@"收入: %.2f元",[_dict[@"money"] floatValue]];
        _number.text = _dict[@"orderNum"];
        _date.text   = _dict[@"dealTime"];
        if ([_dict[@"paymentType"] isEqualToString:@"1"]) {
            _type.text = @"微信收款";
            _icon.image = [UIImage imageNamed:@"newPay_wei"];
        }else {
            _type.text = @"支付宝收款";
            _icon.image = [UIImage imageNamed:@"newPay_alipy"];
        }
    }
    
    [self set_networking];
}
- (void)createUI {
    [self setNavTitle:@"收款详情"];
    if (ScreenWidth == 320) {
        _tradeL.constant = 50;
    }
}
- (void)leftBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 网络
- (void)set_networking {
    __weak ReceiptViewController *weak = self;
    [self showTitle:@"正在获取" delay:2];
    
    
    
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           _number.text,@"orderNum",
                           [SaveManager getStringForKey:@"mercId"],@"mercId", nil];
    [DongManager moneySomeDay:param success:^(id requestData) {
        [self hiddenHudLoadingView];
        // 解析
        TransDayModel *model = [TransDayModel decryptBecomeModel:requestData];
        if (model.retCode == 0) {
            _state.text = model.status;
        }else {
            [self showTitle:model.retMessage delay:1];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}



@end
