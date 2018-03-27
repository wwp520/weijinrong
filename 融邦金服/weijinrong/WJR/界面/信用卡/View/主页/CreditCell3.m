//
//  CreditCell3.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CreditCell3.h"
#import "CardLinkController.h"
#import "ApplicationViewController.h"


@implementation CreditCell3

//立即申请
- (IBAction)GetDown:(id)sender {
//    ApplicationViewController * appVC = [[ApplicationViewController alloc]init];
//    appVC.model = _model;
//    [self.viewController.navigationController  pushViewController:appVC animated:YES];
  
    CardLinkController *cardVC = [[CardLinkController alloc]init];
    cardVC.model = _model;
    cardVC.openUrl = _model.content;
    [self.viewController.navigationController pushViewController:cardVC animated:YES];
}


- (void)setModel:(CardBenifitListModel *)model{
    _model = model;
}

@end
