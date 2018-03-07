//
//  CreditInfoCell.m
//  weijinrong
//
//  Created by RY on 17/4/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CreditInfoCell.h"
#import "CreditInfoView.h"

#pragma mark - 声明
@interface CreditInfoCell ()
@property (weak, nonatomic) IBOutlet UIView *firstMonth;// 未出账单
@property (weak, nonatomic) IBOutlet UIButton *power;
@property (weak, nonatomic) IBOutlet CreditInfoView *table;
@property (weak, nonatomic) IBOutlet UIImageView *triangle;
@property (nonatomic, copy) KKBlock click;
@end

#pragma mark - 实现
@implementation CreditInfoCell


+ (instancetype)loadWithTable:(UITableView *)table click:(KKBlock)click {
    CreditInfoCell *cell = [super loadLastNib:table];
    [cell.table setLineHide];
    [cell.power.layer setCornerRadius:5];
    [cell.power.layer setMasksToBounds:YES];
    [cell.power.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.power.layer setBorderWidth:1];
    [cell setClick:click];
    return cell;
}

- (IBAction)powerClick:(id)sender {
    if (_click) {
        _click();
    }
}

// 设置数据
- (void)setModel:(CardArrangeMonthModel *)model {
    _model = model;
    _Date.text = model.Date;
    _countTime.text = model.countTime;
    _countAmount.text = model.countAmount;
    // 初始化三角形角度
    [self setTrianglePositive:_model.isUnfolded];
    // 子Table设置代理和数据
    [_table setDelegateToSelf];
    [_table setModel:model];
    [_table setLineHide];
    // 刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        [_table reloadData];
    });
}

// 是否是未出账单
- (void)setAleardyOrder:(BOOL)order {
    if (order) {
        _table.alpha = 0;
        _firstMonth.alpha = 1;
    }else {
        _firstMonth.alpha = 0;
        _table.alpha = 1;
    }
}

// 旋转三角
- (void)rotateTriangle {
    [UIView animateKeyframesWithDuration:.3f delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        _triangle.transform = CGAffineTransformRotate(_triangle.transform, M_PI);
    } completion:nil];
}

// Cell刷新的时候是正三角还是倒三角
- (void)setTrianglePositive:(BOOL)isPositive {
    if (isPositive) {
        _triangle.transform = CGAffineTransformIdentity;
    }else {
        _triangle.transform = CGAffineTransformIdentity;
        _triangle.transform = CGAffineTransformRotate(_triangle.transform, M_PI);
    }
}



@end
