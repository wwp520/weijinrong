//
//  CreditListBtn.h
//  weijinrong
//
//  Created by ouda on 17/5/23.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditListBtn : UIButton

@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong) UIImageView *icon;

+ (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text;

@end
