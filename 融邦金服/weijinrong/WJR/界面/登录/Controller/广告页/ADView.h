//
//  ADView.h
//  weijinrong
//
//  Created by ouda on 17/6/22.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseView.h"

@protocol ADViewDelegate <NSObject>

- (void)clickOne;
- (void)clickTwo;

@end


@interface ADView : BaseView
@property (nonatomic, weak) id<ADViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *adbtn;

+ (instancetype)initWithFrame:(CGRect)frame;
@end
