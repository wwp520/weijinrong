//
//  文件名: CardWelfareTable.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/6
//

#import <UIKit/UIKit.h>
#import "IntegralModel.h"
#import "CardWelfareModel.h"
#import "CreditCardModel.h"

#pragma mark - 声明
@interface CardWelfareTable : UIView

@property (nonatomic, strong) UITableView *table;
//@property(nonatomic,strong)CreditCardListModel * model;
// code init
@property(nonatomic,strong)NSMutableArray<CardWelfareListModel*> *dataArray;
+ (instancetype)loadCode:(CGRect)frame;

@end
