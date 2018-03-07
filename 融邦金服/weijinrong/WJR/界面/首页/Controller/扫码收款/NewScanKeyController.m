//
//  NewScanKeyController.m
//  chengzizhifu
//
//  Created by Mac on 16/8/31.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "NewScanKeyController.h"
//#import "AlipayPayController.h"
#import "WeiChatCoderModel.h"
#import "WeiChatPayModel.h"
//#import "WebViewController.h"
#import "AlipayField.h"
#import "MaxPraceModel.h"
#import "NewScanResultController.h"

#define myDotNumbers     @"0123456789.\n"
#define myNumbers        @"0123456789\n"
#pragma mark 声明
@interface NewScanKeyController ()

@property (nonatomic, retain) AlipayField *receivablesTextFiled;
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, strong) UIButton *rate1Btn;
@property (nonatomic, strong) UIButton *rate2Btn;
@property (nonatomic, assign) int currentRate;  //当前费率 0：0.5秒到  1：0.4T+1

@property (nonatomic, weak) UIButton *numberBtn0;
@property (nonatomic, weak) UIButton *numberBtn1;
@property (nonatomic, weak) UIButton *numberBtn2;
@property (nonatomic, weak) UIButton *numberBtn3;
@property (nonatomic, weak) UIButton *numberBtn4;
@property (nonatomic, weak) UIButton *numberBtn5;
@property (nonatomic, weak) UIButton *numberBtn6;
@property (nonatomic, weak) UIButton *numberBtn7;
@property (nonatomic, weak) UIButton *numberBtn8;
@property (nonatomic, weak) UIButton *numberBtn9;
@property (nonatomic, weak) UIButton *numberBtn10;
@property (nonatomic, weak) UIButton *numberBtn11;
@property (nonatomic, weak) UIButton *numberBtn;

@end

#pragma mark 实现
@implementation NewScanKeyController


#pragma mark - 父类重写
- (void)createNavigation{
    [self setNavTitle:@"扫码收款"];
}


#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self setupReceivables];
    [self setupnumberBtn];
    [self setPhone:GetAccount];
    [self.view setBackgroundColor:[UIColor colorWithRed:243/255.0 green:248/255.0 blue:250/255.0 alpha:1.0]];
}

- (void)setupReceivables {
    /** 顶部view */
    CGFloat numberBtnW = ScreenWidth;
    CGFloat numberBtnH = 44;
    CGFloat startY = 0;
    CGFloat x = 0;
    CGFloat y = startY;
    UIView *rateAndtsView = [[UIView alloc] init];
    rateAndtsView.frame = CGRectMake(x, y, numberBtnW, numberBtnH);
    rateAndtsView.backgroundColor = [UIColor whiteColor];
    
    UIView *rateView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, rateAndtsView.width-20, rateAndtsView.height)];
    
    UILabel *rateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 90, 35)];
//    rateLabel.text = @"费率:0.49%";
    rateLabel.font = [UIFont systemFontOfSize:15];
    [rateView addSubview:rateLabel];
    
//    self.rate1Btn = [[UIButton alloc]initWithFrame:CGRectMake(rateLabel.right, (47-35)/2, 75, 35)];
//    [self.rate1Btn setImage:[UIImage imageNamed:@"redio_button"] forState:UIControlStateNormal];
//    [self.rate1Btn setImage:[UIImage imageNamed:@"redio_button_press"] forState:UIControlStateSelected];
//    [self.rate1Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.rate1Btn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [self.rate1Btn addTarget:self action:@selector(changeRate:) forControlEvents:UIControlEventTouchUpInside];
//    [self.rate1Btn setTitle:@"  0.49%" forState:UIControlStateNormal];
//    [rateView addSubview:self.rate1Btn];
    
    [self.view addSubview:rateView];
    //默认为0.5
    [self.rate1Btn setSelected:true];
    self.currentRate = 0;
    
    /** 输入金额 */
    UIView *inputAndavailable = [[UIView alloc] init];
    inputAndavailable.frame = CGRectMake(0, CGRectGetMaxY(rateAndtsView.frame), ScreenWidth, 64);
    
    AlipayField *receivablesTextFiled = [[AlipayField alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    receivablesTextFiled.placeholder = @"输入刷卡金额";
    [receivablesTextFiled becomeFirstResponder];
    receivablesTextFiled.backgroundColor = [UIColor whiteColor];
    receivablesTextFiled.textAlignment = NSTextAlignmentRight;
    receivablesTextFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    receivablesTextFiled.font = [UIFont boldSystemFontOfSize:20];
    // 设置右边显示一个view
    UIImageView *rightView = [[UIImageView alloc] init];
    rightView.width = 10;
    rightView.height = receivablesTextFiled.size.height;
    receivablesTextFiled.rightView = rightView;
    receivablesTextFiled.rightViewMode = UITextFieldViewModeAlways;
    receivablesTextFiled.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    [inputAndavailable addSubview:receivablesTextFiled];
    self.receivablesTextFiled = receivablesTextFiled;
    
    inputAndavailable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:inputAndavailable];
    
}

/** 数字键盘button */
- (void)setupnumberBtn
{
    for (int a=0; a<12;a++) {
        UIButton *numberBtn = [[UIButton alloc] init];
        
        // frame(2行3列)
        CGFloat numberBtnW = (self.view.width) / 3;
//        CGFloat numberBtnH = 60;
        CGFloat numberBtnH = (ScreenHeight - (64+44+60+64+40))/4;
        CGFloat marginX = 1;
        CGFloat marginY = 1;
        CGFloat startY = 107;
        CGFloat x = marginX + (a%3) * (marginX + numberBtnW);
        
        CGFloat y = startY + marginY + (a/3) * (marginY + numberBtnH);
        numberBtn.frame = CGRectMake(x, y, numberBtnW, numberBtnH);
        
        numberBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        numberBtn.backgroundColor = [UIColor whiteColor];
        // 标价
        NSArray *PfbArrayString = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".",@"0",@"del", nil];
        //        PfbArrayString = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".",@"0",@"del"];
        [numberBtn setTitle:PfbArrayString[a] forState:UIControlStateNormal];
        [numberBtn setTitle:PfbArrayString[a] forState:UIControlStateHighlighted];
        numberBtn.titleLabel.font = [UIFont boldSystemFontOfSize:26];
        [numberBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [numberBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        if ([numberBtn.titleLabel.text isEqualToString:@"del"]) {
            [numberBtn setTitle:@"" forState:UIControlStateNormal];
            [numberBtn setTitle:@"" forState:UIControlStateHighlighted];
            [numberBtn setImage:[UIImage imageNamed: @"del"] forState:UIControlStateNormal];
            self.numberBtn11 = numberBtn;
            [self.numberBtn11 addTarget:self action:@selector(delbtn) forControlEvents:UIControlEventTouchUpInside];
        } else if ([numberBtn.titleLabel.text isEqualToString:@"0"]) {
            self.numberBtn10 = numberBtn;
            [self.numberBtn10 addTarget:self action:@selector(zerobtn) forControlEvents:UIControlEventTouchUpInside];
        } else if ([numberBtn.titleLabel.text isEqualToString:@"."]) {
            self.numberBtn9 = numberBtn;
            [self.numberBtn9 addTarget:self action:@selector(pointbtn) forControlEvents:UIControlEventTouchUpInside];
        } else if ([numberBtn.titleLabel.text isEqualToString:@"9"]) {
            self.numberBtn8 = numberBtn;
            [self.numberBtn8 addTarget:self action:@selector(ninebtn) forControlEvents:UIControlEventTouchUpInside];
        } else if ([numberBtn.titleLabel.text isEqualToString:@"8"]) {
            self.numberBtn7 = numberBtn;
            [self.numberBtn7 addTarget:self action:@selector(eightbtn) forControlEvents:UIControlEventTouchUpInside];
        } else if ([numberBtn.titleLabel.text isEqualToString:@"7"]) {
            self.numberBtn6 = numberBtn;
            [self.numberBtn6 addTarget:self action:@selector(sevenbtn) forControlEvents:UIControlEventTouchUpInside];
        } else if ([numberBtn.titleLabel.text isEqualToString:@"6"]) {
            self.numberBtn5 = numberBtn;
            [self.numberBtn5 addTarget:self action:@selector(sixbtn) forControlEvents:UIControlEventTouchUpInside];
        } else if ([numberBtn.titleLabel.text isEqualToString:@"5"]) {
            self.numberBtn4 = numberBtn;
            [self.numberBtn4 addTarget:self action:@selector(fivebtn) forControlEvents:UIControlEventTouchUpInside];
        } else if ([numberBtn.titleLabel.text isEqualToString:@"4"]) {
            self.numberBtn3 = numberBtn;
            [self.numberBtn3 addTarget:self action:@selector(fourbtn) forControlEvents:UIControlEventTouchUpInside];
        } else if ([numberBtn.titleLabel.text isEqualToString:@"3"]) {
            self.numberBtn2 = numberBtn;
            [self.numberBtn2 addTarget:self action:@selector(threebtn) forControlEvents:UIControlEventTouchUpInside];
        } else if ([numberBtn.titleLabel.text isEqualToString:@"2"]) {
            self.numberBtn1 = numberBtn;
            [self.numberBtn1 addTarget:self action:@selector(twobtn) forControlEvents:UIControlEventTouchUpInside];
        } else if ([numberBtn.titleLabel.text isEqualToString:@"1"]) {
            self.numberBtn0 = numberBtn;
            [self.numberBtn0 addTarget:self action:@selector(onebtn) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.view addSubview:numberBtn];
        self.numberBtn = numberBtn;
    }
    /** 收款 */
    UIButton *receiveBtn = [[UIButton alloc] init];
    CGFloat receivebtnW = (ScreenWidth - 40);
    receiveBtn.frame = CGRectMake((ScreenWidth - receivebtnW)*0.5, CGRectGetMaxY(self.numberBtn.frame)+10, receivebtnW, 40);
    [receiveBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [receiveBtn setBackgroundImage:[UIImage imageNamed:@"orange_button"] forState:UIControlStateNormal];
    [receiveBtn setBackgroundImage:[UIImage imageNamed:@"orange_button_press"] forState:UIControlStateHighlighted];
    [self.view addSubview:receiveBtn];
    [receiveBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)delbtn
{
    NSLog(@"del");
    NSString *mString = self.receivablesTextFiled.text;
    if (mString.length) {
        self.receivablesTextFiled.text = [mString substringToIndex:(mString.length -1)];
    }
}
- (void)zerobtn
{
    NSLog(@"0");
    BOOL canWrite = [self textIsNumber:self.receivablesTextFiled.text range:NSMakeRange(self.receivablesTextFiled.text.length, self.receivablesTextFiled.text.length) str:@"0"];
    if (canWrite == NO) {
        return;
    }
    NSString *string = [self.receivablesTextFiled.text stringByAppendingString:@"0"];
    self.receivablesTextFiled.text = string;
}
- (void)pointbtn
{
    NSLog(@".");
    BOOL canWrite = [self textIsNumber:self.receivablesTextFiled.text range:NSMakeRange(self.receivablesTextFiled.text.length, self.receivablesTextFiled.text.length) str:@"."];
    if (canWrite == NO) {
        return;
    }
    NSString *string = [self.receivablesTextFiled.text stringByAppendingString:@"."];
    self.receivablesTextFiled.text = string;
}
- (void)ninebtn
{
    NSLog(@"9");
    BOOL canWrite = [self textIsNumber:self.receivablesTextFiled.text range:NSMakeRange(self.receivablesTextFiled.text.length, self.receivablesTextFiled.text.length) str:@"9"];
    if (canWrite == NO) {
        return;
    }
    NSString *string = [self.receivablesTextFiled.text stringByAppendingString:@"9"];
    self.receivablesTextFiled.text = string;
}
- (void)eightbtn
{
    NSLog(@"8");
    BOOL canWrite = [self textIsNumber:self.receivablesTextFiled.text range:NSMakeRange(self.receivablesTextFiled.text.length, self.receivablesTextFiled.text.length) str:@"8"];
    if (canWrite == NO) {
        return;
    }
    NSString *string = [self.receivablesTextFiled.text stringByAppendingString:@"8"];
    self.receivablesTextFiled.text = string;
}
- (void)sevenbtn
{
    NSLog(@"7");
    BOOL canWrite = [self textIsNumber:self.receivablesTextFiled.text range:NSMakeRange(self.receivablesTextFiled.text.length, self.receivablesTextFiled.text.length) str:@"7"];
    if (canWrite == NO) {
        return;
    }
    NSString *string = [self.receivablesTextFiled.text stringByAppendingString:@"7"];
    self.receivablesTextFiled.text = string;
}
- (void)sixbtn
{
    NSLog(@"6");
    BOOL canWrite = [self textIsNumber:self.receivablesTextFiled.text range:NSMakeRange(self.receivablesTextFiled.text.length, self.receivablesTextFiled.text.length) str:@"6"];
    if (canWrite == NO) {
        return;
    }
    NSString *string = [self.receivablesTextFiled.text stringByAppendingString:@"6"];
    self.receivablesTextFiled.text = string;
}
- (void)fivebtn
{
    NSLog(@"5");
    BOOL canWrite = [self textIsNumber:self.receivablesTextFiled.text range:NSMakeRange(self.receivablesTextFiled.text.length, self.receivablesTextFiled.text.length) str:@"5"];
    if (canWrite == NO) {
        return;
    }
    NSString *string = [self.receivablesTextFiled.text stringByAppendingString:@"5"];
    self.receivablesTextFiled.text = string;
}
- (void)fourbtn
{
    NSLog(@"4");
    BOOL canWrite = [self textIsNumber:self.receivablesTextFiled.text range:NSMakeRange(self.receivablesTextFiled.text.length, self.receivablesTextFiled.text.length) str:@"4"];
    if (canWrite == NO) {
        return;
    }
    NSString *string = [self.receivablesTextFiled.text stringByAppendingString:@"4"];
    self.receivablesTextFiled.text = string;
}
- (void)threebtn
{
    NSLog(@"3");
    BOOL canWrite = [self textIsNumber:self.receivablesTextFiled.text range:NSMakeRange(self.receivablesTextFiled.text.length, self.receivablesTextFiled.text.length) str:@"3"];
    if (canWrite == NO) {
        return;
    }
    NSString *string = [self.receivablesTextFiled.text stringByAppendingString:@"3"];
    self.receivablesTextFiled.text = string;
}
- (void)twobtn
{
    NSLog(@"2");
    BOOL canWrite = [self textIsNumber:self.receivablesTextFiled.text range:NSMakeRange(self.receivablesTextFiled.text.length, self.receivablesTextFiled.text.length) str:@"2"];
    if (canWrite == NO) {
        return;
    }
    NSString *string = [self.receivablesTextFiled.text stringByAppendingString:@"2"];
    self.receivablesTextFiled.text = string;
}
- (void)onebtn
{
    NSLog(@"1");
    BOOL canWrite = [self textIsNumber:self.receivablesTextFiled.text range:NSMakeRange(self.receivablesTextFiled.text.length, self.receivablesTextFiled.text.length) str:@"1"];
    if (canWrite == NO) {
        return;
    }
    NSString *string = [self.receivablesTextFiled.text stringByAppendingString:@"1"];
    self.receivablesTextFiled.text = string;
}

#pragma mark - 事件

- (void)changeRate:(UIButton *)button {
    if (button == self.rate1Btn) {    //费率1
        [self.rate1Btn setSelected:true];
        //        [self.rate2Btn setSelected:false];
        self.currentRate = 1;
    }
    //    else{  //费率2
    //        [self.rate1Btn setSelected:false];
    //        [self.rate2Btn setSelected:true];
    //        self.currentRate = 1;
    //    }
}

// 下一步
- (void)nextAction {
    float money = [self.receivablesTextFiled.text floatValue];
    NSString *ammount = [NSString stringWithFormat:@"%.2f",money];
    
    if ([ammount floatValue] <= 0) {
        [self showTitle:@"请输入正确金额" delay:1];
        return;
    }
    
    NewScanResultController *type = [[NewScanResultController alloc]init];
    type.money = ammount;
    type.type = _type;
    [self.navigationController pushViewController:type animated:YES];
}

- (BOOL)textIsNumber:(NSString *)number range:(NSRange)range str:(NSString *)string{
    NSCharacterSet *cs;
    if (range.location == 10) {
        return NO;
    }
    NSUInteger nDotLoc = [number rangeOfString:@"."].location;
    if (NSNotFound == nDotLoc && 0 != range.location) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
    }
    else {
        cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
    }
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
        [self showTitle:@"数字格式不正确" delay:1];
        return NO;
    }
    if (NSNotFound != nDotLoc && range.location > nDotLoc + 2) {
        [self showTitle:@"只能有两位小数" delay:1];
        return NO;
    }
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
