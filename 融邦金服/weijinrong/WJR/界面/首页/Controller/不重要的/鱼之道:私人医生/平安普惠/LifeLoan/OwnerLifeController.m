//
//  OwnerLifeController.m
//  chengzizhifu
//
//  Created by RY on 16/5/18.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "OwnerLifeController.h"
#import "LoadRequestModel.h"
#import "TSLocateView.h"
#import "Unity.h"

@interface OwnerLifeController () <UIScrollViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITextField *name;        //名字
@property (nonatomic, strong) UITextField *cardID;      //身份照
@property (nonatomic, strong) UITextField *phoneNum;    //手机号
@property (nonatomic, strong) UITextField *company;        //保险公司
@property (nonatomic, strong) UITextField *returnPrice;    //年缴费
@property (nonatomic, strong) UIButton *city;               //城市
@property (nonatomic, strong) UILabel *cityLab;           //城市名
@property (nonatomic, strong) UITextField *currentField;    //当前正在编辑的

@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *cityName;

@end

@implementation OwnerLifeController

#pragma mark - 父类重写
- (void)createNavigation{
    self.navTitle =  @"寿险贷";
}

- (void)leftBtnPressed:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self showUI];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)showUI {
    CGFloat width = self.view.width;
    CGFloat height = 40;
    CGFloat marign = 5;
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scroll.showsVerticalScrollIndicator = NO;
    scroll.delegate = self;
    [self.view addSubview:scroll];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [scroll addGestureRecognizer:tap];
    
    //title
    [Unity lableViewAddsuperview_superView:scroll _subViewFrame:CGRectMake(0, 0, width, 40) _string:@"个人信息填写" _lableFont:[UIFont systemFontOfSize:20] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentCenter];
    //line
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 45, width, 1)];
    line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [scroll addSubview:line];
    
    self.name = [Unity textFieldWithLeftViewAddSuperview_superView:scroll _subViewFrame:CGRectMake(40, CGRectGetMaxY(line.frame)+30, width-80, height) _placeT:@"姓  名：" _backgroundImage:[UIImage imageNamed:@"空白框"] _delegate:self andSecure:NO andBackGroundColor:nil];
    
    self.cardID = [Unity textFieldWithLeftViewAddSuperview_superView:scroll _subViewFrame:CGRectMake(40, CGRectGetMaxY(self.name.frame)+marign, width-80, height) _placeT:@"身份证：" _backgroundImage:[UIImage imageNamed:@"空白框"] _delegate:self andSecure:NO andBackGroundColor:nil];
    
    self.phoneNum = [Unity textFieldWithLeftViewAddSuperview_superView:scroll _subViewFrame:CGRectMake(40, CGRectGetMaxY(self.cardID.frame)+marign, width-80, height) _placeT:@"联系方式：" _backgroundImage:[UIImage imageNamed:@"空白框"] _delegate:self andSecure:NO andBackGroundColor:nil];
    self.phoneNum.keyboardType = UIKeyboardTypeNumberPad;

    self.company = [Unity textFieldWithLeftViewAddSuperview_superView:scroll _subViewFrame:CGRectMake(40, CGRectGetMaxY(self.phoneNum.frame)+marign, width-80, height) _placeT:@"保险公司：" _backgroundImage:[UIImage imageNamed:@"空白框"] _delegate:self andSecure:NO andBackGroundColor:nil];
    
    self.returnPrice = [Unity textFieldWithLeftViewAddSuperview_superView:scroll _subViewFrame:CGRectMake(40, CGRectGetMaxY(self.company.frame)+marign, width-80, height) _placeT:@"年缴费：" _backgroundImage:[UIImage imageNamed:@"空白框"] _delegate:self andSecure:NO andBackGroundColor:nil];
    self.returnPrice.keyboardType = UIKeyboardTypeDecimalPad;

    self.city = [Unity buttonAddsuperview_superView:scroll _subViewFrame:CGRectMake(40, CGRectGetMaxY(self.returnPrice.frame)+marign, width-80, height) _tag:self _action:@selector(cityAction) _string:@"" _imageName:@"loginbox_long.png"];
    [self.city setTitleColor:TitleColor forState:UIControlStateNormal];
    
    UIImageView * cardImage = [Unity imageviewAddsuperview_superView:self.city _subViewFrame:CGRectMake([Unity countcoordinatesX:30/2], (self.city.height-40/2)/2, [Unity countcoordinatesW:40/2], 40/2) _imageName:@"place.png" _backgroundColor:[UIColor clearColor]];
    self.cityLab= [Unity lableViewAddsuperview_superView:self.city _subViewFrame:CGRectMake(cardImage.right + [Unity countcoordinatesX:30/2], (self.city.height-25)/2,self.city.width - 2* [Unity countcoordinatesX:40/2]-[Unity countcoordinatesW:40/2],25) _string:Internationalization(@"Attestation_city") _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft ];
    [Unity imageviewAddsuperview_superView:self.city _subViewFrame:CGRectMake(CGRectGetMaxX(self.city.frame)-60, (self.city.height-27/2)/2,[Unity countcoordinatesX:16/2],27/2 ) _imageName:@"arrow_right.png" _backgroundColor:[UIColor clearColor]];
    
    //提交按钮
    UIButton *commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.city.frame)+40,  90, 35)];
    [commitBtn setTitle:@"提交资料" forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"橘色块"] forState:UIControlStateNormal];
    commitBtn.centerX = self.view.centerX;
    [commitBtn addTarget:self action:@selector(commitActin) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:commitBtn];
    
    scroll.contentSize = CGSizeMake(self.view.width, CGRectGetMaxY(commitBtn.frame)+60);
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma makr - 事件

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapAction {
    [self.view endEditing:YES];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    CGFloat maxBottom = self.currentField.height + self.currentField.top + 40;
    CGFloat keyBoardH = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue].size.height;
    if (maxBottom <= keyBoardH) {
        return;
    }
    
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -(maxBottom-keyBoardH));
    } completion:nil];
    
}

- (void)keyboardDidHidden:(NSNotification *)notification {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.view.transform = CGAffineTransformIdentity;
    } completion:nil];
}

/**
 *  选择城市
 */
- (void)cityAction {
    [self.view endEditing:YES];
    TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:Internationalization(@"Attestation_choiceCity") delegate:self];
    [locateView showInView:self.view];
}
/**
 *  城市选择代理
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        
    }else {
        TSLocateView *locateView = (TSLocateView *)actionSheet;
        TSLocation *location = locateView.locate;
        self.cityLab.text=[NSString stringWithFormat:@"%@ %@",location.state,location.city];
        self.provinceName = location.state;
        self.cityName = location.city;
    }
}

/**
 *  延迟返回
 */
- (void)daly {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

/**
 *  提交
 */
- (void)commitActin {
    NSString *mercId = [SaveManager getStringForKey:@"mercId"];   //商户号
    NSString *mercName = self.name.text;                                    //名字
    NSString *idCard = [self.cardID.text uppercaseString];                  //身份证号
    NSString *insuranceCompany = self.company.text;                          //保险公司
    NSString *yearPayment = self.returnPrice.text;                          //年缴费
    NSString *loanType = @"C1";                                 //类型 (A代表房屋贷款，B代表汽车贷款、C代表人寿贷款)
    NSString *phoneNum = self.phoneNum.text;                                //手机号
    
    if (![Unity validateIdentityCard:idCard]) {
        [self showTitle:@"身份证号码格式不正确" delay:1.5f];
        return;
    }
    if (mercId == nil) {
        [self showTitle:@"没有找到商户号" delay:1.5f];
        return;
    }
    if (self.cityName == nil || [self.cityName isEqualToString:@""] || self.provinceName == nil || [self.provinceName isEqualToString:@""]) {
        [self showTitle:@"请选择城市" delay:1.5f];
        return;
    }
    
    NSDictionary *dict = @{@"mercId":mercId,@"mercName":mercName,@"insuranceCompany":insuranceCompany,@"yearPayment":yearPayment,@"loanType":loanType,@"idCard":idCard,@"phoneNumber":phoneNum,@"province":self.provinceName,@"city":self.cityName};
    
    for (NSString *str in dict.allValues) {
        if (str == nil || [str isEqualToString:@""]) {
            [self showTitle:@"请填完整信息" delay:1.5f];
            return;
        }
    }
    
    
//    NSString *dictStr = [self dictionaryToJson:dict];
    [self showTitle:@"正在提交" delay:1.5f];
    [DongManager loanInfo:dict success:^(id requestData) {
        [self hidesBottomBarWhenPushed];
        LoadRequestModel *model = [LoadRequestModel decryptBecomeModel:requestData];
        if (model.retCode == 0) {
            [self showTitle:model.retMessage delay:1.5f];
            [self daly];
        }else{
            [self showTitle:model.retMessage delay:1.5f];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}

#pragma makr - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentField = textField;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == self.name) {
        return textField.text.length > 5 ? NO:YES;
    }else if (textField == self.company){
        return textField.text.length > 15 ? NO:YES;
    }else if (textField == self.returnPrice) {
        return textField.text.length > 10 ? NO:YES;
    }
    
    return YES;
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


@end
