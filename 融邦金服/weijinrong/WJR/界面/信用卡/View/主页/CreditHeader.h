//
//  CreditHeader.h
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreditHeader : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *name;
// 是否有更多
- (void)haveMorebtn:(BOOL)isHaveBtn;
// 设置tag
- (void)setBtnTag:(NSInteger)tag;

@property(nonatomic,strong) NSString *bankNo;
@end
