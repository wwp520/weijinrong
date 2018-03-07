//
//  ScanCodeView.h
//  weijinrong
//
//  Created by ouda on 17/6/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanCodeView : UIView

@property (nonatomic, strong) UILongPressGestureRecognizer *longG;
@property (nonatomic,copy) KKBlock click;
@property (weak, nonatomic) IBOutlet UIButton *ScanCodeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (nonatomic, copy) KKBlock longClick;
@end
