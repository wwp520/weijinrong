//
//  HomeController.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "HomeController.h"
#import "HomeCollection.h"
#import "HomeLocation.h"
#import "HomeBtn.h"
#import "DongManager.h"
#import "RBJFCollection.h"
#import "HelpController.h"
#import "PushListController.h"
#import "MessageListModel.h"
#import "ShenHe.h"
#import "ADView.h"
#import "BankRewardController.h"
#import "AppDelegate.h"
#import "UpdateModel1.h"
#import "HomeHeader.h"
#import "NetFailView.h"
#import "HomeLocation.h"
#import "RBJFHeader.h"

#define messageNotArrM @"messageNotArrM"
#define APPDELEGATE  ((AppDelegate *)[UIApplication sharedApplication].delegate)

#pragma mark 声明
@interface HomeController ()<ADViewDelegate> {
    NSString *updateInfo;
    NSString *updateUrl;
}
@property (nonatomic, strong) HomeCollection *collection;
@property (nonatomic, strong) UILabel *countLabel;  //左上角小点
@property (nonatomic, strong) ADView *aview;
@property (nonatomic, strong) UIAlertView *alert;
@property (nonatomic, strong) NetFailView *netfail;
@property(nonatomic,strong)HomeLocation * location;
@property(nonatomic,strong)RBJFHeader * RBJFheader;
@end

#pragma mark 实现
@implementation HomeController


#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"融邦金服"];
    [self createUI];
    [self getHomeContent];
    [_RBJFheader location];
}



- (void)createUI {
    [self createRightHelpBtn];
    [self createLeftMessageBtn];
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (isAutoLogin && [KKStaticParams sharedKKStaticParams].currentLogin == NO) {
        LoginController *login = [[LoginController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:login];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }else if ([KKStaticParams sharedKKStaticParams].currentLogin == YES){
        [self getMessageList];
        if ([ShenHe sharedShenHe].isSh == NO &&
            [KKStaticParams sharedKKStaticParams].lat == 0) {
            [self.collection.collection reloadData];
        }
    }
}

- (NetFailView *)netfail {
    if (!_netfail) {
        _netfail = [NetFailView loadFromFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) click:^{
            [self getHomeContent];
        }];
        [self.view addSubview:_netfail];
        [self.view bringSubviewToFront:_netfail];
    }
    return _netfail;
}



#pragma mark - 网络请求
// 获取主页内容
- (void)getHomeContent {
    // 获取session时访问
    [self showHudLoadingView:@"正在加载..."];
    [DongManager getiOSlogined:^(id requestData) {
        [self hiddenHudLoadingView];
        [self.netfail setAlpha:0];
        LoginModel *model = [LoginModel decryptBecomeModel:requestData];
        // 判断
        if (model.retCode == 0) {
            // 审核判断
            [ShenHe sharedShenHe].model = model;
            // 存内存
            [[KKStaticParams sharedKKStaticParams] setLogin:model];
            // 存本地
            [SaveManager saveString:model.mercId forKey:@"mercId"];
            [SaveManager saveString:model.shortName forKey:@"shortName"];
            [SaveManager saveString:nil forKey:@"session"];
            [SaveManager saveString:nil forKey:@"token"];
            [SaveManager saveString:nil forKey:@"mercId"];
            SaveAccount(nil);
            
            
            // 显示
            [self collection];
        }else {
            [self showTitle:model.retMessage delay:1.5f];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
        [self netfail];
        _netfail.alpha = 1;
    }];
    
}
// 通知列表
- (void)getMessageList {
//    [self showHudLoadingView:@"正在加载"];
    [DongManager getMessageList:^(id requestData) {
        [self hiddenHudLoadingView];
        
        NSMutableDictionary *newData = [NSMutableDictionary dictionaryWithDictionary:[KKTools dictionaryWithJsonString:requestData]];
        NSString *requestStr = [KKTools decryptJsonString:newData[@"outParam"]];
        NSDictionary *listDict = [AFNManager dictionaryWithJsonString:requestStr];
        NSArray *list = listDict[@"list"];
        
        
        NSMutableArray *models = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in list) {
            MessageListModel *model = [MessageListModel mj_objectWithKeyValues:dict];
            [models addObject:model];
        }
        if (models.count != 0) {
            [self saveNotiList:models];
        }
        
        if ([KKStaticParams sharedKKStaticParams].currentLogin == YES) {
            [self setSession];
        }
        
    } fail:^(NSError *error) {
        
        if ([KKStaticParams sharedKKStaticParams].currentLogin == YES) {
            [self setSession];
        }
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
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}
// 初始化
- (HomeCollection *)collection {
    if (!_collection) {
        _collection = [HomeCollection initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49 - 64)];
        _collection.model = [KKStaticParams sharedKKStaticParams].login;
        [self.view addSubview:_collection];
    }
    return _collection;
}

- (void)showADView {
    
    if ([ShenHe sharedShenHe].isSh == YES) {
        
    }else {
        _aview = [ADView initWithFrame:ScreenBounds];
        _aview.delegate = self;
        // 添加view
        [APPDELEGATE.window addSubview:_aview];
        // view在最上方
        [APPDELEGATE.window bringSubviewToFront:_aview];
    }
    
}

// 帮助中心
- (void)helpClick:(UIButton *)btn {
    HelpController * helpVC = [[HelpController alloc]init];
    [self.navigationController pushViewController:helpVC animated:YES];
}
// 左侧消息按钮
- (void)createLeftMessageBtn {
    UIButton *msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    msgBtn.frame = CGRectMake(0, 0, 25, 25);
    [msgBtn addTarget:self action:@selector(jumpMessageController) forControlEvents:UIControlEventTouchUpInside];
    [msgBtn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [msgBtn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateHighlighted];
    
    //右上角角标
    CGFloat countW = 15.f;
    UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(msgBtn.right - 8, -8, countW, countW)];
    countLabel.backgroundColor = [UIColor redColor];
    countLabel.layer.cornerRadius = countW/2;
    countLabel.layer.masksToBounds = YES;
    countLabel.textColor = [UIColor whiteColor];
    countLabel.font = [UIFont systemFontOfSize:9];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [msgBtn addSubview:countLabel];
    NSString *count = [[NSUserDefaults standardUserDefaults] stringForKey:@"notiCount"];
    self.countLabel = countLabel;
    if ([count integerValue] <= 0) {
        countLabel.alpha = 0;
    }else{
        countLabel.text = count;
    }
    
    countLabel.text = count;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:msgBtn];
    
}
// 右侧帮助按钮
- (void)createRightHelpBtn {
    [self.navigationItem setRightBarButtonItem:({
        HomeBtn *home = [HomeBtn initLeftTitle:@"" icon:@"帮助"];
        UIButton *btn = (UIButton *)home.customView;
        [btn addTarget:self action:@selector(helpClick:) forControlEvents:UIControlEventTouchUpInside];
        home;
    })];
}
// 跳转到Message控制器
- (void)jumpMessageController {
    PushListController *message = [[PushListController alloc]init];
    [self.navigationController pushViewController:message animated:YES];
}
// 消失
- (void)clickOne {
    [_aview removeFromSuperview];
}
- (void)clickTwo {
    [_aview removeFromSuperview];
    BankRewardController * bankVC = [[BankRewardController  alloc]init];
    [self.navigationController pushViewController:bankVC animated:YES];
}

// 保存通知消息
- (void)saveNotiList:(NSArray *)modelArr {
    // 保存数据
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    for (MessageListModel *model in modelArr) {
        [arrM addObject:model.ID];
    }
    
    NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] valueForKey:messageNotArrM];
    if (arr == nil) {
        arr = [[NSMutableArray alloc] init];
    }
    [arrM removeObjectsInArray:arr];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.countLabel.text = [@(arrM.count) description];
        self.countLabel.alpha = arrM.count > 0;
    });
    
}

// 更新
- (void)checkUpdate_Ios {
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                [SaveManager getStringForKey:@"mercId"],@"mercId",
                                @"2",@"merchantType",
                                ChannelNumber,@"versionType",
                                nil];
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    // 获取session时访问
    __weak HomeController *weakSelf = self;
    [DongManager updateVersion:oldParam success:^(id requestData) {
        UpdateModel1 *model = [UpdateModel1 decryptBecomeModel:requestData];
        if (model.retCode == 0) {
            updateInfo = model.updatInfo;
            if ([app_Version integerValue]<[model.versionId integerValue]) {
                updateUrl = model.downUrl;
                [self showAlert:[model.updateFlag intValue]];
                self.foregroundBlock=^{
                    if ([model.updateFlag intValue]==1) {
                        if (weakSelf.alert != nil) {
                            [weakSelf.alert show];
                        }
                    }
                };
            }else {
                
                static int i=0;
                if (i == 0) {
                    i = 1;
                    [self performSelector:@selector(showADView) withObject:nil afterDelay:2.f];
                }
            }
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
    
    
}
- (void)showAlert:(int)count {
    if (count == 1) {
        [self upgradePromptBox];
    }
    else {
        [self upgradePromptBox2];
    }
    [self.alert setTag:10000];
    [self.alert show];
}
// 升级提示框（强制）
- (void)upgradePromptBox {
    UIView * maxView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    maxView.backgroundColor= [UIColor grayColor];
    maxView.alpha=0.7;
    UIWindow *root = [[UIApplication sharedApplication] keyWindow];
    [root addSubview:maxView];
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(30, 200, self.view.frame.size.width-30*2,200)];
    view1.layer.cornerRadius=10;
    view1.layer.masksToBounds = YES;
    view1.backgroundColor = [UIColor whiteColor];
    [root addSubview:view1];
    
    UILabel * labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view1.frame.size.width, 35)];
    labelTitle.text=@"更新提示";
    labelTitle.font=[UIFont fontWithName:@"Arial" size:17];
    labelTitle.textAlignment=NSTextAlignmentCenter;
    [view1 addSubview:labelTitle];
    
    //    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, view1.frame.size.width, 1)];
    //    line1.backgroundColor = [UIColor grayColor];
    //    [view1 addSubview:line1];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, view1.frame.size.width-20*2, 100)];
    label.text=updateInfo;
    label.textAlignment=NSTextAlignmentLeft;
    //自动折行设置
    label.font=[UIFont systemFontOfSize:15];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    [view1 addSubview:label];
    
    CGSize size = [updateInfo boundingRectWithSize:CGSizeMake(view1.frame.size.width-20*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    label.height = size.height + 10;
    view1.height = CGRectGetMaxY(label.frame) + 40;
    view1.center = root.center;
    
    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), view1.frame.size.width, 1)];
    line2.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [view1 addSubview:line2];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), view1.frame.size.width, 40)];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btn setTitle:@"更  新" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:75/255.f green:188/255.f blue:249/255.f alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.463 green:0.576 blue:0.667 alpha:1.000] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:btn];
    
}
// 升级提示框（可选）
- (void)upgradePromptBox2 {
    
    UIView * maxView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    maxView.backgroundColor= [UIColor grayColor];
    maxView.alpha=0.7;
    maxView.tag = 10000;
    UIWindow *root = [[UIApplication sharedApplication] keyWindow];
    [root addSubview:maxView];
    
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(30, 200, self.view.frame.size.width-30*2,200)];
    view1.layer.cornerRadius=5;
    view1.layer.masksToBounds = YES;
    view1.backgroundColor = [UIColor whiteColor];
    view1.tag = 10001;
    [root addSubview:view1];
    
    UILabel * labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view1.frame.size.width, 35)];
    labelTitle.text=@"更新提示";
    labelTitle.font=[UIFont fontWithName:@"Arial" size:17];
    labelTitle.textAlignment=NSTextAlignmentCenter;
    [view1 addSubview:labelTitle];
    
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 35, view1.frame.size.width, 1)];
    //    line1.backgroundColor = [UIColor lightGrayColor];
    [view1 addSubview:line1];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, view1.frame.size.width-20*2, 100)];
    label.text=updateInfo;
    label.font=[UIFont systemFontOfSize:15];
    label.textAlignment=NSTextAlignmentLeft;
    //自动折行设置
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    [view1 addSubview:label];
    
    CGSize size = [updateInfo boundingRectWithSize:CGSizeMake(view1.frame.size.width-20*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    label.height = size.height + 10;
    view1.height = CGRectGetMaxY(label.frame) + 40;
    view1.center = root.center;
    
    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), view1.frame.size.width, 1)];
    line2.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [view1 addSubview:line2];
    
    UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), view1.frame.size.width/2, 40)];
    [btn1 setTitle:@"更  新" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithRed:0.463 green:0.576 blue:0.667 alpha:1.000] forState:UIControlStateHighlighted];
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btn1 setTitleColor:[UIColor colorWithRed:75/255.f green:188/255.f blue:249/255.f alpha:1] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(button2:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:btn1];
    btn1.tag = 10000;
    
    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.frame.size.width, CGRectGetMaxY(label.frame), view1.frame.size.width/2, 40)];
    [btn2 setTitle:@"取  消" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:0.463 green:0.576 blue:0.667 alpha:1.000] forState:UIControlStateHighlighted];
    btn2.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn2 setTitleColor:[UIColor colorWithRed:75/255.f green:188/255.f blue:249/255.f alpha:1] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(button2:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:btn2];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView == self.alert) {
        if (alertView.tag==10000) {
            if (buttonIndex == 0) {
                NSLog(@"%@",updateUrl);
                NSURL *url = [NSURL URLWithString:updateUrl];
                [[UIApplication sharedApplication]openURL:url];
            }
        }
        else {
            if (buttonIndex==0) {
                NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
                if ([[UIApplication sharedApplication] canOpenURL:url])
                {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        }
    }
}

- (void)button2:(UIButton *)btn {
    if (btn.tag == 10000) {
        NSURL *url = [NSURL URLWithString:updateUrl];
        [[UIApplication sharedApplication]openURL:url];
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [[window viewWithTag:10000] removeFromSuperview];
    [[window viewWithTag:10001] removeFromSuperview];
}

@end

