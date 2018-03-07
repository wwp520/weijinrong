//
//  KKCountdown.h
//  weijinrong
//
//  Created by RY on 17/4/12.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 倒计时 */
@interface KKCountdown : NSObject
singleton_interface(KKCountdown)

- (void)startTimer:(KKStrBlock)click;

@end
