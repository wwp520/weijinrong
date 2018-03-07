//
//  文件名: CardManagerFoot.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "CardManagerFoot.h"

#pragma mark - 声明
@interface CardManagerFoot()
@property (nonatomic, copy) KKBlock click;
@end

#pragma mark - 实现
@implementation CardManagerFoot

+ (instancetype)loadFromFrame:(CGRect)frame click:(KKBlock)click {
    CardManagerFoot *foor = [CardManagerFoot loadFromFrame:frame];
    foor.click = click;
    return foor;
}

- (IBAction)addCardClick:(UIButton *)sender {
    if (_click) {
        _click();
    }
}

@end
