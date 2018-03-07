//
//  RBJFHeader.h
//  weijinrong
//
//  Created by ouda on 17/6/7.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeLocation.h"

@interface RBJFHeader : UICollectionReusableView
@property(nonatomic,strong)UIButton * locBtn;
@property(nonatomic,strong)HomeLocation * location;
@property(nonatomic,strong)UIView * whiteView;
@property(nonatomic,strong)UILabel * label;
@property (weak, nonatomic) IBOutlet UILabel *locationLb;

- (instancetype)initWithFrame:(CGRect)frame;
@end
