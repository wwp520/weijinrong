//
//  TransDetailsController.m
//  chengzizhifu
//
//  Created by RY on 17/1/5.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "TransDetailsController.h"
#import "TransDChooseView.h"
#import "TransDayView.h"
#import "TransWeekView.h"
#import "TransMonthView.h"
#import "TransDayModel.h"
#import "TransWeekModel.h"
#import "TransMonthModel.h"
#import "AFNManager.h"
#import "Unity.h"
#import "BankModel.h"

#pragma mark 声明
@interface TransDetailsController ()
@property (nonatomic, strong) TransDChooseView *choose;
@property (nonatomic, strong) TransDayView    *day;
@property (nonatomic, strong) TransWeekView   *week;
@property (nonatomic, strong) TransMonthView  *month;
@property (nonatomic, strong) TransDayModel   *dayModel;
@property (nonatomic, strong) TransWeekModel  *weekModel;
@property (nonatomic, strong) TransMonthModel *monthModel;
@end

#pragma mark 实现
@implementation TransDetailsController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    [self set_money_day_url];
}
- (void)createUI {
    [self setNavTitle:@"交易明细"];
    [self.view setBackgroundColor:RGB(233,233,233,1)];
    [self choose];
    [self day];
    [self week];
    [self month];
}
- (TransDChooseView *)choose {
    if (!_choose) {
        _choose = [TransDChooseView initWithFrame:CGRectMake(0, 0, ScreenWidth, 40) click:^(NSInteger type) {
            _day.alpha = type == 1;
            _week.alpha = type == 2;
            _month.alpha = type == 3;
        }];
        [self.view addSubview:_choose];
    }
    return _choose;
}
- (TransDayView *)day {
    if (!_day) {
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:({
            CGFloat y = CGRectGetMaxY(_choose.frame);
            CGRectMake(0, y, ScreenWidth, ScreenHeight - y);
        })];
        [scroll setContentSize:CGSizeMake(0, 467)];
        [self.view addSubview:scroll];
        
        _day = [TransDayView initWithFrame:CGRectMake(0, 0, ScreenWidth, 450)];
        [scroll addSubview:_day];
    }
    return _day;
}
- (TransWeekView *)week {
    if (!_week) {
        _week = [TransWeekView initWithFrame:({
            CGFloat y = CGRectGetMaxY(_choose.frame);
            CGRectMake(0, y, ScreenWidth, ScreenHeight - y);
        })];
        _week.alpha = 0;
        [self.view addSubview:_week];
    }
    return _week;
}
- (TransMonthView *)month {
    if (!_month) {
        _month = [TransMonthView initWithFrame:({
            CGFloat y = CGRectGetMaxY(_choose.frame);
            CGRectMake(0, y, ScreenWidth, ScreenHeight - y - 49);
        })];
        _month.alpha = 0;
        [self.view addSubview:_month];
    }
    return _month;
}

#pragma mark 网络
// 日
- (void)set_money_day_url {
    __weak TransDetailsController *weak = self;
    [self showHudLoadingView:@"正在获取..."];
    
    [DongManager tradeMoneyDay:^(id requestData) {
        [self hiddenHudLoadingView];
        // 解析
        _dayModel = [TransDayModel decryptBecomeModel:requestData];
        // 显示
        if (_dayModel.retCode==0) {
            [weak hiddenHudLoadingView];
            _day.model = _dayModel;
            // 周
            [weak set_month_week_url];
        }else{
            [weak showTitle:_dayModel.retMessage delay:2];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}
// 周
- (void)set_month_week_url {
    __weak TransDetailsController *weak = self;
    [DongManager tradeMoneyWeek:^(id requestData) {
        [self hiddenHudLoadingView];
        // 解析
        _weekModel = [TransWeekModel decryptBecomeModel:requestData];
        // 显示
        if (_weekModel.retCode==0) {
            [self hiddenHudLoadingView];
            _week.model = _weekModel;
            // 月
            [weak set_money_month_url];
        }else{
            [self showTitle:_dayModel.retMessage delay:2];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
    
}
// 月
- (void)set_money_month_url {
    
    NSString *dateStr = ({
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMM"];
        [formatter stringFromDate:date];
    });
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           dateStr,@"tradeDate",
                           [SaveManager getStringForKey:@"mercId"],@"mercId", nil];
    [DongManager tradeMoneyMonth:param success:^(id requestData) {
        [self hiddenHudLoadingView];
        // 解析
        _monthModel = [TransMonthModel decryptBecomeModel:requestData];
        // 显示
        if (_monthModel.retCode==0) {
            [self hiddenHudLoadingView];
            _month.model = _monthModel;
        }else{
            [self showTitle:_monthModel.retMessage delay:2];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}

#pragma mark 没用的
- (void)leftBtnPressed:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
