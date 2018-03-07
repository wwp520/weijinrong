//
//  NewAttestationController.m
//  chengzizhifu
//
//  Created by RY on 16/12/28.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "NewAttestationController.h"
#import "AttestationView.h"
#import "TSLocateView.h"

#pragma mark 声明
@interface NewAttestationController ()<UITextFieldDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) AttestationView *attestation;
@property (nonatomic, strong) NSString *infoStr;// 审核未通过
@end

#pragma mark 实现
@implementation NewAttestationController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self createUI];
    [self createOther];
    [[IQKeyboardManager sharedManager] resignFirstResponder];
}
// 创建UI
- (void)createUI {
    [self scroll];
    [self attestation];
    
    [self setNavTitle:@"实名认证"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
}
// 创建其他
- (void)createOther {
    self.infoStr = [NSString stringWithFormat:@"审核未通过：%@",_backReason];
}
- (UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
        _scroll.delegate = self;
        _scroll.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scroll];
    }
    return _scroll;
}
- (AttestationView *)attestation {
    if (!_attestation) {  //self.scroll.bounds
         _attestation = [AttestationView initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
        if (_isRegister == 5) {
            _attestation.mobilephone = _mobilephone;
            _attestation.password = _password;
        }else {
            NSString *phone = GetAccount;
            _attestation.mobilephone = phone;
            NSString *userpwd = GetPassword;
            _attestation.password = userpwd;
        }
        [self.scroll addSubview:_attestation];
        [self.scroll setContentSize:CGSizeMake(0, _attestation.height)];
    }
    return _attestation;
}

#pragma mark 键盘
- (void)keyboardDidShow:(NSNotification *)not {
    UITextField *first = [_attestation getFirst];
    
    
    CGRect keyBoardEndFrame = [[not.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 被挡住了 || 手机是iphone4s
    if (((CGRectGetMaxY(first.frame) + 64) > keyBoardEndFrame.origin.y)) {
        CGFloat moveH = CGRectGetMaxY(first.frame) - keyBoardEndFrame.origin.y;
        if ((moveH > 0 && ScreenHeight == 480) || ScreenHeight != 480) {
            [UIView animateWithDuration:0.25 animations:^{
                self.view.y = -moveH - 64;
            }];
        }
    }
    
}
- (void)keyboardDidHide:(NSNotification *)not {
    [UIView animateWithDuration:0.25 animations:^{
        self.view.y = 0;
    }];
}

#pragma mark 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    manager.shouldResignOnTouchOutside = NO;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = NO;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.view endEditing:YES];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}


@end

