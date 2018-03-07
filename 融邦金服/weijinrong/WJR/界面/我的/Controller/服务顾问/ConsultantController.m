//
//  ConsultantController.m
//  chengzizhifu
//
//  Created by RY on 16/6/11.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "ConsultantController.h"
#import "AgentModel.h"
#import "Unity.h"



#define TitleColor [Unity getColor:@"#535353"]
#define OrangeColor [Unity getColor:@"#e56c2b"]
#define LineColor [Unity getColor:@"#ededed"]

@interface ConsultantController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ConsultantController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"服务顾问"];
    [self getInfo];
}

- (void)getInfo {
    
    [DongManager serverAgentInfo:^(id requestData) {
        [self hiddenHudLoadingView];
        AgentModel *model = [AgentModel decryptBecomeModel:requestData];
        if (model.retCode==0) {
            
            NSDictionary *dictName = [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"顾问名称:",@"code",
                                      model.agentName,@"name", nil];
            NSDictionary *dictPhone = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"顾问电话:",@"code",
                                       model.phoneNum,@"name", nil];
            NSDictionary *companyPhone = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"公司电话:",@"code",
                                          model.landlineNum,@"name", nil];
            self.dataSource = @[dictName,dictPhone,companyPhone];
            [self createSubviews];
        }else{
            [self showTitle:model.retMessage delay:1.5f];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
    
}

- (void)createSubviews {

    NSArray *imageArr = @[@"profile.png",@"verification.png",@"telephone.png"];
    
    for (int i=0; i<self.self.dataSource.count ; i++) {
        UIButton * button=[Unity buttonAddsuperview_superView:self.view _subViewFrame:CGRectMake(0,i*[Unity countcoordinatesY:120/2] + 64, ScreenWidth,[Unity countcoordinatesY:120/2]) _tag:self _action:@selector(btnClick:) _string:@"" _imageName:@""];
        button.tag=4000+i;
//            [button setBackgroundImage:[UIImage imageNamed:@"list_bg.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"list_bg_press.png"] forState:UIControlStateHighlighted];
        UILabel * line =[Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(0,[Unity countcoordinatesY:120/2]-1, ScreenWidth, 1) _string:@"" _lableFont:[UIFont systemFontOfSize:12] _lableTxtColor:[UIColor clearColor] _textAlignment:NSTextAlignmentCenter];
        line.backgroundColor=LineColor;
        UIImageView * image=[Unity imageviewAddsuperview_superView:button _subViewFrame:CGRectMake([Unity countcoordinatesX:40/2], (button.height-60/2)/2, [Unity countcoordinatesW:60/2], 60/2) _imageName:imageArr[i] _backgroundColor:[UIColor clearColor]];
        UILabel * titleLab= [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(image.right+[Unity countcoordinatesX:40/2],(button.height-80/2)/2, 90,80/2 ) _string:self.dataSource[i][@"code"] _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
        
        [Unity lableViewAddsuperview_superView:button _subViewFrame:CGRectMake(CGRectGetMaxX(titleLab.frame), (button.height-80/2)/2, 250, 80/2) _string:self.dataSource[i][@"name"] _lableFont:[UIFont systemFontOfSize:13] _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
    }

}

- (void)btnClick:(UIButton *)sender{
    if (sender.tag == 4000) {
        return;
    }
    NSDictionary *dict = self.dataSource[sender.tag-4000];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",dict[@"name"]]];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备暂时不支持拨号功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }

}

@end
