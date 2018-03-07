//
//  CardLinkController.m
//  weijinrong
//
//  Created by ouda on 17/5/26.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CardLinkController.h"
#import "BaseModel.h"

@interface CardLinkController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)BaseModel * basemodel;
@property(nonatomic,strong)NSString * cuName;
@property(nonatomic,strong)NSString * cuIdentity;
@property(nonatomic,strong)NSString *cuMobilePhone;
@property(nonatomic,strong)NSURL  * url;
@property(nonatomic,strong) NSString * str;
@end

@implementation CardLinkController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"信用卡申请";
    [self createWebView];
}

- (void)getInfo{
    //     [self  showHudLoadingView:@"正在获取。。。"];
    //cuName
    //cuIdentity
    //cuMobilePhone
    NSInteger cityid = [KKStaticParams sharedKKStaticParams].cityId;
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:
                         [NSDictionary dictionaryWithObjectsAndKeys:
                          [SaveManager  getStringForKey:@"mercId"],@"mercId",
                          _model.bankName,@"bankNo", //银行编号
                          _cuName,@"applicantName",  //申请人姓名
                          _cuIdentity,@"crpIdNo",    //身份证号
                          _cuMobilePhone,@"mobilephone",        //手机号
                          _model.id,@"id",     //办卡接口返回的id
                          @(cityid),@"bdcitycode",
                          nil]];
        [KKTools encryptionJsonString:str];
    })];
    
    
    [DongManager ApplicationCard:oldParam success:^(id requestData) {
        _basemodel = [BaseModel decryptBecomeModel:requestData];
        if (_basemodel.retCode == 0) {
            [self showTitle:_basemodel.retMessage delay:1.5f];
            NSLog(@"*****************拦截信息上传成功***********");
        }else{
            [self showTitle:_basemodel.retMessage delay:1.5f];
        }
    } fail:^(NSError *error) {
        [self  showNetFail];
    }];
}


//创建web网页
- (void)createWebView{
    self.webView=[[UIWebView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    _webView.delegate = self;
    [self.view  addSubview:self.webView];
    // _model.cardLink     _urls
    //    _url=[NSURL URLWithString:_model.cardLink];
    _url = [NSURL URLWithString:_openUrl];
    NSURLRequest * request = [NSURLRequest  requestWithURL:_url];
    _str = [_url  absoluteString];
    [self.webView  loadRequest:request];
    
}

//获取ID
- (NSString *)getValueById:(NSString *)ID value:(NSString *)value {
    value = (value == nil || value.length == 0) ? @"value" : value;
    NSString * str1 = [NSString  stringWithFormat:@"document.getElementById(\"%@\").%@;",ID,value];
    NSString *realname = [_webView stringByEvaluatingJavaScriptFromString:str1];
    return realname;
}
- (NSArray *)getBankIsDou:(NSString *)str {
    str = str == nil ? @"" : str;
    
    NSArray *arr = [str componentsSeparatedByString:@","];
    if (arr.count >= 2) {
        return arr;
    }
    else {
        return @[arr[0],@""];
    }
}



#pragma mark - WebViewDelegate
//每次网页跳转的时候都会走此方法     UIWebViewNavigationTypeLinkClicked
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // @"LblName,innerText"
    //@"MobilePhone"
    //@"LblNum,innerText"
    
    NSArray *names = [self getBankIsDou:_model.interceptName];// 姓名
    NSArray *phones = [self getBankIsDou:_model.interceptPhone];// 手机号
    NSArray *carditIDs = [self getBankIsDou:_model.interceptIdentity];// 身份证号
    
    if (_cuName.length == 0) {
        _cuName = [self getValueById:names[0] value:names[1]];
    }
    if (_cuMobilePhone.length == 0) {
        _cuMobilePhone = [self getValueById:phones[0] value:phones[1]];
    }
    if (_cuIdentity.length == 0) {
        _cuIdentity = [self getValueById:carditIDs[0] value:carditIDs[1]];
    }
    NSLog(@"****************_cuIdentity =  %@",_cuIdentity);
    if ((_cuName .length!=0) &&( _cuIdentity.length!= 0) && (_cuMobilePhone.length!=0)){
        [self  getInfo];
    }
    return YES;
}

#pragma mark--无用
- (void)webViewDidStartLoad:(UIWebView *)webView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenHudLoadingView];
    });
}



- (void)setModel:(CardBenifitListModel *)model{
    _model = model;
}


@end
