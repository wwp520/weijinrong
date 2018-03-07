//
//  HomeHeader.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "HomeHeader.h"

#pragma mark 声明
@interface HomeHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *icon1;
@property (weak, nonatomic) IBOutlet UILabel *name1;
@property (nonatomic, copy) KKIntBlock click;
@end

#pragma mark 实现
@implementation HomeHeader

#pragma mark 初始化

- (void)setModel:(LoginModel *)model {
    _model = model;
    if (model && model.modelTypes.count != 0) {
        LoginItemModel *model1 = model.modelTypes[0][0];
        LoginItemModel *model2 = model.modelTypes[0][1];
        [_icon1 sd_setImageWithURL:[NSURL URLWithString:model1.imageurl] placeholderImage:[UIImage imageNamed:@"Home_placehoder"]];
        [_icon2 sd_setImageWithURL:[NSURL URLWithString:model2.imageurl] placeholderImage:[UIImage imageNamed:@"Home_placehoder"]];
        [_name1 setText:model1.businessname];
        [_name2 setText:model2.businessname];
    }
}

- (void)setClick:(KKIntBlock)click {
    _click = click;
}

- (IBAction)headerClick:(UIButton *)sender {
    if (_click) {
        _click(sender.tag);
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self location];
}

- (HomeLocation *)location {
//    if (!_location) {
        _location = [HomeLocation sharedHomeLocation:^(NSString *city, NSString *address) {
            _locationLb.text = address;
        } error:^{
            _locationLb.text = @"获取位置信息失败";
        }];
//    }
    return _location;
}



@end
