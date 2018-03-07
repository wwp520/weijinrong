//
//  文件名: LoanFinIcon.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/5
//

#import <UIKit/UIKit.h>

#pragma mark - 声明
@interface LoanFinIcon : UIView

// code init
+ (instancetype)loadCode:(CGRect)frame;

- (void)setImageArr:(NSArray *)imagesUrl click:(KKIntBlock)click;

@end
