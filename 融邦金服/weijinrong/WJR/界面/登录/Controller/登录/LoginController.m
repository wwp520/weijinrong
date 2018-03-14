//
//  LoginController.m
//  weijinrong
//
//  Created by RY on 17/4/11.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "LoginController.h"
#import "RegisteredController.h"
#import "ForgetController.h"
#import "ForgetController2.h"
#import "DongManager.h"
#import "ShenHe.h"
#import <LinkPayLoanSDK/LinkPayLoanSDK.h>
#import <CommonCrypto/CommonDigest.h>
#import "SaveManager.h"

#pragma mark - 声明
@interface LoginController ()<LinkPaySdkDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *remember;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIView *register1;
@property (nonatomic, strong) LoginModel *model;
@end

#pragma mark - 实现
@implementation LoginController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:RGB(233, 233, 233, 1)];
    [self createUI];
    [_username setText:GetAccount];
    if (isAutoLogin) {
        [_password setText:GetPassword];
        [_remember setSelected:YES];
        [self login:nil];
    }
}

- (void)createUI {
    [self.view setBackgroundColor:RGB(233, 233, 233, 1)];
    [_username setLeftImage:@"资源 2.png" width:60];
    [_password setLeftImage:@"mima.png" width:60];
    
    
    if ([ShenHe sharedShenHe].sh == YES) {
        // 透明
        _register1.alpha = 0;
    }else {
        _register1.alpha = 1;
    }
    
}


// 关闭登录页
- (IBAction)close:(id)sender {
    if (_close) {
        _close();
    }
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)login:(UIButton *)sender {
    if (_password.text.length == 0) {
        [self showTitle:@"请输入密码" delay:1.5f];
        return;
    }else if (_username.text.length == 0) {
        [self showTitle:@"请输入账号" delay:1.5f];
        return;
    }else if (![KKTools isMobileNumber:_username.text]) {
        [self showTitle:@"手机号格式不正确" delay:1.5f];
        return;
    }
    
    
    
    [_login setUserInteractionEnabled:NO];
    [self showHudLoadingView:@"正在登录"];
    DeviceModel *model = [NSString getPhoneInfo];
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [_username text],@"creationName",
                            [_password.text md5],@"password",
                            model.phoneModel,@"phoneModel",
                            model.sysVersionNumber,@"sysVersionNumber",
                            model.appName,@"appName",
                            model.appVersion,@"appVersion",
                            model.appBuild,@"appBuild",
                            ChannelNumber,@"agentNumber",
                            @"",@"province",
                            @"",@"cityCode",nil];
    
    [DongManager login:params username:_username.text success:^(id requestData) {
        [self hiddenHudLoadingView];
        [_login setUserInteractionEnabled:YES];
        // 解析
        _model = [LoginModel decryptBecomeModel:requestData];
        // 判断
        if (_model.retCode == 0) {
            // 加审核
            [ShenHe sharedShenHe].model = _model;
            _model = [ShenHe sharedShenHe].model;
            
            // 存内存
            [[KKStaticParams sharedKKStaticParams] setLogin:_model];
            
            // 存本地
            SaveAccount(_username.text);
            SavePassword(_password.text);
            SaveVersion(model.appBuild);
            AutoLogin(_remember.selected ? @"1" : @"0");
            
            
            NSLog(@"**********************%@",_username.text);
        
            [SaveManager saveString:_model.mercId forKey:@"mercId"];
            [SaveManager saveString:_model.shortName forKey:@"shortName"];
            [KKStaticParams sharedKKStaticParams].mercSts = _model.mercSts;
            [KKStaticParams sharedKKStaticParams].profitMax = _model.profitMax;
            [KKStaticParams sharedKKStaticParams].profitMin = _model.profitMin;
            
            // 登录成功调用
            NSString *md5 = [NSString stringWithFormat:@"NQoWxYMnxdt4z2EwbPTmOA49i92bIBroV1cByqT8naKtuREs%@%@",_model.mercId, _username.text];
            NSString *sign = [self md5: md5];
            [LinkPaySDK initAccessKeyId:@"NQoWxYMnxdt4z2Ew" andSign:sign andUserId:_model.mercId withPhoneNum:_username.text delegate:self];
            
            [self setSession];
            
        } else {
            [self showTitle:_model.retMessage delay:1.5f];
        }
    } fail:^(NSError *error) {
        [_login setUserInteractionEnabled:YES];
        [self showNetFail];
    }];
    
    
}

// 获取session
- (void)setSession {
    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:
                            GetAccount,@"userName",
                            [SaveManager getStringForKey:@"token"],@"token", nil];
    // 获取session时访问
    [DongManager getSession:params success:^(id requestData) {
        [self hiddenHudLoadingView];
        NSDictionary *listDict = [AFNManager dictionaryWithJsonString:requestData];
        if ([listDict[@"retCode"] isEqualToString:@"0"]) {
            [LoginModel decryptBecomeModel:requestData];
        }
        
        // 返回上一页面
        [KKStaticParams sharedKKStaticParams].currentLogin = YES;
        [self dismissViewControllerAnimated:YES completion:^{
            if (_success) {
                _success();
            }
        }];
        
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}


// MD5加密
- (NSString *)md5:(NSString *) input {
    
    const char *cStr = [input UTF8String];
    
    unsigned char digest[16];
    
    unsigned int x=(int)strlen(cStr);
    
    CC_MD5( cStr, x, digest);
    
    // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        
        [output appendFormat:@"%02x", digest[i]];
        
    }
    
    return  output;
}


#pragma mark--LinkPaySdkDelegate
- (void)LinkPaySdkInitSuccess:(BOOL)success withError:(NSString *)error {
    if (success) {
        NSLog(@"初始化成功====");
    } else {
        NSLog(@"&&&&&&&&&&&&&&&&&&&错误信息:%@&&&&&&&&&&&&&&&&",error);
    }
}

- (IBAction)registeredClick:(UIButton *)sender {
    RegisteredController *vc = [[RegisteredController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)forgetClick:(UIButton *)sender {
    //ForgetController2 * vc = [[ForgetController2 alloc]init];
    ForgetController *vc = [[ForgetController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// 记住密码
- (IBAction)remember:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark - 其他
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}


@end







