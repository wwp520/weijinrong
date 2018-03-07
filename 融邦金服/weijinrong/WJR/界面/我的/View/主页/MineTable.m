//
//  MineTable.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "MineTable.h"
#import "NewBankListController.h"
#import "NewMyQrViewController.h"
#import "FeetEditViewController.h"
#import "SetPwdViewController.h"
#import "NewAttestationController.h"
#import "ShareCodeController.h"
#import "WithdrawalController.h"
#import "ConsultantController.h"
#import "AboutUsViewController.h"
#import "UpdateModel.h"
#import "ShenHe.h"
#import "Unity.h"

#pragma mark 声明
@interface MineTable ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate> {
    BOOL isUp;
    NSString *updateUrl;
}
@property (nonatomic, strong) UpdateModel *updateModel;
@property (nonatomic, strong) NSArray *titles;
@end

#pragma mark 实现
@implementation MineTable

+ (instancetype)initWithFrame:(CGRect)frame {
    MineTable *view = [[MineTable alloc] initWithFrame:frame];
    [view table];
    return view;
}
- (NSArray *)titles {
//    if (!_titles) {
        if ([ShenHe sharedShenHe].isSh == NO) {
            _titles = @[@"密码修改",@"服务顾问",@"意见反馈",@"版本更新",@"关于我们"];
        }else {
            _titles = @[@"密码修改",@"意见反馈",@"关于我们"];
        }
//    }
    return _titles;
}

- (UITableView *)table {
    isUp = NO;
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.showsVerticalScrollIndicator = NO;
        _table.showsHorizontalScrollIndicator = NO;
        [_table setLineHide];
        [_table setLineAll];
        [self addSubview:_table];
    }
    return _table;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.textColor = RGB(80, 80, 80, 1);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([ShenHe sharedShenHe].isSh == NO) {
        if (indexPath.row == 0) { //密码修改
            // 是否登录
//            if ([KKStaticParams sharedKKStaticParams].currentLogin == NO) {
//                LoginController *login = [[LoginController alloc] init];
//                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:login];
//                [self.viewController.navigationController presentViewController:nav animated:YES completion:nil];
//            }else {
//                [self.viewController pushViewController:[SetPwdViewController class]];
//            }
        [self.viewController pushViewController:[SetPwdViewController class]]; 
        }
        else if (indexPath.row == 1){//服务顾问
            [self help];
        }else if (indexPath.row == 2){//意见反馈
            [self.viewController pushViewController:[FeetEditViewController class]];
        }else if (indexPath.row == 3){//版本更新
            [self isUpdate];
        }else if (indexPath.row == 4){//关于我们
            [self.viewController pushViewController:[AboutUsViewController class]];
        }
    }else {
        if (indexPath.row == 0) { //密码修改
            // 是否登录
            if ([KKStaticParams sharedKKStaticParams].currentLogin == NO) {
                LoginController *login = [[LoginController alloc] init];
                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:login];
                [self.viewController.navigationController presentViewController:nav animated:YES completion:nil];
            }else {
                [self.viewController pushViewController:[SetPwdViewController class]];
            }
        }else if (indexPath.row == 1){//意见反馈
            [self.viewController pushViewController:[FeetEditViewController class]];
        }else if (indexPath.row == 2){//关于我们
            [self.viewController pushViewController:[AboutUsViewController class]];
        }
    }
    
    
    
    //    if (indexPath.row == 0) {
    //        //分享二维码
    //        [self.viewController  pushViewController:[ShareCodeController class]];
    //    }
    //    if (indexPath.row == 1) {
    //        // 实名认证
    //        [self.viewController pushViewController:[NewAttestationController class]];
    //    }else if (indexPath.row == 2){ //提现
    //        WithdrawalController  * wdVC = [[WithdrawalController  alloc]init];
    //        [self.viewController.navigationController pushViewController:wdVC animated:YES];
    //    }else if (indexPath.row == 3) {
    //        // 我的银行卡
    //        [self.viewController pushViewController:[NewBankListController class]];
    //    }else if (indexPath.row == 4) {
    //        // 我的二维码
    //        NewMyQrViewController *vc = [[NewMyQrViewController alloc] init];
    //        vc.model = _model;
    //        [self.viewController.navigationController pushViewController:vc animated:YES];
    //    }else if (indexPath.row == 5) {
    //        // 意见反馈
    //        [self.viewController pushViewController:[FeetEditViewController class]];
    //    }else if (indexPath.row == 6) {
    //        // 修改密码
    //        [self.viewController pushViewController:[SetPwdViewController class]];
    //    }
}

- (void)isUpdate {
    if (isUp == YES) {
        return;
    }
    
    BaseViewController *vc = (BaseViewController *)self.viewController;
    isUp = YES;
    NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"2",@"merchantType",
                          ChannelNumber,@"versionType", nil];//O单类型
    [vc showHudLoadingView:@"正在获取最新版本..."];
    __weak BaseViewController *weakSelf = (BaseViewController *)self.viewController;
    [DongManager queryMerchantinfo:dict success:^(id requestData) {
        [weakSelf hiddenHudLoadingView];
        _updateModel = [UpdateModel decryptBecomeModel:requestData];
        if (_updateModel.retCode==0) {
            if ([app_Version integerValue]<[_updateModel.versionId integerValue]) {
                updateUrl=_updateModel.downUrl;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本更新" message:[NSString stringWithFormat:@"最新版本为%@, 请立即更新",_updateModel.versionNo] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                [alert show];
                isUp = NO;
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showTitle:@"当前已经是最新版本" delay:1.5f];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        isUp = NO;
                    });
                });
            }
        }
    } fail:^(NSError *error) {
        [weakSelf showNetFail];
    }];
}

// 服务顾问
- (void)help {
    
    //        [self.viewController pushViewController:[ConsultantController class]];
    NSURL *url = [NSURL URLWithString:@"telprompt://4000029699"];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备暂时不支持拨号功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
    }else if (buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:_updateModel.downUrl];
        [[UIApplication sharedApplication]openURL:url];
    }
}

@end

