//
//  文件名: CreditCurMonth.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "CreditCurMonth.h"

#pragma mark - 声明
@interface CreditCurMonth()
@property (weak, nonatomic) IBOutlet UIButton *payNow;
@end

#pragma mark - 实现
@implementation CreditCurMonth

- (void)awakeFromNib {
    [super awakeFromNib];
    _payNow.layer.cornerRadius = 5;
    _payNow.layer.masksToBounds = YES;
    _payNow.layer.borderWidth = 1;
    _payNow.layer.borderColor = [UIColor lightTextColor].CGColor;
}

- (void)setModel:(CardArrangeModel *)model {
    _model = model;
    _repaymentAmount.text = model.repaymentAmount;
    _minAmount.text = model.minAmount;
}

//- (void)setManmodel:(CardManagerInfoModel *)manmodel{
//    _manmodel = manmodel;
//    _repaymentAmount.text = manmodel.repaymentAmount;
//    _minAmount.text = manmodel.minAmount;
//}

@end
