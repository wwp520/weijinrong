//
//  CTLoadingView.h
// 
//
//  Created by 郝高明 on 14-10-21.
//  Copyright (c) 2014年 郝高明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTLoadingView : UIView
@property (nonatomic,copy)NSString * str;
-(id)initWithFrame:(CGRect)frame withTitle:(NSString *)title;

-(id)initFailewithTitle:(NSString *)title index:(NSInteger)index;
//0 是没有导航   1有导航

@end
