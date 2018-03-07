//
//  ScanCodeView.m
//  weijinrong
//
//  Created by ouda on 17/6/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "ScanCodeView.h"
#import "NewScanKeyController.h"
#import "NewScanView.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation ScanCodeView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.longG = [[UILongPressGestureRecognizer alloc]
                  initWithTarget:self action:@selector(longQrClick:)];
    self.longG.minimumPressDuration = 1.0;
    [self.icon addGestureRecognizer:self.longG];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [(BaseViewController *)self.viewController hiddenHudLoadingView];
    NSString *msg = nil ;
    if(error){
        msg = @"图片保存失败";
    }else{
        msg = @"图片保存成功";
    }
    
    
    [(BaseViewController *)self.viewController showTitle:msg delay:2];
}
- (void)longQrClick:(UILongPressGestureRecognizer *)sender {
    
//    if(sender.state == UIGestureRecognizerStateBegan) {
//        UIImageWriteToSavedPhotosAlbum(_icon.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//        [(BaseViewController *)self.viewController showHudLoadingView:@"保存二维码"];
//    }
    
    if (sender.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusDenied) {
        UIAlertView * alart = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相机->设置->隐私->相机" delegate:self cancelButtonTitle:@"立即开启" otherButtonTitles:nil, nil];
        [alart show];
    }else {
        NSLog(@"允许状态");
        UIImageWriteToSavedPhotosAlbum(_icon.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        [(BaseViewController *)self.viewController showHudLoadingView:@"保存二维码"];
        if (_longClick) {
            _longClick();
        }
    }

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
} 

//扫码
- (IBAction)ScanCodeBtn:(id)sender {
    [NewScanView initWithClick:^(NSInteger type) {
    NewScanKeyController *vc = [[NewScanKeyController alloc] init];
    vc.type = type;
    vc.navTitle = type == 0 ? @"微信收款" : @"支付宝收款";
    [self.viewController.navigationController pushViewController:vc animated:YES];
    }];
}
@end
