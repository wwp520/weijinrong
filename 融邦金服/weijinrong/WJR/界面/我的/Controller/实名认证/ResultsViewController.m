//
//  ResultsViewController.m
//  chengzizhifu
//
//  Created by 快易 on 15/1/7.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "ResultsViewController.h"
#import "Unity.h"
#define ViewFrame CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)

@interface ResultsViewController ()
@property (nonatomic,retain) UIView * backGroundView;
@property (nonatomic,retain) UIView * downView;
@property (nonatomic,retain) UILabel * stateLab;
@property (nonatomic,retain) UIImageView * clockImage;
@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self.view addSubview:[self bGroundView]];
    _shortName = self.nameStr;
}

- (void)createNavigation{
    [self setNavTitle:@"认证结果"];
}

- (UIView *)bGroundView{
    if (self.backGroundView==nil) {
        self.backGroundView=[Unity backviewAddview_subViewFrame:ViewFrame _viewColor:[UIColor whiteColor]];
//        UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, [Unity countcoordinatesY:166/2])];
//        view.backgroundColor=[Unity getColor:@"#464646"];
//        [self.backGroundView addSubview:view];
//        UIImageView * timeImage=[Unity imageviewAddsuperview_superView:view _subViewFrame:CGRectMake([Unity countcoordinatesX:60/2], (view.height-[Unity countcoordinatesY:60/2])/2, [Unity countcoordinatesX:30], 30) _imageName:@"clock.png" _backgroundColor:[UIColor clearColor]];
//        [Unity lableViewAddsuperview_superView:view _subViewFrame:CGRectMake(timeImage.right+[Unity countcoordinatesX:10], (view.height-[Unity countcoordinatesY:40])/2, [Unity countcoordinatesW:200], [Unity countcoordinatesY:40]) _string:@"正在认证中......" _lableFont:[UIFont systemFontOfSize:24] _lableTxtColor:[UIColor redColor] _textAlignment:NSTextAlignmentLeft];
        UIImageView * nameImage=[Unity imageviewAddsuperview_superView:self.backGroundView _subViewFrame:CGRectMake(0, 0, ScreenWidth,[Unity countcoordinatesY:120/2]) _imageName:@"" _backgroundColor:[UIColor clearColor]];
        nameImage.userInteractionEnabled=YES;

        [Unity lableViewAddsuperview_superView:nameImage _subViewFrame:CGRectMake([Unity countcoordinatesX:20],(nameImage.height-[Unity countcoordinatesY:30])/2 ,ScreenWidth-[Unity countcoordinatesX:20] , [Unity countcoordinatesY:30]) _string:[NSString stringWithFormat:@"真实姓名: %@",self.nameStr] _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        UILabel * line=[Unity lableViewAddsuperview_superView:nameImage _subViewFrame:CGRectMake([Unity countcoordinatesX:20/2], nameImage.height-1, ScreenWidth-2 * [Unity countcoordinatesX:20/2], 1) _string:@"" _lableFont:TitleSize _lableTxtColor:[UIColor clearColor] _textAlignment:NSTextAlignmentLeft];
        line.backgroundColor=LineColor;
        
        UIImageView * IDImage=[Unity imageviewAddsuperview_superView:self.backGroundView _subViewFrame:CGRectMake(0, nameImage.height, ScreenWidth,[Unity countcoordinatesY:120/2] ) _imageName:@"" _backgroundColor:[UIColor clearColor]];
        IDImage.userInteractionEnabled=YES;

        [Unity lableViewAddsuperview_superView:IDImage _subViewFrame:CGRectMake([Unity countcoordinatesX:20],(IDImage.height-[Unity countcoordinatesY:30])/2 ,ScreenWidth-[Unity countcoordinatesX:20] , [Unity countcoordinatesY:30]) _string:[NSString stringWithFormat:@"证件号码: %@",self.IDStr] _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        UILabel * line1=[Unity lableViewAddsuperview_superView:IDImage _subViewFrame:CGRectMake([Unity countcoordinatesX:20/2], IDImage.height-1, ScreenWidth-2 * [Unity countcoordinatesX:20/2], 1) _string:@"" _lableFont:TitleSize _lableTxtColor:[UIColor clearColor] _textAlignment:NSTextAlignmentLeft];
        line1.backgroundColor=LineColor;
        
        UIImageView * cardImage=[Unity imageviewAddsuperview_superView:self.backGroundView _subViewFrame:CGRectMake(0, IDImage.top+IDImage.height, ScreenWidth,[Unity countcoordinatesY:120/2] ) _imageName:@"" _backgroundColor:[UIColor clearColor]];
        IDImage.userInteractionEnabled=YES;

        [Unity lableViewAddsuperview_superView:cardImage _subViewFrame:CGRectMake([Unity countcoordinatesX:20],(cardImage.height-[Unity countcoordinatesY:30])/2 ,ScreenWidth-[Unity countcoordinatesX:20] , [Unity countcoordinatesY:30]) _string:[NSString stringWithFormat:@"银行卡号: %@",self.cardStr] _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        UILabel * line2=[Unity lableViewAddsuperview_superView:cardImage _subViewFrame:CGRectMake(0, cardImage.height-1, ScreenWidth, 1) _string:@"" _lableFont:TitleSize _lableTxtColor:[UIColor clearColor] _textAlignment:NSTextAlignmentLeft];
        line2.backgroundColor=LineColor;
        
        self.downView =[Unity backviewAddview_subViewFrame:CGRectMake(0,ScreenHeight-64-60, ScreenWidth, 60) _viewColor:[UIColor clearColor]];
        [self.bGroundView addSubview:self.downView];
        UILabel * viewLine=[Unity lableViewAddsuperview_superView:self.downView _subViewFrame:CGRectMake(0, 1, ScreenWidth, 1) _string:@"" _lableFont:TitleSize _lableTxtColor:LineColor _textAlignment:NSTextAlignmentCenter];
        viewLine.backgroundColor=LineColor;
        
        self.stateLab=[Unity lableViewAddsuperview_superView:self.downView _subViewFrame:CGRectMake(ScreenWidth/2-([Unity countcoordinatesX:50]+[Unity countcoordinatesX:10]+33/2)/2, (self.downView.height-33/2)/2, [Unity countcoordinatesX:150/2], 33/2) _string:@"审核中" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        self.clockImage=[Unity imageviewAddsuperview_superView:self.downView _subViewFrame:CGRectMake([Unity countcoordinatesX:230/2], (self.downView.height-33/2)/2, 33/2, 33/2) _imageName:@"clock1.png" _backgroundColor:[UIColor clearColor]];

        self.stateLab.frame=CGRectMake(ScreenWidth/2-([self configContentview:Internationalization(@"Results_audit")].width)/2+33/2, (self.downView.height-33/2)/2, [self configContentview:Internationalization(@"Results_audit")].width, 33/2);
        self.clockImage.frame=CGRectMake(self.stateLab.left-24, (self.downView.height-33/2)/2, 33/2, 33/2);
    }
    return self.backGroundView;
}
- (CGSize)configContentview:(NSString *)str{
    CGSize theStringSize = [str sizeWithFont:TitleSize
                           constrainedToSize:CGSizeMake([Unity countcoordinatesX:640/2], [Unity countcoordinatesY:60/2])
                               lineBreakMode:0];
    return theStringSize;
}
- (void)leftBtnPressed:(id)sender{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"state" object:nil];
    _mercSts = @"60";
    SaveAccount(@"60");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
