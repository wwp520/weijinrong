//
//  CTLoadingView.m
//  
//
//  Created by 郝高明 on 14-10-21.
//  Copyright (c) 2014年 郝高明. All rights reserved.
//

#import "CTLoadingView.h"
#import "Unity.h"

@implementation CTLoadingView

-(id)initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        
        CGRect rect = self.frame;
        rect.size.width = 80;
        rect.size.height = 80;
        self.frame = rect;
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;  //透明度
        
        self.layer.cornerRadius = 8.0f; //设置view圆角
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.frame = CGRectMake(40-37/2, 10, 37, 37);
        activityView.hidesWhenStopped = YES;
      
        [activityView startAnimating];
        
        [self addSubview:activityView];
        
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 80, 25)];
        lab.text = title;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont fontWithName:@"Helvetica" size:14];
        
        [self addSubview:lab];
        
    }
    
    
    return self;
}

-(id)initFailewithTitle:(NSString *)title index:(NSInteger)index
{
    if (self =[super init]) {
        self.str=title;
        CGSize constraint = CGSizeMake(1000, 30);
        if (index==2) {
            constraint = CGSizeMake(320*2/3, [self configContentview]);
        }
        CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        if (index==0) {
            self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-(size.width+30)/2, ScreenHeight/2-(size.height+100)/2, size.width+30, size.height+20);
        }else{
            self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-(size.width+30)/2, ScreenHeight/2-(size.height+100)/2-50, size.width+30, size.height+20);
        }
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 1;  //透明度
        self.layer.cornerRadius = 8.0f; //设置view圆角
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15,10,size.width,size.height)];
        lab.text = title;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = [UIColor whiteColor];
//        lab.font = [UIFont fontWithName:@"Helvetica" size:17];
        lab.font =[UIFont systemFontOfSize:17];
        lab.numberOfLines=0;
        [self addSubview:lab];
    }
    
    return self;
}
-(CGFloat)configContentview
{
    CGFloat height = [Unity getLabelHeightWithWidth:320*2/3 andDefaultHeight:30 andFontSize:17 andText:self.str];
    return height;
}
@end
