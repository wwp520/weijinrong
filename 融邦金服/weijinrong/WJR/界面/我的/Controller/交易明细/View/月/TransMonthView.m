//
//  TransMonthView.m
//  chengzizhifu
//
//  Created by RY on 17/1/5.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "TransMonthView.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"
#import "ReceiptViewController.h"
#import "TransTools.h"
#import "TransDayDetailController.h"

#pragma mark 声明
@interface TransMonthView ()
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (nonatomic, strong) CalendarHomeViewController *rvc;
@end

#pragma mark 实现
@implementation TransMonthView

#pragma mark 初始化
+ (instancetype)initWithFrame:(CGRect)frame {
    TransMonthView *view = [[NSBundle mainBundle] loadNibNamed:@"TransMonthView" owner:nil options:nil].firstObject;
    view.frame = frame;
    view.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    view.layer.borderWidth = 1;
    view.date.text = [TransTools dateWithStatu:1 comStr:@"" date:[NSDate date]];
    [view rvc];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view.rvc.collectionView setContentOffset:CGPointMake(0, view.rvc.collectionView.contentSize.height - view.rvc.collectionView.height) animated:NO];
    });
    return view;
}
- (CalendarHomeViewController *)rvc {
    if (!_rvc) {
        _rvc = [[CalendarHomeViewController alloc]init];
        [_rvc setAirPlaneToDay:740 ToDateforString:nil];
        [_rvc setFrame:CGRectMake(0, 100, ScreenWidth, ScreenHeight - 140 - 64)];
        [self addSubview:_rvc.view];
        
        __weak TransMonthView *weak = self;
        _rvc.calendarblock = ^(CalendarDayModel *model){
            NSLog(@"\n---------------------------");
            NSLog(@"1星期 %@",[model getWeek]);
            NSLog(@"2字符串 %@",[model toString]);
            NSLog(@"3节日  %@",model.holiday);
            
            
            NSString *date = [NSString stringWithFormat:@"%lu%.2lu%.2lu",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day];
            NSString *displayDate = [NSString stringWithFormat:@"%lu-%.2lu-%.2lu",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day];
            TransDayDetailController *vc = [[TransDayDetailController alloc] init];
            vc.date = date;
            vc.displayDate = displayDate;
            [weak.viewController.navigationController pushViewController:vc animated:YES];

        };

    }
    return _rvc;
}


- (void)setModel:(TransMonthModel *)model {
    _model = model;
    _money.text = [NSString stringWithFormat:@"%.2f元",[model.payAmount floatValue]];
}

@end

