//
//  文件名: CreditInfoHead.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "BaseView.h"
#import "CardManagerDetailModel.h"
#import "CardArrangeModel.h"

#pragma mark - 声明
@interface CreditInfoHead : BaseView
     
@property(nonatomic,strong)CardArrangeModel * model;
@property(nonatomic,strong)NSString *bankUrl;  //银行图片
@property (weak, nonatomic) IBOutlet UILabel *lastDay;// 倒计时
@property (weak, nonatomic) IBOutlet UILabel *huanDate;


@end
