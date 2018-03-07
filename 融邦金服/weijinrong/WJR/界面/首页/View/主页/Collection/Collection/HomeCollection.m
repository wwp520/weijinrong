//
//  HomeCollection.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "HomeCollection.h"
#import "HomeCell.h"
#import "HomeHeader.h"
#import "HomeFooter.h"
#import "BaseTabBarController.h"
#import "LoanFinController.h"
#import "FinancialController.h"
#import "NewScanView.h"
#import "NewScanKeyController.h"
#import "WithdrawalController.h"
#import "CrediCardLinkController.h"
#import "ScanCodePayController.h"
#import "NewAttestationController.h"
#import "HomeSliderCell.h"
#import "DoctorController.h"
#import "HomeDataSource.h"
#import "UserModel.h"
#import "MineHeader.h"
#import "MakeThingController.h"
#import <LinkPayLoanSDK/LinkPayLoanSDK.h>
#import "ShenView.h"
#import "ShenHe.h"
#import "ResultsViewController.h"
#import "HomeLocation.h"
#import "BaseViewController.h"
#import "HomeController.h"
#import "RBJFHeaderView.h"
#import "RBJFHeader.h"




#pragma mark 声明
@interface HomeCollection ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,HomeDataSourceDelegate>
@property (nonatomic, strong) HomeDataSource *collectionSource;
@property (nonatomic, strong) MineHeader * headView;
@property (nonatomic, strong) ShenView * shenHeView;

@end

#pragma mark 实现
@implementation HomeCollection

#pragma mark 声明
+ (instancetype)initWithFrame:(CGRect)frame {
    HomeCollection *view = [[HomeCollection alloc] initWithFrame:frame];
    if ([ShenHe sharedShenHe].isSh == YES) {
        [view shenHeView];
    }else{
        [view collection];
    }
    return view;
}
- (ShenView *)shenHeView {
    if (!_shenHeView) {
        _shenHeView = [ShenView initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
        [self addSubview:_shenHeView];
    }
    return _shenHeView;
}
- (UICollectionView *)collection {
    if (!_collection) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(ScreenWidth / 3.0, ScreenWidth / 9 * 2.5);
        flow.minimumLineSpacing = 0;
        flow.minimumInteritemSpacing = 0;
        flow.headerReferenceSize = CGSizeMake(ScreenWidth, ScreenWidth / 3);
        flow.footerReferenceSize = CGSizeMake(ScreenWidth, ScreenWidth / 2);
        
        _collection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.delegate = [self collectionSource];
        _collection.dataSource = [self collectionSource];
        _collection.showsVerticalScrollIndicator = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        [_collection registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellWithReuseIdentifier:@"HomeCell"];
    //    [_collection registerNib:[UINib nibWithNibName:@"HomeHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeader"];
        
         [_collection registerNib:[UINib nibWithNibName:@"RBJFHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RBJFHeader"];
        
        [_collection registerNib:[UINib nibWithNibName:@"HomeFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HomeFooter"];
        [_collection registerNib:[UINib nibWithNibName:@"HomeSliderCell" bundle:nil] forCellWithReuseIdentifier:@"HomeSliderCell"];
        [self addSubview:_collection];
    }
    return _collection;
}

- (HomeDataSource *)collectionSource {
    if (!_collectionSource) {
        _collectionSource = [[HomeDataSource alloc] init];
    }
    _collectionSource.delegate = self;
    _collectionSource.weakVc = (BaseViewController *)self.viewController;
    _collectionSource.model = _model;
    return _collectionSource;
}


#pragma mark - 设置数据
- (void)setModel:(LoginModel *)model {
    [model managerModelForType];
    _model = model;
    [self collectionSource];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collection reloadData];
    });
}

#pragma mark - 主页上的点击方法
- (void)clickModelArr:(NSInteger)section model:(NSInteger)row {
    // 是否可用
    BaseViewController *curVc = (BaseViewController *)self.viewController;
    LoginItemModel *model = _model.modelTypes[section][row];
    NSLog(@"%@  %@",model.businesscode, model.businessname);
    if (![self isVisible:model]) {
        [curVc showTitle:@"服务尚未开通, 敬请期待" delay:1.5f];
        return ;
    }
    
    // 扫码/快捷
    if (section == 0) {
        // 实名 - 扫码收款
        void (^scanQr)() = ^() {
            [self getUserStatus:^(NSString *str) {
                if ([str isEqualToString:@"60"] || [str isEqualToString:@"30"]) {
                    if ([model.businesscode isEqualToString:@"A022"]) {
                        // 扫码收款
                        ScanCodePayController *scanVC = [[ScanCodePayController alloc] init];
                        [self.viewController.navigationController pushViewController:scanVC animated:YES];
                    }else if ([model.businesscode isEqualToString:@"A024"]) { //快捷支付
                        [curVc showTitle:@"内测中,近期上线" delay:1.5f];
                    }else {
                        [curVc showTitle:@"服务尚未开通, 敬请期待" delay:1.5f];
                    }
                }
                else if ([str isEqualToString:@"10"]) { //未认证
                    [self.viewController pushViewController:[NewAttestationController class]];
                }
            }];
        };
        // 是否登录
        if ([KKStaticParams sharedKKStaticParams].currentLogin == NO) {
            [self.viewController pushLoginVc:^{
                scanQr();
            } close:^{

            }];
        }else {
            scanQr();
        }
        return;
    }
    // 中间Cell
    else if (section == 1) {
        if ([model.businesscode isEqualToString:@"A031"]) {
            // 信用卡
            CreditCardController *linkVC = [[CreditCardController alloc]init];
            [curVc.navigationController pushViewController:linkVC animated:YES];
        }else if ([model.businesscode isEqualToString:@"A033"]) {
            // 理财
            [curVc showTitle:@"服务尚未开通, 敬请期待" delay:1.5f];
        }else if ([model.businesscode isEqualToString:@"A000"]) {
            // 基金(现用来做贷款)
            [curVc showTitle:@"服务尚未开通, 敬请期待" delay:1.5f];
        }else if ([model.businesscode isEqualToString:@"A023"]) {
            // 证券开户
            [curVc showTitle:@"服务尚未开通, 敬请期待" delay:1.5f];
        }else {
            [curVc showTitle:@"服务尚未开通, 敬请期待" delay:1.5f];
        }
    }
    // 最后Cell
    else if (section == 2) {
        if ([model.businesscode isEqualToString:@"A016"]) {
            //更多
            [curVc showTitle:@"服务尚未开通, 敬请期待" delay:1.5f];
        }else if ([model.businesscode isEqualToString:@"A018"]) {
            // 美团
            WebController *vc = [[WebController alloc] init];
            vc.url = @"http://r.union.meituan.com/link/bora6u";
            vc.navTitle = @"美团";
            [curVc.navigationController pushViewController:vc animated:YES];
        }else if ([model.businesscode isEqualToString:@"A004"]) {
            // 京东
        }else if ([model.businesscode isEqualToString:@"A034"]) {
            // 旅游
            WebController *vc = [[WebController alloc] init];
            vc.url = @"https://m.ly.com/?refid=282195789";
            vc.navTitle = @"同程旅游";
            [curVc.navigationController pushViewController:vc animated:YES];
        }else if ([model.businesscode isEqualToString:@"A005"]) {
            // 信用卡还款
            WebController *vc = [[WebController alloc] init];
            vc.url = @"http://r.union.meituan.com/link/bora6u";
            vc.navTitle = @"信用卡还款";
            [curVc.navigationController pushViewController:vc animated:YES];
        }else if ([model.businesscode isEqualToString:@"A017"]) {
            // 飞机票
            WebController *vc = [[WebController alloc] init];
            NSString *token = [SaveManager getStringForKey:@"mercId"];
            vc.url = [NSString stringWithFormat:@"https://m.ly.com/flightnew/?refid=98106537&&token=%@",token];
            vc.navTitle = @"飞机票";
            [curVc.navigationController pushViewController:vc animated:YES];
        }else if ([model.businesscode isEqualToString:@"A014"]) {
            // 火车票
            NSString *token = [SaveManager getStringForKey:@"mercId"];
            WebController *vc = [[WebController alloc] init];
            vc.url = [NSString stringWithFormat:@"http://wx.17u.cn/traincooperators?RefId=98106537&token=%@",token];
            vc.navTitle = @"火车票";
            [curVc.navigationController pushViewController:vc animated:YES];
        }else if ([model.businesscode isEqualToString:@"A045"]) {
            // 电影票
        }else if ([model.businesscode isEqualToString:@"A044"]) {
            // 彩票
        }else if ([model.businesscode isEqualToString:@"A010"]) {
            // 加油卡充值
        }else if ([model.businesscode isEqualToString:@"A021"]) {
            // 游戏充值
        }else if ([model.businesscode isEqualToString:@"A015"]) {
            // 便民缴费
        }else if ([model.businesscode isEqualToString:@"A006"]) {
            // 手机充值
        }else if ([model.businesscode isEqualToString:@"A052"]) {
            // 鱼之道
            DoctorController *vc = [[DoctorController alloc] init];
            vc.type = 1;
            vc.navTitle = model.businessname;
            [curVc.navigationController pushViewController:vc animated:YES];
        }else if ([model.businesscode isEqualToString:@"A051"]) {
            // 万人创业
            MakeThingController * makeVC = [[MakeThingController alloc]init];
            [curVc.navigationController pushViewController:makeVC animated:YES];
        }else if ([model.businesscode isEqualToString:@"A041"]) {
            // 法律咨询
            WebController *vc = [[WebController alloc] init];
            vc.url = @"http://lkl.oudapay.com:8033/LKLM_PMS/falvzixun.jsp";
            vc.navTitle = @"法律咨询";
            [curVc.navigationController pushViewController:vc animated:YES];
        }else if ([model.businesscode isEqualToString:@"A043"]) {
            // 私人医生
            DoctorController *vc = [[DoctorController alloc] init];
            vc.type = 0;
            vc.navTitle = model.businessname;
            [curVc.navigationController pushViewController:vc animated:YES];
        }else {
            [curVc showTitle:@"服务尚未开通, 敬请期待" delay:1.5f];
        }
    }
}

- (void)clickFooter:(NSInteger)row {
    if (row == 0) {
        // 是否登录
        if ([KKStaticParams sharedKKStaticParams].currentLogin == NO) {
            LoginController *login = [[LoginController alloc] init];
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:login];
            [self.viewController.navigationController presentViewController:nav animated:YES completion:nil];
        }else {
            // 信用卡
            CreditCardController * creditVC = [[CreditCardController alloc]init];
            [self.viewController.navigationController pushViewController:creditVC animated:YES];
        }
    }else if (row == 1) {
        // 是否登录
        if ([KKStaticParams sharedKKStaticParams].currentLogin == NO) {
            LoginController *login = [[LoginController alloc] init];
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:login];
            [self.viewController.navigationController presentViewController:nav animated:YES completion:nil];
        }else {
            BaseViewController *vc = (BaseViewController *)self.viewController;
            [vc showTitle:@"服务尚未开通, 敬请期待" delay:1.5f];
            
       //     ODLoanController *otherVC = [[ODLoanController alloc]init];
       //     otherVC.navTitle = @"我要贷款";
        //    [self.viewController.navigationController pushViewController:otherVC animated:YES];
        }
    }else if (row == 2) {
        
    }else if (row == 3) {
        BaseViewController *vc = (BaseViewController *)self.viewController;
        [vc showTitle:@"服务尚未开通, 敬请期待" delay:1.5f];
//        CatViewController *vc = [[CatViewController alloc] init];
//        vc.navTitle = @"理财";
//        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else if (row == 4) {
        WebController *vc = [[WebController alloc] init];
        vc.url = @"http://pay.oudapay.com:8001/insurance/Insurance.html";
        vc.navTitle = @"保险";
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}

// 判断后台是否开启该功能
- (BOOL)isVisible:(LoginItemModel *)model {
    if ([model.status isEqualToString:@"0"]) {
        return YES;
    }
    return NO;
}

// 获取用户状态
- (void)getUserStatus:(KKStrBlock)block {

    [DongManager getUserStatus:^(id requestData) {
        UserModel *model = [UserModel decryptBecomeModel:requestData];
        if (!model || model.retCode != 0) {
            [(BaseViewController *)self.viewController showTitle:@"请求失败" delay:1];
        }
        //认证过
        if ( model.mercSts.length != 0) {
            block(model.mercSts);
        }else {
            [(BaseViewController *)self.viewController showTitle:@"请求失败" delay:1];
        }
    } fail:^(NSError *error) {
        BaseViewController *vc = (BaseViewController *)self.viewController;
        [vc showNetFail];
    }];
}



@end

