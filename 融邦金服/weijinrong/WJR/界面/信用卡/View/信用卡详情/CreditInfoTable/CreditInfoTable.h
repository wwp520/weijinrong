//
//  文件名: CreditInfoTable.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import <UIKit/UIKit.h>
#import "CardManagerDetailModel.h"
#import "CardArrangeModel.h"

#pragma mark - 声明
@interface CreditInfoTable : UIView

@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) CardArrangeModel *model;
@property (nonatomic, strong) NSString * countDown;// 倒计时
@property (nonatomic, strong) NSString * huanDate;

+ (instancetype)loadCode:(CGRect)frame;

@end
