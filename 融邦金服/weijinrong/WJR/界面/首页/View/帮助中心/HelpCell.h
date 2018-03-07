//
//  HelpCell.h
//  weijinrong
//
//  Created by ouda on 17/6/21.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpCell : UITableViewCell
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UILabel * titleLb;
@property(nonatomic,strong)UILabel * contentLb;
- (void)setData:(NSString *)text;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;  //内容

@property (weak, nonatomic) IBOutlet UILabel *subTitleLb;  //主题

@end
