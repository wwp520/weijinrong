//
//  NewChangeBankController.m
//  chengzizhifu
//
//  Created by 快易 on 15/1/19.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//
#import "NewChangeBankController.h"
#import "AddCardModel.h"
#import "BankListViewController.h"
#import "Unity.h"
#import "TSLocateView.h"
#define ViewFrame CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)
@interface NewChangeBankController ()<UITextFieldDelegate>
@property (nonatomic,retain) UIView * bGroundView;
@property (nonatomic,retain) UILabel * praceLab;
@property (nonatomic,retain) UILabel * bankLab;
@property (nonatomic,retain) UITextField * pwdText;
@property (nonatomic,retain) UITextField * cardText;
@property (nonatomic,copy) void (^changePraceBlock)(NSString * str);
@property (nonatomic,copy) NSString * bankName;
@property (nonatomic,copy) NSString * cardName;
@property (nonatomic,copy) NSString * bankCode;

@property (nonatomic,copy) NSString * province_id; //省份ID
@property (nonatomic,copy) NSString * city_id;     //城市ID
@property (nonatomic,retain) UIView * blackView;
@property (nonatomic,retain) UIButton * cityButton;
@property (nonatomic,retain) UILabel * cityLab;
@property (nonatomic,copy) NSString * cardString;
@end

@implementation NewChangeBankController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self.view addSubview:[self BackGView]];
    [self createblackView];
}

- (void)createblackView{
    self.blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.blackView.alpha = 0;
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.hidden = YES;
    [self.view addSubview:self.blackView];
}
- (void)cityButtonClick:(UIButton *)button{
    self.blackView.hidden = NO;
    __weak NewChangeBankController * weak = self;
    [UIView animateWithDuration:.4f animations:^{
        weak.blackView.alpha = .4f;
    } completion:nil];
    [self.pwdText resignFirstResponder];
    [self.cardText resignFirstResponder];
    TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:@"地区选择" delegate:self];
    [locateView showInView:self.view];
    
}

#pragma mark 网络接口
//更换银行卡
- (void)affirmB:(UIButton *)button {
    NSArray * array=[self.pwdText.text componentsSeparatedByString:@" "];
    if (array.count>0) {
        self.cardString=[array componentsJoinedByString:@""];
    }
    if ([self.pwdText.text isEqualToString:@""]) {
        [self showTitle:@"银行卡号不能为空" delay:1];
    }else if (![KKTools isValidCreditNumber:self.cardString]) {
        [self showTitle:@"银行卡号格式不正确" delay:1];
    }else if (![self.pwdText.text isEqualToString:self.cardText.text]) {
        [self showTitle:@"两次输入银行卡号不一致" delay:1];
    }else if ([self.cardName isEqualToString:@""]) {
        [self showTitle:@"网络数据未返回" delay:1];
    }else if ([self.province_id isEqualToString:@""]||self.province_id==nil) {
        [self showTitle:@"城市不能为空" delay:1];
    }else if ([self.bankCode isEqualToString:@""]||self.bankCode==nil) {
        [self showTitle:@"未选择银行卡" delay:1];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       self.bankName,@"bankname",
                                       self.praceLab.text,@"settlenentname",
                                       self.cardString,@"clrmerc",
                                       [SaveManager getStringForKey:@"mercId"],@"mercId",
                                       nil];
        
        
       
        [self showHudLoadingView:@"正在更换请稍后"];
        [DongManager changeBankCard:params success:^(id requestData) {
            [self hiddenHudLoadingView];
            BaseModel *model = [BaseModel decryptBecomeModel:requestData];
            [self showTitle:model.retMessage delay:1];
            if (model.retCode == 0) {
                [self popDelay];
                [_vc getInfo];
                NSLog(@"--------------- 更换成功——————————————————");
            }else {
                
            }
        } fail:^(NSError *error) {
            [self hiddenHudLoadingView];
        }];
    }
}


#pragma mark  UITextFeild delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // 四位加一个空格
    if ([string isEqualToString:@""]) { // 删除字符
        if (textField.text.length>0) {
            if ((textField.text.length - 1) % 5 == 0) {
                textField.text = [textField.text substringToIndex:textField.text.length - 1];
            }
            return YES;
        }
    } else {
        if ((textField.text.length +1)% 5 == 0) {
            textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
        }
    }
    return YES;
}

- (void)choiceButtonClick:(UIButton *)button{
    BankListViewController * bvc=[[BankListViewController alloc]init];
    __weak NewChangeBankController * weak= self;
    bvc.changeBlock=^(NSString * bankNames,NSString * bankid){
        weak.bankLab.text=bankNames;
        weak.bankName=bankNames;
        weak.bankCode=bankid;
    };
    [self.navigationController pushViewController:bvc animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __weak NewChangeBankController * weak = self;
    [UIView animateWithDuration:.4f animations:^{
        weak.blackView.alpha = 0;
    } completion:^(BOOL finished) {
        weak.blackView.hidden = YES;
    }];
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select");
        TSLocateView *locateView = (TSLocateView *)actionSheet;
        TSLocation *location = locateView.locate;
        self.cityLab.text=[NSString stringWithFormat:@"%@%@",location.state,location.city];
        self.province_id = location.province_id;
        self.city_id = location.city_id;
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.pwdText resignFirstResponder];
    [self.cardText resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.pwdText resignFirstResponder];
    [self.cardText resignFirstResponder];
    return YES;
}

- (UIView *)BackGView{
    if (self.bGroundView==nil) {
        self.bGroundView=[Unity backviewAddview_subViewFrame:ViewFrame _viewColor:[UIColor whiteColor]];
        UILabel * business=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2],0, [Unity countcoordinatesX:150/2] , 40) _string:[NSString stringWithFormat:@"开户姓名:"] _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        self.praceLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(business.right+[Unity countcoordinatesX:10], 0, [Unity countcoordinatesW:200], 40) _string:[NSString stringWithFormat:@"%@",_shortName] _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        UILabel * linelab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(0, self.praceLab.top+self.praceLab.height, ScreenWidth, 1) _string:@"" _lableFont:TitleSize _lableTxtColor:[UIColor clearColor] _textAlignment:NSTextAlignmentLeft];
        linelab.backgroundColor=LineColor;
        
        UIImageView * phoneImg = [Unity imageviewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2], linelab.top+linelab.height+[Unity countcoordinatesY:40/2], ScreenWidth-[Unity countcoordinatesX:40/2]*2, 75/2) _imageName:@"loginbox_long.png" _backgroundColor:[UIColor clearColor]];
        phoneImg.userInteractionEnabled=YES;
        UIImageView * name = [Unity imageviewAddsuperview_superView:phoneImg _subViewFrame:CGRectMake([Unity countcoordinatesX:30/2], (phoneImg.height-40/2)/2, [Unity countcoordinatesW:40/2], 40/2) _imageName:@"银行卡.png" _backgroundColor:[UIColor clearColor]];
        self.pwdText = [Unity textFieldAddSuperview_superView:phoneImg _subViewFrame:CGRectMake(name.right + [Unity countcoordinatesX:30/2], (phoneImg.height-25)/2,phoneImg.width - 2* [Unity countcoordinatesX:40/2]-[Unity countcoordinatesW:40/2],25) _placeT:@"收款银行卡号" _backgroundImage:[UIImage imageNamed:@""] _delegate:self andSecure:NO andBackGroundColor:[UIColor clearColor]];
        self.pwdText.keyboardType = UIKeyboardTypeNumberPad;
        UIImageView * newsImg = [Unity imageviewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2],phoneImg.top+phoneImg.height+[Unity countcoordinatesY:20/2] , ScreenWidth-[Unity countcoordinatesX:40/2]*2,75/2) _imageName:@"loginbox_long.png" _backgroundColor:[UIColor clearColor]];
        newsImg.userInteractionEnabled=YES;
        UIImageView * MImage = [Unity imageviewAddsuperview_superView:newsImg _subViewFrame:CGRectMake([Unity countcoordinatesX:30/2], (newsImg.height-40/2)/2, [Unity countcoordinatesW:40/2], 40/2) _imageName:@"银行卡.png" _backgroundColor:[UIColor clearColor]];
        self.cardText = [Unity textFieldAddSuperview_superView:newsImg _subViewFrame:CGRectMake(MImage.right + [Unity countcoordinatesX:30/2], (newsImg.height-25)/2,newsImg.width - 2* [Unity countcoordinatesX:40/2]-[Unity countcoordinatesW:40/2],25) _placeT:@"再次输入卡号" _backgroundImage:[UIImage imageNamed:@""] _delegate:self andSecure:NO andBackGroundColor:[UIColor clearColor]];
        self.cardText.keyboardType = UIKeyboardTypeNumberPad;
        
        
        UILabel * tsPracelab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2], newsImg.top+newsImg.height+[Unity countcoordinatesY:40/2], [Unity countcoordinatesW:150], 30) _string:@"请选择开户省市" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        
        UIButton * cityButton=[Unity buttonAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2], tsPracelab.top + tsPracelab.height +[Unity countcoordinatesY:10/2], ScreenWidth-2* [Unity countcoordinatesX:40/2], 75/2) _tag:self _action:@selector(cityButtonClick:) _string:@"" _imageName:@"loginbox_long.png"];
        [cityButton setTitleColor:TitleColor forState:UIControlStateNormal];
        self.cityButton=cityButton;
        
        UIImageView * cardImage = [Unity imageviewAddsuperview_superView:cityButton _subViewFrame:CGRectMake([Unity countcoordinatesX:30/2], (cityButton.height-40/2)/2, [Unity countcoordinatesW:40/2], 40/2) _imageName:@"place.png" _backgroundColor:[UIColor clearColor]];
        self.cityLab= [Unity lableViewAddsuperview_superView:cityButton _subViewFrame:CGRectMake(cardImage.right + [Unity countcoordinatesX:30/2], (cityButton.height-25)/2,cityButton.width - 2* [Unity countcoordinatesX:40/2]-[Unity countcoordinatesW:40/2],25) _string:@"请选择城市" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft ];
        [Unity imageviewAddsuperview_superView:cityButton _subViewFrame:CGRectMake(ScreenWidth-2 * [Unity countcoordinatesX:30/2]-[Unity countcoordinatesX:40/2]-[Unity countcoordinatesX:16/2], (cityButton.height-27/2)/2,[Unity countcoordinatesX:16/2],27/2 ) _imageName:@"arrow_right.png" _backgroundColor:[UIColor clearColor]];
        
        UIButton * choiceButton=[Unity buttonAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2], cityButton.top + cityButton.height +[Unity countcoordinatesY:20/2], ScreenWidth-2* [Unity countcoordinatesX:40/2], 75/2) _tag:self _action:@selector(choiceButtonClick:) _string:@"" _imageName:@"loginbox_long.png"];
        
        UIImageView * MImage1 = [Unity imageviewAddsuperview_superView:choiceButton _subViewFrame:CGRectMake([Unity countcoordinatesX:30/2], (choiceButton.height-40/2)/2, [Unity countcoordinatesW:40/2], 40/2) _imageName:@"银行卡.png" _backgroundColor:[UIColor clearColor]];
        self.bankLab =[Unity lableViewAddsuperview_superView:choiceButton _subViewFrame:CGRectMake(MImage1.right+[Unity countcoordinatesX:30/2], (choiceButton.height-25)/2, choiceButton.width - 2* [Unity countcoordinatesX:40/2]-[Unity countcoordinatesW:40/2], 25) _string:[NSString stringWithFormat:@"收款银行名称"] _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        __weak NewChangeBankController * weak=self;
        self.changePraceBlock=^(NSString * str){
            weak.praceLab.text=[NSString stringWithFormat:@"%@",str];
        };
        [Unity imageviewAddsuperview_superView:choiceButton _subViewFrame:CGRectMake(ScreenWidth-2 * [Unity countcoordinatesX:30/2]-[Unity countcoordinatesX:40/2]-[Unity countcoordinatesX:16/2], (choiceButton.height-27/2)/2,[Unity countcoordinatesX:16/2],27/2 ) _imageName:@"arrow_right.png" _backgroundColor:[UIColor clearColor]];
        UILabel * lab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(choiceButton.left, choiceButton.top+ choiceButton.height+[Unity countcoordinatesY:10/2], ScreenWidth-2*[Unity countcoordinatesX:20], [Unity countcoordinatesY:50/2]) _string:@"注意!请认真填写信息,一经确认,不可更改" _lableFont:[UIFont systemFontOfSize:13] _lableTxtColor:OrangeColor _textAlignment:NSTextAlignmentCenter];
        lab.centerX = self.view.centerX;
        lab.numberOfLines=0;
        
        UIButton * affirmB=[Unity buttonAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(newsImg.left, lab.top+lab.height+[Unity countcoordinatesY:80/2], ScreenWidth-[Unity countcoordinatesX:40/2]*2,75/2) _tag:self _action:@selector(affirmB:) _string:@"保存" _imageName:@""];
        [affirmB setBackgroundImage:[UIImage imageNamed:@"orange_button.png"] forState:UIControlStateNormal];
        [affirmB setBackgroundImage:[UIImage imageNamed:@"orange_button_press.png"] forState:UIControlStateHighlighted];
        
    }
    return self.bGroundView;
}





- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}
- (void)createNavigation{
    [self setNavTitle:@"更换银行卡"];
}
- (void)leftBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
