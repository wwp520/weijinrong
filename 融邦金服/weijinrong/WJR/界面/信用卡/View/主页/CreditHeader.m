//
//  CreditHeader.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CreditHeader.h"
#import "CreditUsedViewController.h"
#import "CardWelfareController.h"

@interface CreditHeader()
@property (weak, nonatomic) IBOutlet UIImageView *moreIcon;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;
@property (weak, nonatomic) IBOutlet UIView *line;// 底边线
@end

@implementation CreditHeader

// 是否有更多
- (void)haveMorebtn:(BOOL)isHaveBtn {
    if (isHaveBtn == YES) {
        _line.alpha = 0;
        _moreBtn.alpha = 1;
        _moreIcon.alpha = 1;
        _moreLabel.alpha = 1;
        self.backgroundColor = RGB(235, 235, 241, 1);
    }else {
        _line.alpha = 1;
        _moreBtn.alpha = 0;
        _moreIcon.alpha = 0;
        _moreLabel.alpha = 0;
        self.backgroundColor = RGB(255, 255, 255, 1);
    }
}

- (void)setBtnTag:(NSInteger)tag {
    _moreBtn.tag = tag;
}

//更多
- (IBAction)moreClick:(UIButton *)sender {
    if (sender.tag == 1) {
        CreditUsedViewController *VC  = [[CreditUsedViewController alloc]init];
        VC.bankNo = self.bankNo;
        [self.viewController.navigationController  pushViewController:VC animated:YES];
        
    }else if (sender.tag == 5) {
        CardWelfareController *VC  = [[CardWelfareController alloc]init];
        [self.viewController.navigationController  pushViewController:VC animated:YES];
        
    }
}


@end
