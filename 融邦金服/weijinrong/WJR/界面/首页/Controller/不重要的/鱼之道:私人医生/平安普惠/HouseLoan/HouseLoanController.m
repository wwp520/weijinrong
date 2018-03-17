//
//  HouseLoanController.m
//  chengzizhifu
//
//  Created by RY on 16/5/16.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "HouseLoanController.h"
#import "OwnerLandController.h"
#import "Unity.h"

@interface HouseLoanController ()

@property (nonatomic, strong) UIView *firstView;    //业务类
@property (nonatomic, strong) UIView *secondView;   //优房贷
@property (nonatomic, strong) UIView *thirdView;    //宅e贷

@property (nonatomic, strong) UIButton *selBtn;     //选中的按钮

@end

@implementation HouseLoanController

- (UIView *)firstView{
    if (!_firstView) {
        _firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 91 + 64, self.view.width, self.view.height-91)];
        CGFloat width = _firstView.width;
        CGFloat height = 20.f;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIColor *color = [UIColor blackColor];
        //额度
       UILabel *ammountLabel = [Unity lableViewAddsuperview_superView:_firstView _subViewFrame:CGRectMake(0, 5, width, height) _string:@"额    度：2-15万" _lableFont:font _lableTxtColor:color _textAlignment:NSTextAlignmentCenter];
        //费率
        UILabel *tariff = [Unity lableViewAddsuperview_superView:_firstView _subViewFrame:CGRectMake(0, CGRectGetMaxY(ammountLabel.frame), width, height) _string:@"月综合费率：1.22%-2.22%;" _lableFont:font _lableTxtColor:color _textAlignment:NSTextAlignmentCenter];
        //可用人选
        UILabel *userLabel = [Unity lableViewAddsuperview_superView:_firstView _subViewFrame:CGRectMake(20, CGRectGetMaxY(tariff.frame)+10, width-40, height) _string:@"1.年龄21-55周岁，信用良好的内地居民;" _lableFont:font _lableTxtColor:color _textAlignment:NSTextAlignmentLeft];
        //可用条件
        UILabel *userLabel2 = [Unity lableViewAddsuperview_superView:_firstView _subViewFrame:CGRectMake(20, CGRectGetMaxY(userLabel.frame), width-40, height) _string:@"2.本按揭房还款满6个月;" _lableFont:font _lableTxtColor:color _textAlignment:NSTextAlignmentLeft];
        UILabel *userLabelDetail = [Unity lableViewAddsuperview_superView:_firstView _subViewFrame:CGRectMake(20, CGRectGetMaxY(userLabel2.frame), width-20, 40) _string:@"" _lableFont:font _lableTxtColor:color _textAlignment:NSTextAlignmentLeft];
        userLabelDetail.numberOfLines = 0;
        
        //提交按钮
        UIButton *commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(userLabelDetail.frame)+40, 130, 30)];
        commitBtn.centerX = _firstView.centerX;
        commitBtn.tag = 1;
        [commitBtn setTitle:@"立即申请" forState:UIControlStateNormal];
        [commitBtn setBackgroundImage:[UIImage imageNamed:@"橘色块"] forState:UIControlStateNormal];
        [commitBtn addTarget:self action:@selector(commitActin:) forControlEvents:UIControlEventTouchUpInside];
        [_firstView addSubview:commitBtn];
        [self.view addSubview:_firstView];
    }
    return _firstView;
}
- (UIView *)secondView{
    if (!_secondView) {
        _secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 91 + 64, self.view.width, self.view.height-91)];
        CGFloat width = _firstView.width;
        CGFloat height = 20.f;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIColor *color = [UIColor blackColor];
        //额度
        UILabel *ammountLabel = [Unity lableViewAddsuperview_superView:_secondView _subViewFrame:CGRectMake(0, 5, width, height) _string:@"额    度：3-50万" _lableFont:font _lableTxtColor:color _textAlignment:NSTextAlignmentCenter];
        //费率
        UILabel *tariff = [Unity lableViewAddsuperview_superView:_secondView _subViewFrame:CGRectMake(0, CGRectGetMaxY(ammountLabel.frame), width, height) _string:@"月综合费率：0.92%-1.32%" _lableFont:font _lableTxtColor:color _textAlignment:NSTextAlignmentCenter];
        //可用人选
        UILabel *userLabel = [Unity lableViewAddsuperview_superView:_secondView _subViewFrame:CGRectMake(20, CGRectGetMaxY(tariff.frame)+10, width-40, height) _string:@"1.年龄25-55周岁，信用良好的内地居民;" _lableFont:font _lableTxtColor:color _textAlignment:NSTextAlignmentLeft];
        //可用条件
        UILabel *userLabel2 = [Unity lableViewAddsuperview_superView:_secondView _subViewFrame:CGRectMake(20, CGRectGetMaxY(userLabel.frame), width-40, height) _string:@"2.持有房产证;" _lableFont:font _lableTxtColor:color _textAlignment:NSTextAlignmentLeft];
        UILabel *userLabelDetail = [Unity lableViewAddsuperview_superView:_secondView _subViewFrame:CGRectMake(20, CGRectGetMaxY(userLabel2.frame), width-20, 40) _string:@"3.本地按揭房，还款超过6次或者还款已超过12次，结清在12个月以内的全款房;" _lableFont:font _lableTxtColor:color _textAlignment:NSTextAlignmentLeft];
        userLabelDetail.numberOfLines = 0;
        
        //提交按钮
        UIButton *commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(userLabelDetail.frame)+40, 130, 30)];
        commitBtn.centerX = _secondView.centerX;
        commitBtn.tag = 2;
        [commitBtn setTitle:@"立即申请" forState:UIControlStateNormal];
        [commitBtn setBackgroundImage:[UIImage imageNamed:@"橘色块"] forState:UIControlStateNormal];
        [commitBtn addTarget:self action:@selector(commitActin:) forControlEvents:UIControlEventTouchUpInside];
        [_secondView addSubview:commitBtn];
        [self.view addSubview:_firstView];
        
        [self.view addSubview:_secondView];
    }
    return _secondView;
}
- (UIView *)thirdView{
    if (!_thirdView) {
        _thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, 91 + 64, self.view.width, self.view.height-91)];
        
        CGFloat width = ScreenWidth;
        CGFloat height = 20.f;
        UIFont *font = [UIFont systemFontOfSize:14];
        UIColor *color = [UIColor blackColor];
        //额度
        UILabel *ammountLabel = [Unity lableViewAddsuperview_superView:_thirdView _subViewFrame:CGRectMake(0, 5, width, height) _string:@"额    度：10-1500万" _lableFont:font _lableTxtColor:color _textAlignment:NSTextAlignmentCenter];
        //费率
        UILabel *tariff = [Unity lableViewAddsuperview_superView:_thirdView _subViewFrame:CGRectMake(0, CGRectGetMaxY(ammountLabel.frame), width, height) _string:@"月综合费率：0.89%" _lableFont:font _lableTxtColor:color _textAlignment:NSTextAlignmentCenter];
        
        NSArray *titles = @[@"1.申请人年龄：25到55周岁",@"2.申请人是产权人；",@"3.全款公寓住宅；",@"4.持有房产证；",@"5.价格30万以上；"];
        for (int i = 0; i < titles.count; i++) {
           UILabel *label = [Unity lableViewAddsuperview_superView:_thirdView _subViewFrame:CGRectMake(20, CGRectGetMaxY(tariff.frame)+(i+1)*20, width-40, height) _string:titles[i] _lableFont:font _lableTxtColor:color _textAlignment:NSTextAlignmentLeft];
            label.centerX = _thirdView.centerX;
            
        }
        
        //提交按钮
        UIButton *commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tariff.frame)+(titles.count+3)*height, 130, 30)];
        commitBtn.centerX = _secondView.centerX;
        commitBtn.tag = 3;
        [commitBtn setTitle:@"立即申请" forState:UIControlStateNormal];
        [commitBtn setBackgroundImage:[UIImage imageNamed:@"橘色块"] forState:UIControlStateNormal];
        [commitBtn addTarget:self action:@selector(commitActin:) forControlEvents:UIControlEventTouchUpInside];
        [_thirdView addSubview:commitBtn];
        
        [self.view addSubview:_thirdView];
    }
    return _thirdView;
}

#pragma mark - 父类重写

- (void)createNavigation {
    self.navTitle= @"我要贷款";
}

- (void)leftBtnPressed:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self showUI];
}

- (void)showUI {
    //title
    [Unity lableViewAddsuperview_superView:self.view _subViewFrame:CGRectMake(10, 8 , self.view.width-20, 20) _string:@"请选择您需要的贷款类型" _lableFont:[UIFont systemFontOfSize:14] _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentLeft];
    
    //按钮
    NSArray *titles = @[@"业主类",@"优房贷",@"宅e贷"];
    CGFloat itemW = 80.f;
    CGFloat itemH = 30.f;
    CGFloat itemY = 40.f;
    CGFloat margin = (self.view.width-3*itemW)/4;
    for (int i = 0; i < 3 ; i++) {
        CGFloat itemX = margin+i*(itemW+margin);
        UIButton *typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(itemX, itemY, itemW, itemH)];
        typeBtn.tag = i;
        [typeBtn addTarget:self action:@selector(typeAction:) forControlEvents:UIControlEventTouchUpInside];
        [typeBtn setTitle:titles[i] forState:UIControlStateNormal];
        [typeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [typeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [typeBtn setBackgroundImage:[UIImage imageNamed:@"灰色块"] forState:UIControlStateNormal];
        [typeBtn setBackgroundImage:[UIImage imageNamed:@"蓝色块"] forState:UIControlStateSelected];
        [self.view addSubview:typeBtn];
        
        //默认选中第一个
        if (i == 0) {
            [self typeAction:typeBtn];
        }
    }
    
    //分割线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, self.view.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.view addSubview:lineView];
}

#pragma mark - 事件

/**
 *  更改贷款类型
 */
- (void)typeAction:(UIButton *)button {
    self.selBtn.selected = NO;
    button.selected = YES;
    self.selBtn = button;

    self.firstView.alpha = 0;
    self.secondView.alpha = 0;
    self.thirdView.alpha = 0;
    
    switch (button.tag) {
        case 0:
            self.firstView.alpha = 1;
            break;
        case 1:
            self.secondView.alpha = 1;
            break;
        case 2:
            self.thirdView.alpha = 1;
            break;
            
        default:
            break;
    }
}

- (void)commitActin:(UIButton *)button {
    OwnerLandController *vc = nil;
    
    switch (button.tag) {
        case 1:
            vc = [[OwnerLandController alloc]init];
            vc.type = @"A1";
            break;
        case 2:
            vc = [[OwnerLandController alloc]init];
            vc.type = @"A2";
            break;
        case 3:
            vc = [[OwnerLandController alloc]init];
            vc.type = @"A3";
            break;
            
        default:
            break;
    }
    if (vc != nil) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
