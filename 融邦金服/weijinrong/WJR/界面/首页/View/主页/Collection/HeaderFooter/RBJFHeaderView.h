//
//  RBJFHeaderView.h
//  weijinrong
//
//  Created by ouda on 17/6/7.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "HomeLocation.h"

@interface RBJFHeaderView : UICollectionReusableView<SDCycleScrollViewDelegate>
@property(nonatomic,strong)UILabel * label;
@property(nonatomic,strong)UIButton * locBtn;
@property(nonatomic,strong)UIView * whiteView;
@property(nonatomic,strong)SDCycleScrollView * lscrollView;
@property(nonatomic,strong)HomeLocation * location;

- (instancetype)initWithFrame:(CGRect)frame;
@end
