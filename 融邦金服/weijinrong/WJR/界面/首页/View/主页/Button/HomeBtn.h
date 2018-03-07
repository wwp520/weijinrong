//
//  HomeBtn.h
//  weijinrong
//
//  Created by RY on 17/3/30.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBtn : UIBarButtonItem

+ (HomeBtn *)initWithTitle:(NSString *)title icon:(NSString *)icon ;
+ (HomeBtn *)initLeftTitle:(NSString *)title icon:(NSString *)icon ;

@end
