//
//  文件名: CreditInfoController.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "BaseViewController.h"
#import "CardManagerModel.h"

#pragma mark - 声明
@interface CreditInfoController : BaseViewController
@property(nonatomic,strong)NSString * url;
@property(nonatomic,strong)NSString * cardNo;
@property(nonatomic,strong)NSString * bankName;
@property(nonatomic,strong)CardManagerInfoModel * manmodel;
@property(nonatomic,strong)NSString * countDown;// 倒计时
@property(nonatomic,strong)NSString * huanDate;// 最后日期

@end
