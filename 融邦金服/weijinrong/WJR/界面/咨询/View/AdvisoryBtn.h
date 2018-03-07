//
//  AdvisoryBtn.h
//  weijinrong
//
//  Created by RY on 17/6/14.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvisoryBtn : UIButton

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;

+ (instancetype)initWithFrame:(CGRect)frame ;

@end
