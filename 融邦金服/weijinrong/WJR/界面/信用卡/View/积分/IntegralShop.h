//
//  文件名: IntegralShop.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/6
//

#import <UIKit/UIKit.h>
#import "IntegralShopModel.h"

#pragma mark - 声明
@interface IntegralShop : UIView

@property(nonatomic,strong)IntegralShopModel * model;
// code init
+ (instancetype)loadCode:(CGRect)frame;

@end
