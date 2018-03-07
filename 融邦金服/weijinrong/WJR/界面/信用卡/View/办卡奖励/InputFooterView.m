//
//  InputFooterView.m
//  weijinrong
//
//  Created by ouda on 17/6/21.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "InputFooterView.h"
#import "ShareCodeController.h"

@implementation InputFooterView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}


- (void)createUI{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 80, ScreenWidth-200, ScreenWidth-200)];
    imageView.image = [UIImage imageNamed:@"推荐办卡奖励"];
    [self addSubview:imageView];
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(imageView.frame)+50, ScreenWidth-100, 30)];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"还没有奖励哦,点击推荐去赚红包!" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}


- (void)btnClick:(UIButton *)btn{
    ShareCodeController * shareVC = [[ShareCodeController alloc]init];
    [self.viewController.navigationController pushViewController:shareVC animated:YES];
}


@end
