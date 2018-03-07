//
//  BaseView.m
//  BusinessPeople
//
//  Created by RY on 17/1/12.
//  Copyright © 2017年 RY. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

+ (instancetype)loadFromFrame:(CGRect)frame {
    NSString *name = NSStringFromClass(self);
    BaseView *view = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil].firstObject;
    view.frame = frame;
    return view;
}
+ (instancetype)loadOtherFrame:(CGRect)frame {
    NSString *name = NSStringFromClass(self);
    BaseView *view = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil].lastObject;
    view.frame = frame;
    return view;
}
+ (instancetype)loadCode:(CGRect)frame {
    BaseView *view = [[[self class] alloc] initWithFrame:frame];
    return view;
}


@end
