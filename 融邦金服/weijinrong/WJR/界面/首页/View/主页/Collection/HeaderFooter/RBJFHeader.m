//
//  RBJFHeader.m
//  weijinrong
//
//  Created by ouda on 17/6/7.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "RBJFHeader.h"

@implementation RBJFHeader

- (void)awakeFromNib {
    [super awakeFromNib];
   // [self location];
}

- (instancetype)initWithFrame:(CGRect)frame {
    //CGRectGetMaxY(self.lscrollView.frame)
    if (self = [super initWithFrame:frame]) {
        
        //白色view
        //_whiteView = [[UIView  alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.lscrollView.frame) , ScreenWidth, 20)];
        _whiteView = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        _whiteView.backgroundColor = [UIColor  whiteColor];
        [self  addSubview:_whiteView];
        
        //定位信息
        _locBtn = [[UIButton  alloc]initWithFrame:CGRectMake(ScreenWidth/2-120, 0, 240, 20)];
        [_locBtn  setTitleColor:[UIColor  redColor] forState:UIControlStateNormal];
        _locBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_locBtn  setImage:[UIImage imageNamed:@"加载.png"] forState:UIControlStateNormal];
        [_whiteView addSubview:_locBtn];
        
        //label
        _label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, ScreenWidth, 30)];
        _label.font = [UIFont  systemFontOfSize:16];
        _label.textColor = [UIColor  lightGrayColor];
        _label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_label];
        
    }
    return self;
}

- (HomeLocation *)location {
    if (!_location) {
        _location = [HomeLocation sharedHomeLocation:^(NSString *city, NSString *address) {
            NSLog(@"__________________________%@",address);
            //_locationLb.text = address;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                _locationLb.text = address;
            });
        } error:^{
            _locationLb.text = @"--";
        }];
    }
    return _location;
}



@end
