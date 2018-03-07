//
//  CreditCell6.m
//  weijinrong
//
//  Created by RY on 17/5/17.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CreditCell6.h"
#import "CreditCardModel.h"
#import "WebController.h"
#import "CardLinkController.h"

@implementation CreditCell6


- (IBAction)kmLbBtn:(id)sender {
//    WebController * web = [[WebController alloc]init];
//    web.url = _model.content;
//    [self.viewController.navigationController pushViewController:web animated:YES];
    
    
//    CreditCardListModel * model = _cardmodel.list[indexPath.row];
////    CreditCardListModel *model = _cardlistmodel.list[indexPath.row];
    CGFloat lat = [KKStaticParams sharedKKStaticParams].lat;
    CGFloat lot = [KKStaticParams sharedKKStaticParams].lot;
    
    // link?param=getBranchStorePosition.html?key=爱茜茜里%26lng=117.128011%26lat=36.679178
    
    
    NSString *str = [NSString stringWithFormat:@"%@link?param=getBranchStorePosition.html?key=%@&lng=%@&lat=%@",KHost,_cardmodel.title,[@(lot) description],[@(lat) description]];
    
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    str = [str stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    
    WebController *vc = [[WebController alloc] init];
    vc.url = str;
    vc.navTitle = @"具体位置";
    //        vc.url = _model.list[indexPath.row].content;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}


//- (void)setCardmodel:(CreditCardModel *)cardmodel{
//    _cardmodel = cardmodel;
//}

- (void)setCardmodel:(CreditCardListModel *)cardmodel{
    _cardmodel = cardmodel;
}

@end
