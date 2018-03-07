//
//  CardInputList.h
//  weijinrong
//
//  Created by RY on 17/6/13.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseView.h"
#import "InputFooterView.h"


@interface CardInputList : BaseView
@property(nonatomic,strong)InputFooterView * footView;

- (void)displayAnimation:(CGFloat)height;
- (void)hiddenAnimation;

@end
