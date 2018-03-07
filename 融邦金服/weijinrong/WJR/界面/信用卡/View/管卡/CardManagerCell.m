//
//  文件名: CardManagerCell.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "CardManagerCell.h"
#import "CardManagerModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>

#pragma mark - 声明
@interface CardManagerCell()
@property (weak, nonatomic) IBOutlet UIButton *payNow;
@end

#pragma mark - 实现
@implementation CardManagerCell

- (void)setModel:(CardManagerInfoModel *)model {
    _model = model;
    [self.url sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@""]];
    self.useName.text           = [NSString stringWithFormat:@"%@",model.userName];
    self.bankName.text          = model.bankName;
    self.repaymentAmount.text   = model.repaymentAmount;
    self.billAmount.text        = model.billAmount;
    self.minAmount.text         = model.minAmount;
    self.billCycle.text         = model.billCycle;
    self.RepaymentDate.text     = model.RepaymentDate;
    self.cardNo.text            = model.cardNo;
    self.RepaymentTime.text     = model.RepaymentTime;
    
    if ([model.RepaymentDate integerValue] < 0) {
        // 过期是红色
        self.RepaymentDate.textColor = [UIColor redColor];
    }else {
        // 没过期黑色
        self.RepaymentDate.textColor = [UIColor blackColor];
    }
}

@end




