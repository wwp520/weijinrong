//
//  CardHeadView.m
//  weijinrong
//
//  Created by ouda on 17/6/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CardHeadView.h"
#import "RewardCashController.h"
#import "KKSelectBtn.h"

#define LISTBTN_TAG 99

@interface CardHeadView ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSString *money;// 奖励
@property (nonatomic, strong) NSString *month;// 月份
@property (nonatomic, copy  ) KKIntBlock click1;
@end


@implementation CardHeadView

+ (instancetype)initWithFrame:(CGRect)frame click:(KKIntBlock)click {
    CardHeadView *view = [CardHeadView loadFromFrame:frame];
    view.click1 = click;
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self titles];
    [self createUI];
}
- (void)createUI {
    for (int i=0; i<2; i++) {
        NSArray *titles = @[@"奖励提现",@"所有月份"];
        KKSelectBtn *btn = [KKSelectBtn initWithFrame:({
            CGFloat width = ScreenWidth / 2;
            CGFloat height = 50;
            CGFloat x = i * width;
            CGFloat y = self.height - height;
            CGRectMake(x, y, width, height);
        }) text:titles[i] click:^{
            [self click];
        }];
        btn.alpha = 0;
        btn.tag = 100023 + i;
        [self addSubview:btn];
    }
}

- (void)click {
    if (_click1) {
        KKSelectBtn *btn = [self viewWithTag:100023];
        if (btn.selected == YES) {
            _click1(0);
        }else {
            _click1(1);
        }
    }
}




//奖励提现
- (IBAction)RewardCashBtn:(id)sender {
    
    
}
//所有月份
- (IBAction)AllMonthBtn:(id)sender {
    
    
}

- (void)setModel:(BankRewardModel *)model {
    _model = model;
    self.BigDecimal.text = [NSString stringWithFormat:@"%@元",_model.amount];
    self.sumAmount.text = [NSString stringWithFormat:@"累计奖励+%@元", _model.sumAmount];
}

//提现
- (IBAction)GetCashBtn:(id)sender {
    RewardCashController * rewardVC = [[RewardCashController alloc]init];
    rewardVC.amount = self.BigDecimal.text;
    [self.viewController.navigationController pushViewController:rewardVC animated:YES];
}

@end
