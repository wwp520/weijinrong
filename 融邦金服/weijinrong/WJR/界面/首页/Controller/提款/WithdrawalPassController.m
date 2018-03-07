//
//  WithdrawalPassController.m
//  chengzizhifu
//
//  Created by RY on 16/10/7.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "WithdrawalPassController.h"
#import "BaseModel.h"
#import "Unity.h"
#import "WithdrawalSuccController.h"
#import "WithdrawalModel.h"


@interface WithdrawalPassController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *passWordField;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtn;
@end

@implementation WithdrawalPassController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"提款"];
    [self.priceLabel setText:[NSString stringWithFormat:@"￥%.2f",[self.price floatValue]]];
    self.passWordField.leftView = ({
        UILabel *textField = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
        textField.font = [UIFont systemFontOfSize:14];
        textField.text = @"  登录密码";
        textField;
    });
    self.passWordField.leftViewMode = UITextFieldViewModeAlways;
    self.passWordField.delegate = self;
    [self.passWordField becomeFirstResponder];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

//提款
- (IBAction)payClick:(UIButton *)sender {
    
    // 判断
    [self.view endEditing:YES];
    NSString *pass = GetPassword;
    if ([self.passWordField.text isEqualToString:@""]) {
        [self showTitle:@"请输入密码" delay:1];
        return;
    }
    else if (![self.passWordField.text isEqualToString:pass]) {
        [self showTitle:@"密码错误" delay:1];
        return;
    }
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [SaveManager  getStringForKey:@"mercId"],@"mercId",
                                                   self.price,@"balance",
                                                   self.passWordField.text,@"password",
                                                   nil]];
        [KKTools encryptionJsonString:str];
    })];
    [self showHudLoadingView:@"正在付款..."];
    [_moneyBtn setEnabled:NO];
    
    // 请求
    [DongManager moneyNow:oldParam success:^(id requestData) {
        [self hiddenHudLoadingView];
        WithdrawalModel *model = [WithdrawalModel decryptBecomeModel:requestData];
        if (model.retCode == 0) {
            NSString *name = [SaveManager getStringForKey:@"shortName"];
            WithdrawalSuccController *success = [[WithdrawalSuccController alloc]init];
            success.type = _type;
            success.merchatName = name;
            success.payAmount   = _price;
            success.tradingHours = ({
                NSDate *date = [NSDate date];
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                formatter.dateFormat = @"yyyy-MM-dd:HH:mm:ss";
                [formatter stringFromDate:date];
            });
            if (model.orderNumber != nil) {
                success.orderNumber = model.orderNumber;
            }
            [self.navigationController pushViewController:success animated:YES];
        }else {
            [_moneyBtn setEnabled:YES];
            [self showTitle:model.retMessage delay:1];
        }
    } fail:^(NSError *error) {
        [_moneyBtn setEnabled:YES];
        [self showNetFail];
    }];
}

@end
