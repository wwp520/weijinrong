//
//  MessageCell.h
//  chengzizhifu
//
//  Created by RY on 16/10/25.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageListModel.h"

@interface MessageCell : BaseCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
- (void)setBoldFont:(BOOL)isBoldFont;
- (void)setDataWithModel:(MessageListModel *)model;
@end
