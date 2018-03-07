//
//  CardWelfaresCell.m
//  weijinrong
//
//  Created by ouda on 17/6/16.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CardWelfaresCell.h"

@implementation CardWelfaresCell

// xib init
+ (instancetype)loadNib:(CGRect)frame {
    NSString *className = NSStringFromClass([self class]);
    CardWelfaresCell *view = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil].firstObject;
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
    vc.navTitle = @"具体地点";
    //        vc.url = _model.list[indexPath.row].content;
    [self.viewController.navigationController pushViewController:vc animated:YES];    
    
}

-(void)setCardmodel:(CreditCardListModel *)cardmodel{
    _cardmodel = cardmodel;
}



@end
