//
//  WithdrawalView.m
//  chengzizhifu
//
//  Created by RY on 17/1/5.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "WithdrawalView.h"
#import "WithdrawalPassController.h"
#import "BankModel.h"

#pragma mark 声明
@interface WithdrawalView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *name;//姓名
@property (weak, nonatomic) IBOutlet UILabel *number;//尾号
@property (weak, nonatomic) IBOutlet UILabel *bank;//银行
@property (weak, nonatomic) IBOutlet UITextField *getMoney;//提款金额
@property (weak, nonatomic) IBOutlet UILabel *moneyCount;//提款次数
@property (weak, nonatomic) IBOutlet UILabel *guolu;//手续费
@end

#pragma mark 实现
@implementation WithdrawalView

#pragma mark 初始化
+ (instancetype)initWithFrame:(CGRect)frame {
    WithdrawalView *view = [[NSBundle mainBundle] loadNibNamed:@"WithdrawalView" owner:nil options:nil].firstObject;
    view.frame = frame;
    view.getMoney.leftViewMode = UITextFieldViewModeAlways;
    view.getMoney.leftView = ({
        UIView *view = [[NSBundle mainBundle] loadNibNamed:@"WithdrawalView" owner:nil options:nil].lastObject;
        view;
    });
    return view;
}

- (void)setModel:(BankModel *)model {
    _model = model;
    dispatch_async(dispatch_get_main_queue(), ^{
        _bank.text = model.bank;
        _number.text = model.tail;
        _name.text = model.name;
    });
}


#pragma mark 按钮点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
- (IBAction)nextClick:(UIButton *)sender {
    BaseViewController *vc = (BaseViewController *)self.viewController;
    if (_getMoney.text.length == 0) {
        [vc showTitle:@"请输入提款金额" delay:1];
    }
    else if ([_getMoney.text floatValue] < 3) {
        [vc showTitle:@"提款金额不能低于3元" delay:1];
    }
    else if ([_getMoney.text floatValue] > [_hadMoneyStr floatValue]) {
        [vc showTitle:@"余额不足" delay:1];
    }
    else {
        WithdrawalPassController *success = [[WithdrawalPassController alloc]init];
        success.price = _getMoney.text;
        [self.viewController.navigationController pushViewController:success animated:YES];
    }

}

#pragma mark UITextFieldDelegate 
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text floatValue] >= 1000) {
        _guolu.text = [NSString stringWithFormat:@"手续费：0.00元"];
    }else {
        _guolu.text = [NSString stringWithFormat:@"手续费：2.00元"];
    }
}



@end

