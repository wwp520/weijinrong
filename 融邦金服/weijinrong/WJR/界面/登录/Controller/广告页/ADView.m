//
//  ADView.m
//  weijinrong
//
//  Created by ouda on 17/6/22.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "ADView.h"
#import "BankRewardController.h"

@implementation ADView

+ (instancetype)initWithFrame:(CGRect)frame {
    ADView *view = [[NSBundle mainBundle] loadNibNamed:@"ADView" owner:nil options:nil].firstObject;
    view.frame = frame;
    view.adbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(IBAction)cancleBtn:(id)sender{
    if ([self.delegate respondsToSelector:@selector(clickOne)]) {
        [self.delegate clickOne];
    }
}

- (IBAction)RedPekitbtn:(id)sender {
//    BankRewardController * bankVC = [[BankRewardController  alloc]init];
//    [self.viewController.navigationController pushViewController:bankVC animated:YES];
    if ([self.delegate respondsToSelector:@selector(clickTwo)]) {
        [self.delegate clickTwo];
    }
}


@end
