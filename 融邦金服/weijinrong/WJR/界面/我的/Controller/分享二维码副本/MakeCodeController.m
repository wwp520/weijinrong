//
//  MakeCodeController.m
//  weijinrong
//
//  Created by ouda on 17/5/23.
//  Copyright © 2017年 oudapay. All rights reserved.
//
//1e2199510e388            fa73a3f3bb71a7a7745e3e6a30e1ad63

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#import "MakeCodeController.h"
#import <UShareUI/UShareUI.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"
#import "MakeCodeController.h"
#import "Code39.h"
#import "CodeAddStateModel.h"

@interface MakeCodeController ()
@property (weak, nonatomic) IBOutlet UITextField *scaleTF;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIImageView *code;
@property (weak, nonatomic) IBOutlet UILabel *introLb;
@property (weak, nonatomic) IBOutlet UIView *line;
@property(nonatomic,strong)NSArray * titleArray;
@property (weak, nonatomic) IBOutlet UIImageView *iconQr;

@property (weak, nonatomic) IBOutlet UILabel *scaelLb;   //设置比例

@property (nonatomic, strong) UIImage *image;
@property(nonatomic,strong)NSArray * imageArry;
@end

@implementation MakeCodeController

- (NSArray *)imageArry{
    if (!_imageArry) {
        _imageArry = @[@"微信好友.png",@"朋友圈.png",@"qq.png",@"qq空间.png"];
    }
    return _imageArry;
}


- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"微信",@"朋友圈",@"QQ",@"空间"];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"分享二维码"];
    [self createUI];
    [self createData];
    NSString * scaleMin = [KKStaticParams sharedKKStaticParams].profitMin;
    NSString * scaleMax = [KKStaticParams sharedKKStaticParams].profitMax;
    _scaelLb.text = [NSString stringWithFormat:@"(%@-%@)",scaleMin,scaleMax];
    
}
// 请求
- (void)replace {
    [self showHudLoadingView:@"正在修改比例"];
    NSString *oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [SaveManager getStringForKey:@"mercId"],@"mercId",
                                                   _scaleTF.text,@"profit",
                                                   _model.Id,@"id",nil]];
        [KKTools encryptionJsonString:str];
    })];
   
    [DongManager shareQRReplace:oldParam success:^(id requestData) {
        [self hiddenHudLoadingView];
        BaseModel *model = [BaseModel decryptBecomeModel:requestData];
        if (model.retCode == 0) {
            [self showTitle:model.retMessage delay:2];
        }else {
            [self showTitle:model.retMessage delay:2];
        }
        
    } fail:^(NSError *error) {
        [self showNetFail];
    }];

}
// 新增
- (void)add {
    
    [self showHudLoadingView:@"正在新增比例"];
    NSString *oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                [SaveManager getStringForKey:@"mercId"],@"mercId",
                                _scaleTF.text,@"profit",nil]];
        [KKTools encryptionJsonString:str];
    })];
//    NSDictionary *params2 = [[NSDictionary alloc] initWithObjectsAndKeys:
//                             GetAccount, @"userName",
//                             @"PmsCreditInfoAction/insertRecommend.action",@"url",
//                             [SaveManager getStringForKey:@"token"],@"token",
//                             [SaveManager getStringForKey:@"session"],@"session",
//                             oldParam,@"inParam",nil];
    
    
    [DongManager shareQRAdd:oldParam success:^(id requestData) {
        [self hiddenHudLoadingView];
        CodeAddStateModel *model = [CodeAddStateModel decryptBecomeModel:requestData];
        if (model.retCode == 0) {
            [self showTitle:model.retMessage delay:2];
            [self createModel:model];
        }else {
            [self showTitle:model.retMessage delay:2];
        }
        
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}
// 点击保存
- (IBAction)saveBtnClick:(UIButton *)sender {
    if (_scaleTF.text.length == 0) {
        [self showTitle:@"请输入赚红包比例" delay:1];
    }else if (_scaleTF.text.length > 5){
        [self showTitle:@"不得超过5个字符" delay:1];
    }else if ([_scaleTF.text floatValue] < 0) {
        [self showTitle:@"输入比例不正确" delay:1];
    }else {
        [_scaleTF endEditing:YES];
        // 修改
        if (_model) {
            [self replace];
        }
        // 新增
        else {
            [self add];
        }
    }
}
// 设置数据
- (void)setModel:(ShareCodeListSubModel *)model {
    _model = model;
}
// 创建Model
- (void)createModel:(CodeAddStateModel *)model {
    _model = [[ShareCodeListSubModel alloc] init];
    _model.Id = model.id;
    _model.profit = _scaleTF.text;
    [self createData];
}
// 界面
- (void)createUI {
    _saveBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    if (ScreenWidth <= 320) {
        _scaleTF.font = [UIFont systemFontOfSize:14];
    }
    _iconQr.layer.borderWidth = 5;
    _iconQr.layer.borderColor = [UIColor whiteColor].CGColor;
    
     //分享按钮
//    NSInteger clomn = 4;
    CGFloat  btnW = 60;

    CGFloat margin = (ScreenWidth - 4 * btnW)/5;
    for (int i=0; i<4; i++) {
        UIButton * btn = [[UIButton  alloc]initWithFrame:CGRectMake(margin+i*(margin+btnW), ScreenHeight-180, btnW, 60)];
        btn.tag = i;
//        btn.backgroundColor = [UIColor redColor];
        [btn setImage:[UIImage imageNamed:self.imageArry[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(margin+i*(margin+btnW), CGRectGetMaxY(btn.frame), btnW, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.titleArray[i];
        label.textColor = [UIColor blackColor];
        [self.view addSubview:label];
    }
}

// 更新数据
- (void)createData {
    if (_model) {
       
        _introLb.text = [NSString stringWithFormat:@"推荐码： %@",_model.Id];
        _scaleTF.text = _model.profit;
        NSString *html = [NSString stringWithFormat:@"%@/link?param=dzgResign.html",KHost];
        NSString *str = [NSString stringWithFormat:@"%@?mercId=%@%%26genenralize=%@",html,[SaveManager getStringForKey:@"mercId"],_model.Id];
        
        _code.image = [Code39 code39ImageFromString:str Width:250.f Height:250.f];
        _image = _code.image;
        _iconQr.image = [UIImage imageNamed:@"qricon"];
//        _iconQr.image = [UIImage imageNamed:@"theicon"];
    }
}

// 友盟分享功能
- (void)btnClick:(UIButton *)btn {
    if (!_image) {
        [self showTitle:@"请先生成二维码" delay:1.5f];
        return;
    }
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:@"欢迎进入融邦金服" images:@[self.image] url:nil title:@"融邦金服" type:SSDKContentTypeAuto];
//    
//    [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//        // 成功
//        if (state == SSDKResponseStateSuccess) {
//            
//        }
//    }];

    if (btn.tag == 0) {   //微信
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:@"欢迎进入融邦金服" images:@[self.image] url:nil title:@"融邦金服" type:SSDKContentTypeAuto];
        
            [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                // 成功
                if (state == SSDKResponseStateSuccess) {
                    
                }
            }];
    }
    if (btn.tag == 1) {   //朋友圈
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"欢迎进入融邦金服" images:@[self.image] url:nil title:@"融邦金服" type:SSDKContentTypeAuto];
        
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            // 成功
            if (state == SSDKResponseStateSuccess) {
                
            }
        }];

    }
    if (btn.tag == 2) {   //QQ
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:@"欢迎进入融邦金服" images:@[self.image] url:nil title:@"融邦金服" type:SSDKContentTypeAuto];
        
            [ShareSDK share:SSDKPlatformSubTypeQQFriend parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                // 成功
                if (state == SSDKResponseStateSuccess) {
                    
                }
            }];
    }
    if (btn.tag == 3) {   //空间
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"欢迎进入融邦金服" images:@[self.image] url:nil title:@"融邦金服" type:SSDKContentTypeAuto];
        
        [ShareSDK share:SSDKPlatformTypeQQ parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            // 成功
            if (state == SSDKResponseStateSuccess) {
                
            }
        }];
    }
}

@end
