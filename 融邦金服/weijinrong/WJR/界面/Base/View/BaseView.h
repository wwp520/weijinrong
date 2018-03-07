//
//  BaseView.h
//  BusinessPeople
//
//  Created by RY on 17/1/12.
//  Copyright © 2017年 RY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

/** 加载 xib 第一个控件 */
+ (instancetype)loadFromFrame:(CGRect)frame ;
/** 加载 xib 最后一个控件 */
+ (instancetype)loadOtherFrame:(CGRect)frame ;
/** 加载 code */
+ (instancetype)loadCode:(CGRect)frame;

@end
