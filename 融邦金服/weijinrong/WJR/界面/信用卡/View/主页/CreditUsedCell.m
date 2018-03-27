//
//  CreditUsedCell.m
//  weijinrong
//
//  Created by ouda on 17/5/22.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CreditUsedCell.h"
#import "ApplicationViewController.h"
#import "CardLinkController.h"
#import "WebController.h"
#import "WebLinkController.h"

@interface CreditUsedCell()

@end

@implementation CreditUsedCell

//"title":"测试",
//"body":"测试",
//"content":"http://mp.weixin.qq.com/s?__biz=MjM5MDU4Njg5Mw==&mid=2247484883&idx=4&sn=a79d31d58f00554b17829f8d80c4e026&chksm=a643c4b191344da73e8810a88a33482d62603c7576159e3f612952f88431eac13e0316590467&mpshare=1&scene=24&srcid=0513zbkwjvsxKkmJdxGXTWAc#rd",
//"bankName":"123",
//"startTime":"20170101",
//"endTime":"20170101",
//"publishTime":"2017-05-25 11:15:35",
//"id":"6"


/*
//跳转到立即申请
- (IBAction)applyBtn:(id)sender {
   
    CardLinkController * cardVC = [[CardLinkController alloc]init];
    cardVC.model = _benifitModel;
    cardVC.openUrl = _benifitModel.content;
    [self.viewController.navigationController pushViewController:cardVC animated:YES];
}
 */


- (void)setModel:(CardWelfareListModel *)model {
    _model = model;
    _name.text = model.title;
    _desc.text = model.body;
    _number.text = model.bankName;
}

- (void)setBenifitModel:(CardBenifitListModel *)benifitModel{
    _benifitModel = benifitModel;
}
@end
