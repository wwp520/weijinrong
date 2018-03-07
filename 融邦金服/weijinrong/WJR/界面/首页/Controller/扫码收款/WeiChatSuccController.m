//
//  WeiChatSuccessController.m
//  chengzizhifu
//
//  Created by Mac on 16/11/3.
//  Copyright © 2016年 ZYH. All rights reserved.
//

extern NSString * successStr;
#import "WeiChatSuccController.h"
#import "ScanCodePayController.h"
#import "Unity.h"

#define ViewFrame CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height )
#pragma mark 声明
@interface WeiChatSuccController ()
@property (nonatomic,retain) UIView * bGroundView;
@property (nonatomic,retain) UILabel * nameLab;
@property (nonatomic,retain) UILabel * praceLab;
@property (nonatomic,retain) UILabel * orderLab;
@property (nonatomic, weak) UIImageView *successImage;//签购单
@end

#pragma mark 实现
@implementation WeiChatSuccController


//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    if ([Unity currentVersion]==ios6) {
//        [self.tabBarController setTabBarHidden:YES];
//    }
//    self.tabBarController.tabBar.hidden=YES;
//}
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    if ([Unity currentVersion]==ios6) {
//        [self.tabBarController setTabBarHidden:YES];
//    }
//    self.tabBarController.tabBar.hidden=YES;
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    if ([Unity currentVersion]==ios6) {
//        [self.tabBarController setTabBarHidden:NO];
//    }
//    self.tabBarController.tabBar.hidden=NO;
//}
- (void)leftClick {
    BaseViewController *vc;
    for (BaseViewController *subVc in self.navigationController.viewControllers) {
        if ([subVc isKindOfClass:[ScanCodePayController class]]) {
            vc = subVc;
        }
    }
    if (vc) {
        [self.navigationController popToViewController:vc animated:YES];
    }else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self.view addSubview:[self quiryBackGView]];
}
- (void)createNavigation{
    [self setNavTitle:@"支付成功"];
}
- (UIView *)quiryBackGView {
    if (self.bGroundView==nil) {
        self.bGroundView=[Unity backviewAddview_subViewFrame:ViewFrame _viewColor:[UIColor whiteColor]];
        UIImageView * sImage=[Unity imageviewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(ScreenWidth/2-[Unity countcoordinatesW:88/2]/2, [Unity countcoordinatesY:60/2], [Unity countcoordinatesW:88/2], 80/2) _imageName:@"complete.png" _backgroundColor:[UIColor clearColor]];
        UILabel * gxLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(ScreenWidth/2-[Unity countcoordinatesX:300/2]/2, sImage.top+sImage.height+[Unity countcoordinatesY:20/2], [Unity countcoordinatesX:300/2], 25) _string:_stateStr _lableFont:[UIFont systemFontOfSize:17] _lableTxtColor:[Unity getColor:@"#009944"] _textAlignment:NSTextAlignmentCenter];
        UILabel * detailLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(0, gxLab.top+gxLab.height+[Unity countcoordinatesY:8/2],ScreenWidth , 25) _string:@"感谢您使用融邦金服" _lableFont:[UIFont systemFontOfSize:12] _lableTxtColor:[Unity getColor:@"#9e9e9e"] _textAlignment:NSTextAlignmentCenter];
        UILabel * line=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(0, detailLab.top+detailLab.height+[Unity countcoordinatesY:32/2], ScreenWidth, 1) _string:@"" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentCenter];
        line.backgroundColor=LineColor;
        
        
        
        
        UILabel * praceLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:50/2], line.top+line.height, [Unity countcoordinatesX:180/2], 40) _string:@"支付金额:" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        self.praceLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(praceLab.right+[Unity countcoordinatesX:10],line.top+line.height, [Unity countcoordinatesW:200], 40) _string:[NSString stringWithFormat:@"%@元",_money] _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        [Unity imageviewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2],praceLab.top+praceLab.height , ScreenWidth-2*[Unity countcoordinatesX:40/2], 1) _imageName:@"the_dotted_line_.png" _backgroundColor:[UIColor clearColor]];
        UILabel * orderLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:50/2], self.praceLab.top+self.praceLab.height+1, [Unity countcoordinatesX:150/2], 40) _string:@"订  单  号:" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        self.orderLab=[Unity lableViewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(praceLab.right+[Unity countcoordinatesX:10],self.praceLab.top+self.praceLab.height+1, [Unity countcoordinatesW:200], [self configContentview]) _string:[NSString stringWithFormat:@"%@",_orderNum] _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        self.orderLab.numberOfLines=0;
        [Unity imageviewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2],orderLab.top+orderLab.height , ScreenWidth-2*[Unity countcoordinatesX:40/2], 1) _imageName:@"line_down.png" _backgroundColor:[UIColor clearColor]];
        
       
        
        [Unity imageviewAddsuperview_superView:self.bGroundView _subViewFrame:CGRectMake(0, self.orderLab.top+self.orderLab.height, ScreenWidth, 20) _imageName:@"line_down.png" _backgroundColor:[UIColor clearColor]];
    }
    return self.bGroundView;
}
- (CGFloat)configContentview{
    CGFloat height = [Unity getLabelHeightWithWidth:290 andDefaultHeight:40 andFontSize:15 andText:_orderNum];
    return height;
}




@end
