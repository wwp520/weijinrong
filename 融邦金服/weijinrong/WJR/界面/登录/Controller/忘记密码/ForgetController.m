//
//  ForgetController.m
//  weijinrong
//
//  Created by RY on 17/4/12.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "ForgetController.h"
#import "ForgetController2.h"

#pragma mark 声明
@interface ForgetController ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *card;
@property (weak, nonatomic) IBOutlet UILabel *codeNumber;
@property (weak, nonatomic) IBOutlet UIButton *next;
@end

#pragma mark 实现
@implementation ForgetController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:RGB(233, 233, 233, 1)];
    [self setNavTitle:@"忘记密码"];
    [_phone setImage:@"资源 7@0.5x(1)" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    [_code  setImage:@"资源 8@0.5x(1)" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    [_card  setImage:@"资源 10@0.5x(1)" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    [_next setRadius:3];
    
}
// 获取验证码
- (IBAction)code:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    if (_phone.text.length == 0) {
        [self showTitle:@"请输入手机号" delay:1];
    }else if (![KKTools isMobileNumber:_phone.text]) {
        [self showTitle:@"手机号格式不正确" delay:1];
    }else {
        SaveAccount(_phone.text);
        [self showHudLoadingView:@"正在获取验证码"];
        [_codeNumber setUserInteractionEnabled:NO];
        
        NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:
                                _phone.text,@"mobilePhone",
                                @"1",@"mark", nil];
        [DongManager code:params success:^(id requestData) {
            [self hiddenHudLoadingView];
            // 解析
            BaseModel *model = [BaseModel decryptBecomeModel:requestData];
            [self showTitle:model.retMessage delay:1];
            // 判断
            if (model.retCode == 0) {
                // 倒计时
                [self countDown];
                NSLog(@"wwp验证码获取成功**************************");
            }else {
                [_codeNumber setUserInteractionEnabled:YES];
            }
        } fail:^(NSError *error) {
            [self showNetFail];
            [_codeNumber setUserInteractionEnabled:YES];
        }];
    }
}

// 忘记密码
- (IBAction)forget:(UIButton *)sender {
    
    [self.view endEditing:YES];
    if (_phone.text.length == 0) {
        [self showTitle:@"请输入手机号" delay:1];
    }else if (![KKTools isMobileNumber:_phone.text]) {
        [self showTitle:@"手机号格式不正确" delay:1];
    }else if (_code.text.length == 0) {
        [self showTitle:@"请输入验证码" delay:1];
    }else {
        [self showHudLoadingView:@"正在请求"];
        [sender setUserInteractionEnabled:NO];
        
        NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:
                                _phone.text,@"mobilePhone",
                                _code.text,@"messageAuthenticationCode",
                                [_card.text uppercaseString],@"crpIdNo",nil];
       

        [DongManager forget:params success:^(id requestData) {
            [self hiddenHudLoadingView];
            [sender setUserInteractionEnabled:YES];
            BaseModel *model = [BaseModel decryptBecomeModel:requestData];
            if (model.retCode == 0) {
                NSLog(@"---------------%@--------------------",requestData);
                ForgetController2 *vc = [[ForgetController2 alloc] init];
                vc.phone = _phone.text;
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                [self showTitle:model.retMessage delay:1];
            }
        } fail:^(NSError *error) {
            [self showNetFail];
            [sender setUserInteractionEnabled:YES];
        }];
    }
}

- (void)countDown {
    [[KKCountdown sharedKKCountdown] startTimer:^(NSString *msg) {
        _codeNumber.text = msg;
        if ([msg isEqualToString:@"发送验证码"]) {
            _codeNumber.userInteractionEnabled = YES;
        }
    }];
}

@end

