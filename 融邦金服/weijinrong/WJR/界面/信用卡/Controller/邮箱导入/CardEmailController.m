//
//  CardEmailController.m
//  weijinrong
//
//  Created by RY on 17/4/7.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CardEmailController.h"
#import "AddEmail.h"
#import "QQEmaiLinkController.h"
#import "EmailLinkController.h"

#pragma mark 声明
@interface CardEmailController ()
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property(nonatomic,strong) BaseModel * model;
@end

#pragma mark 实现
@implementation CardEmailController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"邮箱导入"];
    [self.view setBackgroundColor:RGB(233, 233, 233, 1)];
    _addBtn.layer.cornerRadius  = 5;
    _addBtn.layer.masksToBounds = YES;
    _addBtn.layer.borderWidth   = 1;
    _addBtn.layer.borderColor   = [UIColor grayColor].CGColor;
    _account.layer.cornerRadius = 5;
    _account.layer.masksToBounds = YES;
    _password.layer.cornerRadius = 5;
    _password.layer.masksToBounds = YES;
    [_account setLeftTitle:@"邮箱账号:"];
    [_password setLeftTitle:@"邮箱密码:"];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

// 邮箱导入
- (IBAction)addBtn:(id)sender {
    [self showHudLoadingView:@"正在获取..."];
    if (_account.text.length == 0) {
        [self showTitle:@"请输入邮箱账号" delay:1];
    }else if (_password.text.length == 0){
         [self showTitle:@"请输入密码" delay:1];
    }
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:@{
                    @"mercid":[SaveManager  getStringForKey:@"mercId"],
                     @"username":_account.text,
                    @"password":_password.text,}];
        [KKTools encryptionJsonString:str];
    })];
    
    [DongManager  Email:oldParam success:^(id requestData) {
        [self  hiddenHudLoadingView];
        _model = [BaseModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            [self showTitle:_model.retMessage delay:1];
        }else{
            [self showTitle:_model.retMessage delay:1];
        }
    } fail:^(NSError *error) {
        [self  showNetFail];
    }];
}


- (IBAction)GetQQ:(id)sender {
    QQEmaiLinkController * qqVC = [[QQEmaiLinkController alloc]init];
    [self.navigationController pushViewController:qqVC animated:YES];
    
}
- (IBAction)GetWangYi:(id)sender {
    EmailLinkController * emailVC = [[EmailLinkController alloc]init];
    [self.navigationController pushViewController:emailVC animated:YES];
}

@end
