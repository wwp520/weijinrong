//
//  HomeHeader.h
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeLocation.h"

@interface HomeHeader : UICollectionReusableView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanL;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UILabel *name2;
@property (weak, nonatomic) IBOutlet UIImageView *icon2;
@property (weak, nonatomic) IBOutlet UILabel *locationLb;
@property (nonatomic, strong) LoginModel *model;
@property (nonatomic, strong) HomeLocation *location;

- (void)setClick:(KKIntBlock)click;




@end
