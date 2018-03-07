//
//  ScanCodePayHeadView.m
//  weijinrong
//
//  Created by ouda on 17/6/12.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "ScanCodePayHeadView.h"
#import "NewScanView.h"
#import "NewScanKeyController.h"
#import "ScanCodeDetailController.h"
#import "TransDetailsController.h"

@interface RBJFCollection : UIView

@end
@implementation ScanCodePayHeadView

- (IBAction)pushBtn:(id)sender {
//    ScanCodeDetailController * detailVC = [[ScanCodeDetailController alloc]init];
//    [self.viewController.navigationController pushViewController:detailVC animated:YES];
    TransDetailsController * transVC = [[TransDetailsController alloc]init];
    [self.viewController.navigationController pushViewController:transVC animated:YES];

}

- (IBAction)WXPay:(id)sender {
    NewScanKeyController *vc = [[NewScanKeyController alloc] init];
    vc.type = 0;
    vc.navTitle = _type == 0 ? @"微信收款" : @"支付宝收款";
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
//                    [NewScanView initWithClick:^(NSInteger type) {
//                        NewScanKeyController *vc = [[NewScanKeyController alloc] init];
//                        vc.type = type;
//                        vc.navTitle = type == 0 ? @"微信收款" : @"支付宝收款";
//                        [self.viewController.navigationController pushViewController:vc animated:YES];
//                    }];
}

- (IBAction)ZFBPayBtn:(id)sender {
    
    NewScanKeyController *vc = [[NewScanKeyController alloc] init];
    vc.type = 1;
    vc.navTitle = _type == 0 ? @"微信收款" : @"支付宝收款";
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
//    [NewScanView initWithClick:^(NSInteger type) {
//        NewScanKeyController *vc = [[NewScanKeyController alloc] init];
//        vc.type = type;
//        vc.navTitle = type == 0 ? @"微信收款" : @"支付宝收款";
//        [self.viewController.navigationController pushViewController:vc animated:YES];
//    }];
}


@end
