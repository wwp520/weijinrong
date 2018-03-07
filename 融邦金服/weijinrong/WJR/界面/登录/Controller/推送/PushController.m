//
//  PushController.m
//  weijinrong
//
//  Created by RY on 17/6/16.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "PushController.h"

#pragma mark - 声明
@interface PushController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *body;

@end

#pragma mark - 实现
@implementation PushController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_model) {
        _name.text = _model.title;
        _body.text = _model.body;
        _date.text = ({
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            [formatter stringFromDate:date];
        });
    }
}



@end

