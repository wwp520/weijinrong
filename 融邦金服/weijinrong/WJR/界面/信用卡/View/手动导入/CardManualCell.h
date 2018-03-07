//
//  文件名: CardManualCell.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/10
//

#import <UIKit/UIKit.h>

#pragma mark - 声明
@interface CardManualCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextField *desc;

@end
