//
//  FeetEditViewController.m
//  chengzizhifu
//
//  Created by 快易 on 15/1/12.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "FeetEditViewController.h"
#import "FeetModel.h"
#import "Unity.h"
#define ViewFrame CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)

@interface FeetEditViewController ()<UITextViewDelegate>
@property (nonatomic,retain) UIScrollView * backGroundView;
@property (nonatomic,retain) UILabel * textviewplace;
@property (nonatomic,retain) UITextView * feedBackText;
@end

@implementation FeetEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self.view addSubview:[self bGroudView]];
}
- (void)createNavigation{
    [self setNavTitle:@"意见反馈"];
}
- (UIScrollView *)bGroudView{
    if (self.backGroundView==nil) {
        self.backGroundView=[[UIScrollView alloc]initWithFrame:ViewFrame];
        UITapGestureRecognizer * backGroundViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewTap:)];
        [self.backGroundView addGestureRecognizer:backGroundViewTap];
        UILabel * label=[Unity lableViewAddsuperview_superView:self.backGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2], [Unity countcoordinatesY:30/2], [Unity countcoordinatesW:200], [Unity countcoordinatesY:40]) _string:@"输入您的想法" _lableFont:TitleSize _lableTxtColor:[UIColor blackColor] _textAlignment:NSTextAlignmentLeft];
        
        UIImageView * imageView=[Unity imageviewAddsuperview_superView:self.backGroundView _subViewFrame:CGRectMake(label.left, label.top+label.height, ScreenWidth-2*[Unity countcoordinatesX:40/2],341/2) _imageName:@"feededit.png" _backgroundColor:[UIColor clearColor]];
        UITextView * view =[[UITextView alloc]init];
        view.frame=CGRectMake(2, [Unity countcoordinatesY:10], imageView.width-4, imageView.height-15);
        view.returnKeyType = UIReturnKeyDone;
        view.delegate=self;
        view.font=[UIFont systemFontOfSize:15];
        self.feedBackText=view;
        [imageView addSubview:view];
        self.textviewplace = [Unity lableViewAddsuperview_superView:self.feedBackText _subViewFrame:CGRectMake(2, 2, self.feedBackText.width-4, 20) _string:@"联系我们" _lableFont:TitleSize _lableTxtColor:[UIColor grayColor] _textAlignment:NSTextAlignmentLeft];
        self.textviewplace.textColor=[Unity getColor:@"#CCCCCC"];
        self.textviewplace.numberOfLines=0;
        imageView.userInteractionEnabled=YES;
        UIButton *button=[Unity buttonAddsuperview_superView:self.backGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2],imageView.top+imageView.height+[Unity countcoordinatesY:60], ScreenWidth-2*[Unity countcoordinatesX:40/2] ,75/2) _tag:self _action:@selector(btn:) _string:@"联系我们" _imageName:@""];
        [button setBackgroundImage:[UIImage imageNamed:@"orange_button.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"orange_button_press.png"] forState:UIControlStateHighlighted];
        self.backGroundView.contentSize=CGSizeMake(ScreenWidth, ScreenHeight);
    }
    return self.backGroundView;
}

//意见反馈
- (void)btn:(UIButton *)button{
    if ([self.feedBackText.text isEqualToString:@""]) {
        [self showTitle:@"请输入信息" delay:2];
    }else{
        [self showHudLoadingView:@"正在提交"];
        NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:self.feedBackText.text,@"opinon", nil];
        
        [DongManager chatUs:params success:^(id requestData) {
            [self hiddenHudLoadingView];
            FeetModel *model = [FeetModel decryptBecomeModel:requestData];
            if (model.retCode == 0) {
                [self showTitle:model.retMessage delay:1];
                [self popDelay];
                NSLog(@"@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@",requestData);
            }else{
                [self showTitle:model.retMessage delay:1];
            }
        } fail:^(NSError *error) {
            [self showNetFail];
        }];
    }
}


- (void)backGroundViewTap:(UITapGestureRecognizer *)tap{
    [self.feedBackText resignFirstResponder];
}
- (void)delayMethod {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.feedBackText resignFirstResponder];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.textviewplace.hidden = YES;
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        self.textviewplace.hidden = NO;
    }else{
        self.textviewplace.hidden = YES;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if ([text isEqualToString:@""] && range.length > 0) {
        return YES;
    }else{
        if (textView.text.length  >= 300) {
            return NO;
        }else {
            return YES;
        }
    }
    return YES;
}

@end
