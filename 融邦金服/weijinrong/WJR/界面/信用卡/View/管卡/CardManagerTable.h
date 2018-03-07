//
//  文件名: CardManagerTable.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import <UIKit/UIKit.h>
#import "CardManagerModel.h"

#pragma mark - 声明
@interface CardManagerTable : UIView

@property(nonatomic,strong)CardManagerModel *model;
@property (nonatomic, strong) UITableView *table;

// code init
+ (instancetype)loadCode:(CGRect)frame;

@end
