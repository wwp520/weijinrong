//
//  文件名: LoanFinTable.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/5
//

#import <UIKit/UIKit.h>

#pragma mark - 声明
@interface LoanFinTable : UIView

@property (nonatomic, strong) UITableView *table;

// code init
+ (instancetype)loadCode:(CGRect)frame;

@end
