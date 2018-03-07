//
//  MessageCell.m
//  chengzizhifu
//
//  Created by RY on 16/10/25.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)setBoldFont:(BOOL)isBoldFont{
    if (isBoldFont == YES) {
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }else {
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
    }
}


- (void)setDataWithModel:(MessageListModel *)model{
    self.timeLabel.text = model.time;
    self.titleLabel.text = model.content;
}
@end
