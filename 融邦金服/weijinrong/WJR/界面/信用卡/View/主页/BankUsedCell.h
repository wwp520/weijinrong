//
//  BankUsedCell.h
//  weijinrong
//
//  Created by ouda on 17/5/23.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankInfoSelectedModel.h"

@interface BankUsedCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;


- (void)setModel:(BankInfoSelectedModel *)model tag:(NSInteger)tag;

@end
