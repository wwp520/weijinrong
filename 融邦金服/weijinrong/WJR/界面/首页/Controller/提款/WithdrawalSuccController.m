//
//  WithdrawalSuccController.m
//  chengzizhifu
//
//  Created by 快易 on 15/1/27.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//
#import "WithdrawalSuccController.h"
#import "Unity.h"
#define ViewFrame CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)

@interface WithdrawalSuccController ()
@property (nonatomic,retain) UIView * bGroundView;
@property (nonatomic,retain) UILabel * nameLab;
@property (nonatomic,retain) UILabel * praceLab;
@property (nonatomic,retain) UILabel * orderLab;
@property (nonatomic,retain) UILabel * timeLab;
@end

@implementation WithdrawalSuccController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    NSLog(@"%@",self.orderNumber);
    [self.view addSubview:[self BackGView]];
}
- (void)createNavigation{
    [self setNavTitle:@"支付成功"];
}

- (void)leftClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)leftBtnPressed:(id)sender{
    _successStr = @"1";
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIView *)BackGView {
    if (self.bGroundView==nil) {
        self.bGroundView=[Unity backviewAddview_subViewFrame:ViewFrame _viewColor:[UIColor whiteColor]];
        UIImageView * sImage=[Unity imageviewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(ScreenWidth/2-[Unity countcoordinatesW:88/2]/2, [Unity countcoordinatesY:60/2], [Unity countcoordinatesW:88/2], 80/2) _imageName:@"complete.png" _backgroundColor:[UIColor clearColor]];
        UILabel * gxLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(ScreenWidth/2-[Unity countcoordinatesX:300/2]/2, sImage.top+sImage.height+[Unity countcoordinatesY:20/2], [Unity countcoordinatesX:300/2], 25) _string:@"恭喜啦,支付已成功!" _lableFont:[UIFont systemFontOfSize:17] _lableTxtColor:[Unity getColor:@"#009944"] _textAlignment:NSTextAlignmentCenter];
        UILabel * detailLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(0, gxLab.top+gxLab.height+[Unity countcoordinatesY:8/2],ScreenWidth , 25) _string:@"感谢您使用融邦金服" _lableFont:[UIFont systemFontOfSize:12] _lableTxtColor:[Unity getColor:@"#9e9e9e"] _textAlignment:NSTextAlignmentCenter];
        UILabel * line=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(0, detailLab.top+detailLab.height+[Unity countcoordinatesY:32/2], ScreenWidth, 1) _string:@"" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentCenter];
        line.backgroundColor=LineColor;
        
        UILabel * business=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:50/2],line.top+line.height, [Unity countcoordinatesX:150/2] , 40) _string:[NSString stringWithFormat:@"商户姓名:"] _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        self.nameLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(business.right+[Unity countcoordinatesX:10],business.top, [Unity countcoordinatesW:200], 40) _string:self.merchatName _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        [Unity imageviewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2],business.top+business.height , ScreenWidth-2*[Unity countcoordinatesX:40/2], 1) _imageName:@"the_dotted_line_.png" _backgroundColor:[UIColor clearColor]];
        UILabel * praceLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:50/2], self.nameLab.top+self.nameLab.height+1, [Unity countcoordinatesX:150/2], 40) _string:@"支付金额:" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        //Internationalization(@"yuan")
        self.praceLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(praceLab.right+[Unity countcoordinatesX:10],self.nameLab.top+self.nameLab.height+1, [Unity countcoordinatesW:200], 40) _string:[NSString stringWithFormat:@"%@元",self.payAmount] _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        [Unity imageviewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2],praceLab.top+praceLab.height , ScreenWidth-2*[Unity countcoordinatesX:40/2], 1) _imageName:@"the_dotted_line_.png" _backgroundColor:[UIColor clearColor]];
        UILabel * orderLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:50/2], self.praceLab.top+self.praceLab.height+1, [Unity countcoordinatesX:150/2], 40) _string:@"订  单  号:" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        self.orderLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(praceLab.right+[Unity countcoordinatesX:10],self.praceLab.top+self.praceLab.height+1, [Unity countcoordinatesW:200], [self configContentview]) _string:[NSString stringWithFormat:@"%@",self.orderNumber] _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        self.orderLab.numberOfLines=0;
        [Unity imageviewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2],orderLab.top+orderLab.height , ScreenWidth-2*[Unity countcoordinatesX:40/2], 1) _imageName:@"the_dotted_line_.png" _backgroundColor:[UIColor clearColor]];
        UILabel * timeLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:50/2], self.orderLab.top+self.orderLab.height+1, [Unity countcoordinatesX:150/2], 40) _string:@"交易时间:" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        self.timeLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(timeLab.right+[Unity countcoordinatesX:10],self.orderLab.top+self.orderLab.height+1, [Unity countcoordinatesW:200], 40) _string:[NSString stringWithFormat:@"%@",self.tradingHours] _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        
        [Unity imageviewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(0, self.timeLab.top+self.timeLab.height, ScreenWidth, 20) _imageName:@"line_down.png" _backgroundColor:[UIColor clearColor]];
    }
    return self.bGroundView;
}
- (CGFloat)configContentview {
    CGFloat height = [Unity getLabelHeightWithWidth:290 andDefaultHeight:40 andFontSize:15 andText:self.orderNumber];
    return height;
}

-(void)setType:(NSString *)type{
    _type = type;
}
@end
