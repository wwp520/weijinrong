//
//  文件名: CardManagerHead.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "CardManagerHead.h"

#pragma mark - 声明
@interface CardManagerHead()
@property(nonatomic,copy) KKIntBlock click;
@end

#pragma mark - 实现
@implementation CardManagerHead

+ (instancetype)loadFromFrame:(CGRect)frame click:(KKIntBlock)click {
    CardManagerHead *view = [CardManagerHead loadFromFrame:frame];
    view.click = click;
    return view;
}

- (IBAction)billClick:(UIButton *)sender {
    if (_click) {
        _click(sender.tag);
    }
}

@end
