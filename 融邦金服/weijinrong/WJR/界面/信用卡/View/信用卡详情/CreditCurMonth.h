//
//  文件名: CreditCurMonth.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "BaseView.h"
#import "CardManagerDetailModel.h"
#import "CardArrangeModel.h"
#import "CardManagerModel.h"


#pragma mark - 声明
@interface CreditCurMonth : BaseView
@property (weak, nonatomic) IBOutlet UILabel *minAmount;
@property (weak, nonatomic) IBOutlet UILabel *repaymentAmount;

@property(nonatomic,strong)CardArrangeModel * model;

@property(nonatomic,strong)CardManagerInfoModel * manmodel;

@end
