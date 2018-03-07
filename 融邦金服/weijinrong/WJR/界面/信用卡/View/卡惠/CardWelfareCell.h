//
//  文件名: CardWelfareCell.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/6
//

#import "BaseCell.h"
#import "CardWelfareModel.h"
#import "CreditCardModel.h"


#pragma mark - 声明
@interface CardWelfareCell : BaseCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UIButton *kmBtn;
@property (weak, nonatomic) IBOutlet UILabel *shopName;

@property(nonatomic,strong)CreditCardListModel * cardmodel;

// xib init
+ (instancetype)loadNib:(CGRect)frame;

@end
