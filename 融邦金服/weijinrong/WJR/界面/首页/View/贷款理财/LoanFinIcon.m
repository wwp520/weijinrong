//
//  文件名: LoanFinIcon.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/5
//

#import "LoanFinIcon.h"
#import "SDCycleScrollView.h"

#pragma mark - 声明
@interface LoanFinIcon()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *images;
@property (nonatomic, copy  ) KKIntBlock click;
@end

#pragma mark - 实现
@implementation LoanFinIcon

#pragma mark - 初始化
// code init
+ (instancetype)loadCode:(CGRect)frame {
    LoanFinIcon *view = [[LoanFinIcon alloc] initWithFrame:frame];
    [view images];
    return view;
}
- (SDCycleScrollView *)images {
    if (!_images) {
        _images = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self addSubview:_images];
        [_images setClickItemOperationBlock:^(NSInteger index) {
            if (_click) {
                _click(index);
            }
        }];
    }
    return _images;
}
- (void)setImageArr:(NSArray *)imagesUrl click:(KKIntBlock)click {
    _images.imageURLStringsGroup = imagesUrl;
    _click = click;
}


@end
