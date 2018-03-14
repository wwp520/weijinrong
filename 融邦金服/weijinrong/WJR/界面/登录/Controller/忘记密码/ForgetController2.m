   //
//  ForgetController2.m
//  weijinrong
//
//  Created by RY on 17/4/12.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "ForgetController2.h"
#import "DongManager.h"

#pragma mark 声明
@interface ForgetController2 ()
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UIButton *forget;
@property (weak, nonatomic) IBOutlet UITextField *password2;
@end

#pragma mark 实现
@implementation ForgetController2

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:RGB(233, 233, 233, 1)];
    [self setNavTitle:@"忘记密码"];
    [_password1 setImage:@"mima.png" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    [_password2 setImage:@"mima.png" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    [_forget setRadius:3];
}

//修确认密码
- (IBAction)changeClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if([_password1.text isEqualToString:@""]) {
        [self showTitle:@"请输入新密码" delay:1];
    }else if (![KKTools verfierPassword:_password1.text]) {
        [self showTitle:@"密码格式不正确" delay:1];
    }else if (![_password1.text isEqualToString:_password2.text]) {
        [self showTitle:@"两次密码不一致" delay:1];
    }else {
        [self showHudLoadingView:@"正在修改"];
        [sender setUserInteractionEnabled:NO];
        
        
        NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:
                                _phone,@"mobilePhone",                                [_password1.text md5],@"newPassword",nil];
        
        
        [DongManager pwdChange:params success:^(id requestData) {
            [self hiddenHudLoadingView];
            BaseModel *model = [BaseModel decryptBecomeModel:requestData];
            [self showTitle:model.retMessage delay:1];
            if (model.retCode == 0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                    [self popRootDelay];
                });

            }else {
                [sender setUserInteractionEnabled:YES];
            }
        } fail:^(NSError *error) {
            [self showNetFail];
            [sender setUserInteractionEnabled:YES];
        }];
    }
}

@end

