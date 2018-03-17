//
//  LoadCell.m
//  chengzizhifu
//
//  Created by Mac  on 16/5/12.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "LoadCell.h"
#import "LoadModel.h"

@implementation LoadCell
{
    UIImageView *_iconImage;
    UILabel *_titleLabel;
    UILabel *_detailLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    UIColor *titleColor = [UIColor grayColor];
    
    //icon
    CGFloat margin = 10;
    CGFloat rowHeight = 80;
    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(margin, (rowHeight-40)/2, 40, 40)];
    [self.contentView addSubview:iconImage];
    _iconImage = iconImage;
    
    //title
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(iconImage.right+15, 10, self.size.width-100, 30)];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    //detail
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(iconImage.right+15, rowHeight-35, titleLabel.width, 20)];
    detailLabel.font = [UIFont systemFontOfSize:12];
    detailLabel.textColor = titleColor;
    [self.contentView addSubview:detailLabel];
    _detailLabel = detailLabel;
    
    //access
    UIImageView *access = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-25, (rowHeight-20)/2, 20, 20)];
    access.image = [UIImage imageNamed:@"箭头"];
    [self.contentView addSubview:access];
    
}

#pragma mark - 公共方法
- (void)setDataWithModel:(LoadModel *)model {
    _iconImage.image = [UIImage imageNamed:model.iconStr];
    _detailLabel.text = model.detailTitle;
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:model.title];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:model.titleColor} range:NSMakeRange(0, 3)];
    _titleLabel.attributedText = attStr;
    
}
@end
