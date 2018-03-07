//
//  文件名: CardManagerCell.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "BaseCell.h"
#import "CardManagerModel.h"

#pragma mark - 声明
@interface CardManagerCell : BaseCell

@property (nonatomic,copy ) NSString *mercId;//商户编号
@property (weak, nonatomic) IBOutlet UILabel *bankName;//银行名称
@property (weak, nonatomic) IBOutlet UILabel *cardNo;//信用卡后四位
@property (weak, nonatomic) IBOutlet UILabel *useName;//持卡人姓名
@property (weak, nonatomic) IBOutlet UILabel *billCycle;//账单周期
@property (weak, nonatomic) IBOutlet UILabel *RepaymentDate;//还款日
@property (weak, nonatomic) IBOutlet UILabel *billAmount; //本期账单
@property (weak, nonatomic) IBOutlet UILabel *minAmount; //最低还款金额
@property (weak, nonatomic) IBOutlet UILabel *repaymentAmount; //应还金额
@property (weak, nonatomic) IBOutlet UILabel *RepaymentTime;//还款时间
@property (weak, nonatomic) IBOutlet UIImageView *url;//银行图片

@property (nonatomic, strong) CardManagerInfoModel *model;

@end
