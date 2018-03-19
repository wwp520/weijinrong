//
//  AttestationView.h
//  chengzizhifu
//
//  Created by RY on 16/12/28.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttestationView : UIView
@property (weak, nonatomic) IBOutlet UITextField *photoTF;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;

@property (weak, nonatomic) IBOutlet UIImageView *photo2Image;

@property (strong, nonatomic) IBOutlet UITextField *business;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *idCard;
@property (strong, nonatomic) IBOutlet UITextField *bank;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *bankCard;


@property (nonatomic,assign) NSInteger index;

@property (nonatomic, strong) NSString *mobilephone;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *bankCode;
#pragma mark 初始化
+ (instancetype)initWithFrame:(CGRect)frame;
- (UITextField *)getFirst;

@end
