//
//  HomeCollection.h
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeLocation.h"

@interface HomeCollection : UIView

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) LoginModel *model;

+ (instancetype)initWithFrame:(CGRect)frame;

@end
