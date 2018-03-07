//
//  文件名: CreditInfoHead.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "CreditInfoHead.h"
#import "CardManagerDetailModel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "CreditCurMonth.h"

#pragma mark - 声明
@interface CreditInfoHead()
@property (weak, nonatomic) IBOutlet UIView *creditCard;// 信用卡
@property (weak, nonatomic) IBOutlet UIImageView *url;  //图片
@property (weak, nonatomic) IBOutlet UILabel *cardNo;   //卡号
@property (weak, nonatomic) IBOutlet UILabel *bankNo;   //银行编号
@property (weak, nonatomic) IBOutlet UILabel *creditLimit;  //额度
@property (weak, nonatomic) IBOutlet UILabel *integration;  //积分

@end

#pragma mark - 实现
@implementation CreditInfoHead

- (void)awakeFromNib {
    [super awakeFromNib];
    _creditCard.layer.cornerRadius = 15;
    _creditCard.layer.masksToBounds = YES;

}

// [cell.url sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@""]];

- (void)setModel:(CardArrangeModel *)model { //model.integration
    _model = model;
    _cardNo.text = model.cardNo;
    _bankNo.text = model.bankNo;
    _creditLimit.text = [NSString stringWithFormat:@"额度：%@",model.creditLimit];
    _integration.text = [NSString stringWithFormat:@"积分：%@",model.integration];
    
}
- (void)setBankUrl:(NSString *)bankUrl {
    _bankUrl = bankUrl;
    [_url sd_setImageWithURL:[NSURL  URLWithString:bankUrl]];
}


@end
