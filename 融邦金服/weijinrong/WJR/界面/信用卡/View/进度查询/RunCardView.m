//
//  RunCardView.m
//  weijinrong
//
//  Created by ouda on 17/6/21.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "RunCardView.h"
#import "ShareCodeController.h"
#import "CreditCardController.h"

@implementation RunCardView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}


- (void)createUI{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 80, ScreenWidth-200, ScreenWidth-200)];
    imageView.image = [UIImage imageNamed:@"办卡查询"];
    [self addSubview:imageView];
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(imageView.frame)+50, ScreenWidth-120, 30)];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"还没有办卡记录哦,点击去办理!" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}


- (void)btnClick:(UIButton *)btn{
    CreditCardController * creditVC = [[CreditCardController alloc]init];
    [self.viewController.navigationController pushViewController:creditVC animated:YES];
}

@end
