//
//  SetPwdViewController.m
//  chengzizhifu
//
//  Created by 快易 on 15/1/6.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "SetPwdViewController.h"
#import "SetPwdModel.h"
#import "CodeModel.h"
#import "Unity.h"
#import "DongManager.h"

#define ViewFrame CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)

#pragma mark - 声明
@interface SetPwdViewController ()<UITextFieldDelegate>

@property (nonatomic,retain) UIView * backGroundView;
@property (nonatomic,retain) UITextField * oldText;
@property (nonatomic,retain) UITextField * xText;
@property (nonatomic,retain) UITextField * confirmText;
@property (nonatomic,retain) UITextField * codeText;
@property (nonatomic,retain) NSTimer * timer;
@property (nonatomic,retain) UIButton * blueBtn;

@end

#pragma mark - 实现
@implementation SetPwdViewController {
    NSInteger  buttonIndex;
}
- (void)dealloc {
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    buttonIndex=120;
    [self.view addSubview:[self bGroundView]];
}

- (void)createNavigation{
    [self setNavTitle:@"密码修改"];
}

- (UIView *)bGroundView {
    if (self.backGroundView==nil) {
        self.backGroundView = [Unity backviewAddview_subViewFrame:ViewFrame _viewColor:[UIColor whiteColor]];
        UIImageView *phoneImg = [Unity imageviewAddsuperview_superView:self.backGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2], [Unity countcoordinatesY:40/2], ScreenWidth-2*[Unity countcoordinatesX:40/2], 75/2) _imageName:@"loginbox_long.png" _backgroundColor:[UIColor clearColor]];
        phoneImg.userInteractionEnabled=YES;
        UIImageView *name = [Unity imageviewAddsuperview_superView:phoneImg _subViewFrame:CGRectMake([Unity countcoordinatesX:30/2], (phoneImg.height-40/2)/2, [Unity countcoordinatesW:40/2], 40/2) _imageName:@"password_press.png" _backgroundColor:[UIColor clearColor]];
        self.oldText = [Unity textFieldAddSuperview_superView:phoneImg _subViewFrame:CGRectMake(name.right + [Unity countcoordinatesX:30/2], (phoneImg.height-25)/2,phoneImg.width - 2* [Unity countcoordinatesX:40/2]-[Unity countcoordinatesW:40/2],25) _placeT:@"输入旧密码" _backgroundImage:[UIImage imageNamed:@""] _delegate:self andSecure:YES andBackGroundColor:[UIColor clearColor]];
        
        UIImageView * QphoneImg = [Unity imageviewAddsuperview_superView:self.backGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2], phoneImg.top+phoneImg.height+[Unity countcoordinatesX:20/2], ScreenWidth-2*[Unity countcoordinatesX:40/2],75/2) _imageName:@"loginbox_long.png" _backgroundColor:[UIColor clearColor]];
        UIImageView * name1 = [Unity imageviewAddsuperview_superView:QphoneImg _subViewFrame:CGRectMake([Unity countcoordinatesX:30/2], (QphoneImg.height-40/2)/2, [Unity countcoordinatesW:40/2], 40/2) _imageName:@"password.png" _backgroundColor:[UIColor clearColor]];
        self.xText = [Unity textFieldAddSuperview_superView:QphoneImg _subViewFrame:CGRectMake(name1.right + [Unity countcoordinatesX:30/2], (QphoneImg.height-25)/2,QphoneImg.width - 2* [Unity countcoordinatesX:40/2]-[Unity countcoordinatesW:40/2],25) _placeT:@"输入新密码" _backgroundImage:[UIImage imageNamed:@""] _delegate:self andSecure:YES andBackGroundColor:[UIColor clearColor]];
        QphoneImg.userInteractionEnabled=YES;
        
        UIImageView * QpwdImg = [Unity imageviewAddsuperview_superView:self.backGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2], QphoneImg.top+QphoneImg.height+[Unity countcoordinatesX:20/2], ScreenWidth-2*[Unity countcoordinatesX:40/2], 75/2) _imageName:@"loginbox_long.png" _backgroundColor:[UIColor clearColor]];
        UIImageView * name2 = [Unity imageviewAddsuperview_superView:QpwdImg _subViewFrame:CGRectMake([Unity countcoordinatesX:30/2], (QpwdImg.height-40/2)/2, [Unity countcoordinatesW:40/2], 40/2) _imageName:@"password.png" _backgroundColor:[UIColor clearColor]];
        self.confirmText = [Unity textFieldAddSuperview_superView:QpwdImg _subViewFrame:CGRectMake(name2.right + [Unity countcoordinatesX:30/2], (QpwdImg.height-25)/2,QpwdImg.width - 2* [Unity countcoordinatesX:40/2]-[Unity countcoordinatesW:40/2],25) _placeT:@"确认新密码" _backgroundImage:[UIImage imageNamed:@""] _delegate:self andSecure:YES andBackGroundColor:[UIColor clearColor]];
        QpwdImg.userInteractionEnabled=YES;
        
        UIImageView * newsImg = [Unity imageviewAddsuperview_superView:self.backGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2],QpwdImg.top+QpwdImg.height+[Unity countcoordinatesY:40/2] , ScreenWidth-2*[Unity countcoordinatesX:40/2],75/2 ) _imageName:@"loginbox_long.png" _backgroundColor:[UIColor clearColor]];
        newsImg.userInteractionEnabled=YES;
        UIImageView * MImage = [Unity imageviewAddsuperview_superView:newsImg _subViewFrame:CGRectMake([Unity countcoordinatesX:30/2], (newsImg.height-40/2)/2, [Unity countcoordinatesW:40/2], 40/2) _imageName:@"verification.png" _backgroundColor:[UIColor clearColor]];
        self.codeText = [Unity textFieldAddSuperview_superView:newsImg _subViewFrame:CGRectMake(MImage.right + [Unity countcoordinatesX:30/2],(newsImg.height -25)/2,newsImg.width - 2 * [Unity countcoordinatesX:40/2]-[Unity countcoordinatesW:40/2],25 ) _placeT:@"验证码"  _backgroundImage:[UIImage imageNamed:@""] _delegate:self andSecure:NO andBackGroundColor:[UIColor clearColor]];
        
        UIButton * blueBtn=[Unity buttonAddsuperview_superView:self.backGroundView _subViewFrame:CGRectMake(newsImg.right - [Unity countcoordinatesX:200/2], newsImg.top, [Unity countcoordinatesX:200/2], 75/2) _tag:self _action:@selector(blueClick:) _string:@"获取验证码" _imageName:@""];
        self.blueBtn=blueBtn;
        blueBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [blueBtn setTitleColor:StreamColor forState:UIControlStateNormal];
//        [blueBtn setBackgroundImage:[UIImage imageNamed:@"blue_button_short.png"] forState:UIControlStateNormal];
//        [blueBtn setBackgroundImage:[UIImage imageNamed:@"blue_button_short_press.png"] forState:UIControlStateHighlighted];
        
        UIButton * registerB = [Unity buttonAddsuperview_superView:self.backGroundView _subViewFrame:CGRectMake(phoneImg.left, blueBtn.top+ blueBtn.height+ [Unity countcoordinatesY:80/2], phoneImg.width, 75/2) _tag:self _action:@selector(registerBClick:) _string:@"保存" _imageName:@""];
        [registerB setBackgroundImage:[UIImage imageNamed:@"orange_button.png"] forState:UIControlStateNormal];
        [registerB setBackgroundImage:[UIImage imageNamed:@"orange_button_press.png"] forState:UIControlStateHighlighted];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(newsImg.right - [Unity countcoordinatesX:200/2], newsImg.top + 3, 1, 75/2 - 6)];
        line.backgroundColor = RGB(233, 233, 233, 1);
        [self.backGroundView addSubview:line];
        
        
    }
    return self.backGroundView;
}

- (void)creatTimer{
    self.timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(appAction) userInfo:nil repeats:YES];
}

- (void)appAction{
    [self.blueBtn setTitle:[NSString stringWithFormat:@"%ld",(long)buttonIndex--] forState:UIControlStateNormal];
    if (buttonIndex<=0) {
        [_timer setFireDate:[NSDate distantFuture]];
        [self.blueBtn setTitle:[NSString stringWithFormat:Internationalization(@"againButton")] forState:UIControlStateNormal];
        buttonIndex=120;
    }
}

//发送验证码
- (void)sendViceCodeNumber:(NSString *)tel {
    [self.view endEditing:YES];
    if (tel == nil || [tel isEqualToString:@""]) {
        [self showTitle:@"请重新登录" delay:1];
    }else {
        [self showHudLoadingView:@"正在获取..."];
        NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:tel,@"mobilePhone",@"2",@"mark", nil];
        
        
        [DongManager getCode:params success:^(id requestData) {
            [self hiddenHudLoadingView];
            CodeModel *model = [CodeModel decryptBecomeModel:requestData];
            [self showTitle:model.retMessage delay:1];
            if (model.retCode == 0) {
                if (self.timer==nil) {
                    [self creatTimer];
                }else{
                    [self.timer setFireDate:[NSDate distantPast]];
                }
            }

        } fail:^(NSError *error) {
            [self showNetFail];
        }];
    }
}


- (void)blueClick:(UIButton *)button {
    if (buttonIndex==120) {
        self.codeText.text = @"";
        [self sendViceCodeNumber:GetAccount];
    }
}

//密码修改保存
- (void)registerBClick:(UIButton *)btn {
    [self.view endEditing:YES];
    if (self.oldText.text==nil||[self.oldText.text isEqualToString:@""]) {
        [self showTitle:@"请输入旧密码" delay:1];
    }else if (self.xText.text==nil||[self.xText.text isEqualToString:@""]) {
        [self showTitle:@"请输入新密码" delay:1];
    }else if (self.confirmText.text==nil||
              [self.confirmText.text isEqualToString:@""]||
              ![self.confirmText.text isEqualToString:self.xText.text]) {
        [self showTitle:@"两次密码不一致" delay:1];
    }else if ([self.codeText.text isEqualToString:@""]||self.codeText.text==nil){
        [self showTitle:@"请输入验证码" delay:1];
    }else {
        
        NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:
                                GetAccount,@"mobilePhone",
                                [self.xText.text md5],@"newPassword",
                                [self.oldText.text md5],@"oldPassword",
                                self.codeText.text,@"messageAuthenticationCode",nil];
        
        
        [self showHudLoadingView:@"正在修改..."];
        [DongManager changePass:params success:^(id requestData) {
            [self hiddenHudLoadingView];
            SetPwdModel *model = [SetPwdModel decryptBecomeModel:requestData];
            [self showTitle:model.retMessage delay:1];
            if (model.retCode == 0) {
                SavePassword(_xText.text);
                [self popDelay];
                NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^%@",requestData);
            }
        } fail:^(NSError *error) {
            [self showNetFail];
        }];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.oldText resignFirstResponder];
    [self.xText resignFirstResponder];
    [self.confirmText resignFirstResponder];
    [self.codeText resignFirstResponder];
    __weak SetPwdViewController * weak = self;
    [UIView animateWithDuration:.25f animations:^{
        weak.backGroundView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    } completion:^(BOOL finished) {
    }];

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==self.codeText) {
        __weak SetPwdViewController * weak = self;
        [UIView animateWithDuration:.25f animations:^{
            weak.backGroundView.frame = CGRectMake(0, -26, ScreenWidth, ScreenHeight);
        } completion:^(BOOL finished) {
        }];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.oldText resignFirstResponder];
    [self.xText resignFirstResponder];
    [self.confirmText resignFirstResponder];
    [self.codeText resignFirstResponder];
    __weak SetPwdViewController * weak = self;
    [UIView animateWithDuration:.25f animations:^{
        weak.backGroundView.frame=CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64);
    } completion:^(BOOL finished) {
    }];
    return YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    manager.shouldResignOnTouchOutside = NO;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = NO;

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;

}


@end
