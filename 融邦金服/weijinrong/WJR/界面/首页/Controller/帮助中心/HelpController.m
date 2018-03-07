//
//  HelpController.m
//  weijinrong
//
//  Created by ouda on 17/6/18.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "HelpController.h"
#import "HomeBtn.h"
#import "HelpCell.h"


@interface HelpController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)NSURL * url;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation HelpController

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [_tableView setLineHide];
        [self.view  addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"帮助中心";
//    [self createWebView];
    [self tableView];
    
    [self.navigationItem setRightBarButtonItem:({
        HomeBtn *home = [HomeBtn initLeftTitle:@"" icon:@"HomeHelp"];
        UIButton *btn = (UIButton *)home.customView;
        [btn addTarget:self action:@selector(helpClick:) forControlEvents:UIControlEventTouchUpInside];
        home;
    })];

}

//打电话的弹窗
- (void)helpClick:(UIButton *)btn{
    NSURL *url = [NSURL URLWithString:@"telprompt://4000029699"];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备暂时不支持拨号功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"1.扫码完成,为什么没有到账？";
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.text = @"\n扫码之后钱不会立即到绑定的收款账号，扫码成功后金额会在APP的扫码余额里，需要点击提款才能完成到账。";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.numberOfLines = 0;
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"2.提款时提示下单失败,后台报错数字";
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.text = @"\n商户信息如法人名字或者结算银行卡有误导致打款不成功，需要更改正确信息之后在进行提款。";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"3.提款显示错码“9997”？";
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.text = @"\n属于网络原因导致的超时，T1工作日返回至扫码余额或者直接到结算银行卡。";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"4.商户已扣款,后台显示未支付,未到账?";
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.text = @"\n极少极少数才会出现这种情况，属于超时现象如若出现会在1-3个工作日内返回余额或者直接到结算银行卡。";
    }else if (indexPath.row == 4){
        cell.textLabel.text = @"5.客服的联系方式是什么?";
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.text = @"\n若有问题可拨打电话联系我们的人工客户，客服电话：400-0029699";
    }
    return cell;
}


#pragma mark--UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


//创建web网页
- (void)createWebView{
    self.webView=[[UIWebView  alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    _webView.delegate = self;
    [self.view  addSubview:self.webView];
   
    _url = [NSURL URLWithString:@""];
    NSURLRequest * request = [NSURLRequest  requestWithURL:_url];
    [self.webView  loadRequest:request];
    
}

@end
