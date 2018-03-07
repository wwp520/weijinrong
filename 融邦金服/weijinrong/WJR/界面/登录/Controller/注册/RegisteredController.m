//
//  RegisteredController.m
//  weijinrong
//
//  Created by RY on 17/4/12.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "RegisteredController.h"
#import "ProtocolController.h"
#import "SaveManager.h"
#import "ShenHe.h"

#pragma mark 声明
@interface RegisteredController (){
    // 1:未选中 0:选中
    NSInteger selectIndex;
}
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *pass1;
@property (weak, nonatomic) IBOutlet UITextField *pass2;
@property (weak, nonatomic) IBOutlet UILabel *codeNumber;
@property (weak, nonatomic) IBOutlet UIButton *regist;

@property (weak, nonatomic) IBOutlet UITextField *introduceTF;   //推荐码
@property (weak, nonatomic) IBOutlet UIButton *protocalBtn;

@end

#pragma mark 实现
@implementation RegisteredController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:RGB(233, 233, 233, 1)];
    [self setNavTitle:@"注册"];
    selectIndex = 1;
    [_regist setRadius:3];
    [_protocalBtn setSelected:YES];
    [_phone setImage:@"资源 7@0.5x(1)" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    [_code  setImage:@"资源 8@0.5x(1)" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    [_pass1 setImage:@"dd@0.5x" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    [_pass2 setImage:@"dd@0.5x" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    [_introduceTF  setImage:@"1资源 1@0.5x(1)" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    
        
//    if ([ShenHe isShenHeDate]) {
////         [_introduceTF setAlpha:0];     //透明
//        [self.view setAlpha:0];
//    }else {
////         [_introduceTF setAlpha:1];    //正常显示
//        [self.view setAlpha:1];
//    }
}

- (IBAction)protocalBtn:(id)sender {
    ProtocolController * proVC = [[ProtocolController  alloc]init];
    [self.navigationController  pushViewController:proVC animated:YES];
}

- (IBAction)agreebtn:(id)sender {
    _protocalBtn.selected = !_protocalBtn.selected;
}



// 注册
- (IBAction)registerClick:(UIButton *)sender {
    if (_phone.text.length == 0) {
        [self showTitle:@"手机号不能为空" delay:1];
    }else if (![KKTools isMobileNumber:_phone.text]) {
        [self showTitle:@"手机号格式不正确" delay:1];
    }else if (_code.text.length == 0) {
        [self showTitle:@"验证码不能为空" delay:1];
    }else if (_pass1.text.length == 0) {
        [self showTitle:@"密码不能为空" delay:1];
    }else if (![KKTools verfierPassword:_pass1.text]) {
        [self showTitle:@"密码格式不正确" delay:1];
    }else if (_pass2.text.length == 0) {
        [self showTitle:@"验证密码不能为空" delay:1];
    }else if (![_pass1.text isEqualToString:_pass2.text]) {
        [self showTitle:@"两次密码不一致" delay:1];
    }else {
        [_regist setUserInteractionEnabled:NO];
        [self showHudLoadingView:@"正在注册..."];
        
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:_phone.text,@"mobilePhone",
           [_pass1.text md5],@"password",
           _code.text,@"messageAuthenticationCode", nil];
        if (_introduceTF.text.length != 0) {
            [params setObject:_introduceTF.text forKey:@"generalize"];
        }
        

        [DongManager registe:params success:^(id requestData) {
            [self hiddenHudLoadingView];
            // 解析
            BaseModel *model = [BaseModel decryptBecomeModel:requestData];
            // 判断
            if (model.retCode == 0) {
                [self showTitle:model.retMessage delay:1];
                [self popDelay];
            }else {
                [self showTitle:model.retMessage delay:1];
                [_regist setUserInteractionEnabled:YES];
            }
        } fail:^(NSError *error) {
            [self showNetFail];
            [_regist setUserInteractionEnabled:YES];
        }];
    }
}

// 发送短信
- (IBAction)sendSMS:(UITapGestureRecognizer *)sender {
    if (_phone.text.length == 0) {
        [self showTitle:@"请输入手机号" delay:1];
    }else if (![KKTools isMobileNumber:_phone.text]) {
        [self showTitle:@"手机号格式不正确" delay:1];
    }else {
        SaveAccount(_phone.text);
        [self.view endEditing:YES];
        UILabel *send = (UILabel *)sender.view;
        [send setUserInteractionEnabled:NO];
        [self showHudLoadingView:@"获取验证码"];
        NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:
                                _phone.text,@"mobilePhone",
                                @"0",@"mark", nil];
        
        [DongManager code:params success:^(id requestData) {
            [self hiddenHudLoadingView];
            BaseModel *model = [BaseModel decryptBecomeModel:requestData];
            [self showTitle:model.retMessage delay:1];
            if (model.retCode == 0) {
                // 倒计时
                [self countDown];
                NSLog(@"验证码发送成功------------------------");
            }else {
                [send setUserInteractionEnabled:YES];
            }
        } fail:^(NSError *error) {
            [self showNetFail];
            [send setUserInteractionEnabled:YES];
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

