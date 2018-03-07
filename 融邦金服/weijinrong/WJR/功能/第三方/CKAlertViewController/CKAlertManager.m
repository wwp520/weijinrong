//
//  文件名: CKAlertManager.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/12
//

#import "CKAlertManager.h"
#import "CKAlertViewController.h"

#pragma mark - 声明
@interface CKAlertManager()

@end

#pragma mark - 实现
@implementation CKAlertManager


+ (void)clickShowAlert:(NSString *)title
               message:(NSString *)message
               actions:(NSArray *)actions
                 click:(KKStrBlock)click {
    
    CKAlertViewController *vc = [CKAlertViewController alertControllerWithTitle:title message:message ];
    vc.messageAlignment = NSTextAlignmentLeft;
    for (NSString *action in actions) {
        CKAlertAction *actionBtn = [CKAlertAction actionWithTitle:action handler:^(CKAlertAction *action) {
            if (click) {
                click(action.title);
            }
        }];
        [vc addAction:actionBtn];
    }
    
    [[KKTools getCurrentVC] presentViewController:vc animated:NO completion:nil];
}

@end
