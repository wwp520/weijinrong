//
//  文件名: CKAlertManager.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/12
//

#import <Foundation/Foundation.h>

#pragma mark - 声明
@interface CKAlertManager : NSObject

+ (void)clickShowAlert:(NSString *)title
               message:(NSString *)message
               actions:(NSArray *)actions
                 click:(KKStrBlock)click;

@end
