//
//  UMTotalController.h
//  weijinrong
//
//  Created by ouda on 17/7/5.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseViewController.h"

@interface UMTotalController : BaseViewController
+ (void)profileSignInWithPUID:(NSString *)puid;
+ (void)profileSignInWithPUID:(NSString *)puid provider:(NSString *)provider;

+(void)profileSignOff;
@end
