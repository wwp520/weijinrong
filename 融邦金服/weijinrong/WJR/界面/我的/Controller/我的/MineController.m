//
//  MineController.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "MineController.h"
#import "MineTable.h"
#import "MineHeader.h"
#import "MineFooter.h"
#import "NewSetModel.h"
#import "DongManager.h"
#import "MineHeader.h"
#import "BaseModel.h"
#import "UserModel.h"
#import "ShenHe.h"
#import "HomeController.h"
#import <LinkPayLoanSDK/LinkPayLoanSDK.h>
#import "NewAttestationController.h"

#pragma mark 声明
@interface MineController ()
@property (nonatomic, strong) MineTable *table;
@property (nonatomic, strong) MineHeader *header;
@property (nonatomic, strong) MineFooter *footer;
@property (nonatomic, strong) NewSetModel *model;
@end

#pragma mark 实现
@implementation MineController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self table];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self changeLoginStatus];
    if ([KKStaticParams sharedKKStaticParams].currentLogin == YES) {
        [self getUserStatus];
    }else {
        //登录
        [self pushLoginVc:^{
            // 登陆成功
            [self getUserStatus];
        }close:^{
            //首页
            [self.navigationController.tabBarController setSelectedIndex:0];
        }];
    }
}

- (void)changeLoginStatus {
    if ([KKStaticParams sharedKKStaticParams].currentLogin == NO) {
        _header.logined.alpha = 0;
        _header.loginBtn.alpha = 1;
        _table.table.tableFooterView = [UIView new];
    }else {
        _header.logined.alpha = 1;
        _header.loginBtn.alpha = 0;
        _header.name.text = GetAccount;
        _table.table.tableFooterView = [self footer];
    }
}

- (MineTable *)table {
    if (!_table) {
        _table = [MineTable initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49)];
        _table.table.tableHeaderView = [self header];
        _footer.backgroundColor = [UIColor whiteColor];
        _table.table.tableFooterView = [self footer];
        _table.table.bounces = NO;
        [self.view addSubview:_table];
    }
    return _table;
}

- (MineHeader *)header {
    if (!_header) {
        _header = [MineHeader loadFromFrame:CGRectMake(0, 0, ScreenWidth, 0) icon:^{
            
        } login:^{
            LoginController *login = [[LoginController alloc] init];
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:login];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }];
    }
    if ([ShenHe sharedShenHe].isSh == YES) {
        _header.statusW.constant = 0;
    }
    return _header;
}

// 获取用户状态
- (void)getUserStatus {
    
    [DongManager getUserStatus:^(id requestData) {
        UserModel *model = [UserModel decryptBecomeModel:requestData];
        if (model.retCode == 0) {
            //认证过
            if([model.mercSts isEqualToString:@"10"]){ //未认证
                [_header.statusBtn setImage:[UIImage imageNamed:@"未认证.png"] forState:UIControlStateNormal];
                [_header.statusBtn addTarget:self action:@selector(StatusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
            }else {//认证
                    [_header.statusBtn setImage:[UIImage imageNamed:@"已认证"] forState:UIControlStateNormal];
            }
        }else {
            [self showNetFail];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}

//如果是未认证,跳转至实名认证
- (void)StatusBtnClick:(UIButton *)btn{
    NewAttestationController * newVC = [[NewAttestationController alloc]init];
    [self.navigationController pushViewController:newVC animated:YES];
}


// 退出登录
- (MineFooter *)footer {
    if (!_footer) {
        _footer = [MineFooter loadFromFrame:CGRectMake(0, 0, ScreenWidth, 150) click:^{
            [CKAlertManager clickShowAlert:@"是否退出" message:@"是否退出当前账号" actions:@[@"取消",@"确认"] click:^(NSString *str) {
                if ([str isEqualToString:@"确认"]) {
                    
                    [self showHudLoadingView:@"等待中"];
                    DeviceModel *model = [NSString getPhoneInfo];
                    
                    // 退出登录请求接口（session可不传，无返回数据）
                    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                            GetAccount ,@"creationName",
                                            [GetPassword md5],@"password",
                                            model.phoneModel,@"phoneModel",
                                            model.sysVersionNumber,@"sysVersionNumber",
                                            model.appName,@"appName",
                                            model.appVersion,@"appVersion",
                                            model.appBuild,@"appBuild",
                                            ChannelNumber,@"agentNumber",
                                            @"",@"province",
                                            @"",@"cityCode",nil];
                    [DongManager logout:params success:^(id requestData) {
                        [self hiddenHudLoadingView];
                        _model = [LoginModel decryptBecomeModel:requestData];
                        AutoLogin(@"0");
                        [LinkPaySDK linkPaySdkLogOut];
                        [KKStaticParams sharedKKStaticParams].currentLogin = NO;
                        [self changeLoginStatus];
                    } fail:^(NSError *error) {
                        NSLog(@"失败");
                    }];
                    
                }
            }];
        }];
    }
    return _footer;
}




@end
