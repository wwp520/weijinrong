//
//  文件名: CardWelfareCell.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/6
//

#import "CardWelfareCell.h"

#pragma mark - 声明
@interface CardWelfareCell()

@end

#pragma mark - 实现
@implementation CardWelfareCell

#pragma mark - 初始化
// xib init
+ (instancetype)loadNib:(CGRect)frame {
    NSString *className = NSStringFromClass([self class]);
    CardWelfareCell *view = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil].firstObject;
    view.frame = frame;
    return view;
}


//跳转至地图
- (IBAction)kmBtn:(id)sender {
    CGFloat lat = [KKStaticParams sharedKKStaticParams].lat;
    CGFloat lot = [KKStaticParams sharedKKStaticParams].lot;
    
    // link?param=getBranchStorePosition.html?key=爱茜茜里%26lng=117.128011%26lat=36.679178
    
    
    NSString *str = [NSString stringWithFormat:@"%@link?param=getBranchStorePosition.html?key=%@&lng=%@&lat=%@",KHost,_cardmodel.title,[@(lot) description],[@(lat) description]];
    
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    str = [str stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    
    WebController *vc = [[WebController alloc] init];
    vc.url = str;
    vc.navTitle = @"具体位置";
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}

-(void)setCardmodel:(CreditCardListModel *)cardmodel{
    _cardmodel = cardmodel;
}

@end
