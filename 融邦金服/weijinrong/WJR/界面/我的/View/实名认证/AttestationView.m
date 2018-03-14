//
//  AttestationView.m
//  chengzizhifu
//
//  Created by RY on 16/12/28.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "AttestationView.h"
#import "TSLocateView.h"
#import "Unity.h"
#import "NewPhotoController.h"
#import "BankListViewController.h"
#import "ResultsViewController.h"

#pragma mark 声明
@interface AttestationView ()<UITextFieldDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UIActionSheetDelegate>

// 输入框
@property (strong, nonatomic) IBOutlet UIButton *next;
@property (nonatomic, strong) UITextField *first;//第一响应者
@property (nonatomic, strong) TSLocateView *locate;//选择城市
@property (nonatomic, strong) NSString *cardString;//银行卡号(没有空格)
@property (nonatomic, strong) UIButton *shadow;//阴影

// 地图
@property (nonatomic, strong) BMKReverseGeoCodeOption *searchGeo;//百度搜索
@property (nonatomic, strong) BMKLocationService *locServer;//百度定位
@property (nonatomic, strong) BMKGeoCodeSearch *search;//百度检索
@property (nonatomic, copy  ) NSString *province_id;//省份ID
@property (nonatomic, copy  ) NSString *city_id;//城市ID
@property (nonatomic, assign) float latitude;//经度
@property (nonatomic, assign) float longitude;//纬度

// 信息
@property (nonatomic, strong) NSString *address;//地址
@end

#pragma mark 实现
@implementation AttestationView

#pragma mark 初始化
+ (instancetype)initWithFrame:(CGRect)frame {
    AttestationView *view = [[NSBundle mainBundle] loadNibNamed:@"AttestationView" owner:nil options:nil].firstObject;
    view.frame = frame;
    view.next.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view startLocation];
    [view text_left_icon:@"newAtt_shop" text:view.business];
    [view text_left_icon:@"newAtt_user" text:view.name];
    [view text_left_icon:@"newAtt_card" text:view.idCard];
    [view text_left_icon:@"" text:view.bank];
    [view text_left_icon:@"" text:view.city];
    [view text_left_icon:@"newAtt_bank" text:view.bankCard];
    view.city.inputView = [UIView new];
    return view;
}

// 返回第一响应者
- (UITextField *)getFirst {
    return _first;
}

// 开始定位
- (void)startLocation {
    _search = [[BMKGeoCodeSearch alloc]init];
    _search.delegate = self;
    
    _locServer = [[BMKLocationService alloc]init];
    _locServer.delegate = self;
    [_locServer startUserLocationService];
}

// 左边的图标
- (void)text_left_icon:(NSString *)icon text:(UITextField *)text {
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 20)];
    image.image = [UIImage imageNamed:icon];
    image.contentMode = UIViewContentModeScaleAspectFit;
    text.leftView = image;
    text.leftViewMode = UITextFieldViewModeAlways;
}

- (UIButton *)shadow {
    if (!_shadow) {
        _shadow = [UIButton buttonWithType:UIButtonTypeCustom];
        _shadow.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 255);
        _shadow.alpha = 0;
        _shadow.backgroundColor = [RGB(50, 50, 50, 1) colorWithAlphaComponent:0.1];
        [_shadow addTarget:self action:@selector(shadowClick) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:_shadow];
        [UIView animateWithDuration:.2f animations:^{
            _shadow.alpha = 1;
        }];
    }
    return _shadow;
}


- (void)getInfo {    //添加店铺名称
    
     //银行卡号去掉中间空格
     //self.bankCard.text (6236 6823 4000 7683 666) -->self.cardString(6236682340007683666)

     self.cardString = ({
     NSString *str = @"";
     NSArray *array = [self.bankCard.text componentsSeparatedByString:@" "];
     if (array.count > 0) {
     str = [array componentsJoinedByString:@""];
     }
     str;
     });
     
     //弹窗框
     BaseViewController *vc = (BaseViewController *)self.viewController;
     if (_name.text == nil || _name.text.length == 0) {
     [vc showTitle:@"请输入姓名" delay:1.5];
     }else if (_latitude == 0 || _longitude == 0) {//经纬度为空
     [vc showTitle:@"获取经纬度失败" delay:1.5];
     }else if (_address == nil) {
     [vc showTitle:@"获取城市信息失败" delay:1.5];
     }else if (_idCard.text == nil || _idCard.text.length == 0) {
     [vc showTitle:@"请输入身份证号" delay:1.5];
     }else if (![Unity validateIdentityCard:[self.idCard.text uppercaseString]]) {
     [vc showTitle:@"身份证号码格式不正确" delay:1.5];
     }else if (_bank.text == nil || _bank.text.length == 0) {
     [vc showTitle:@"请选择银行" delay:1.5];
     }else if (_city.text == nil || _city.text.length == 0) {
     [vc showTitle:@"请选择省份城市" delay:1.5];
     }else if (![Unity isValidCreditNumber:self.cardString]){
     [vc showTitle:@"银行卡号格式不正确" delay:1.5];
     }else if (_bankCard.text == nil || _bankCard.text.length == 0) {
     [vc showTitle:@"请输入银行卡号" delay:1.5];
     }else {

    
    __weak BaseViewController *weakVc = (BaseViewController *)self.viewController;
    [weakVc showHudLoadingView:@"正在上传"];
    
    NSString *mercid = [SaveManager getStringForKey:@"mercId"];
    //   NSString *phone = [NSString stringWithFormat:@"%@mercid",GetAccount];      //商户编号
   // NSString *pass = _password == nil ? GetPassword : _password;
    
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       self.name.text,@"shortName",
                                       self.business.text,@"merc_name",
                                       self.idCard.text,@"crpIdNo",
                                      // @"身份证",@"crpIdTyp",
                                      // self.emailStr,@"email",
                                     //  @"",@"email",
                                       self.cardString,@"bankCardNumber",
                                       self.bank.text,@"headquartersName",
                                       self.province_id,@"provinceId",
                                       self.city_id,@"cityId",
                                       _address,@"address",
                                       self.bankCode,@"bankCode",
                                       @"",@"creditCard",
                                       self.mobilephone,@"mobilephone",
                                       ChannelNumber,@"agentNumber",
                                       mercid,@"mercid",
                                       [NSString stringWithFormat:@"%f",self.longitude],@"bdlng",
                                       [NSString stringWithFormat:@"%f",self.latitude],@"bdlat", nil];
      //  [params setObject:ChannelNumber forKey:@"agentNumber"];
        [params setObject:self.mobilephone forKey:@"mobilephone"];
        [params setObject:mercid forKey:@"mercid"];
      //  [params setObject:[pass md5] forKey:@"password"];
        
        NSString *str = [KKTools dictionaryToJson:params];
        [KKTools encryptionJsonString:str];
    })];
    NSDictionary *params2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                             GetAccount, @"userName",
                             @"pmsMerchantInfoAction/saveRealNameAuthenticationInformation.action",@"url",
                             [SaveManager  getStringForKey:@"token"],@"token",
                             [SaveManager  getStringForKey:@"session"],@"session",
                             oldParam,@"inParam",nil];
    NSDictionary *newParam = @{@"param":params2};
    [DongManager certification:newParam success:^(id requestData) {
        [weakVc hiddenHudLoadingView];
        BaseModel *model = [BaseModel decryptBecomeModel:requestData];
        if (model.retCode == 0) {
            ResultsViewController * rvc=[[ResultsViewController alloc]init];
            rvc.nameStr = self.name.text;
            rvc.IDStr = self.idCard.text;
            rvc.cardStr = self.cardString;
            [weakVc.navigationController pushViewController:rvc animated:YES];
        }else {
            [weakVc showTitle:model.retMessage delay:1.5f];
        }
        
    } fail:^(NSError *error) {
        [(BaseViewController *)self.viewController showNetFail];
    }];
   }
}

#pragma mark 点击事件
- (IBAction)tapG:(UITapGestureRecognizer *)sender {
    [self endEditing:YES];
}

- (IBAction)nextClick:(UIButton *)sender {
    [self getInfo];
    
    /*
    //银行卡号
    self.cardString = ({
        NSString *str = @"";
        NSArray *array = [self.bankCard.text componentsSeparatedByString:@" "];
        if (array.count > 0) {
            str = [array componentsJoinedByString:@""];
        }
        str;
    });
    
    //弹窗框
    BaseViewController *vc = (BaseViewController *)self.viewController;
    if (_name.text == nil || _name.text.length == 0) {
        [vc showTitle:@"请输入姓名" delay:1.5];
    }else if (_latitude == 0 || _longitude == 0) {//经纬度为空
        [vc showTitle:@"获取经纬度失败" delay:1.5];
    }else if (_address == nil) {
        [vc showTitle:@"获取城市信息失败" delay:1.5];
    }else if (_idCard.text == nil || _idCard.text.length == 0) {
        [vc showTitle:@"请输入身份证号" delay:1.5];
    }else if (![Unity validateIdentityCard:[self.idCard.text uppercaseString]]) {
        [vc showTitle:@"身份证号码格式不正确" delay:1.5];
    }else if (_bank.text == nil || _bank.text.length == 0) {
        [vc showTitle:@"请选择银行" delay:1.5];
    }else if (_city.text == nil || _city.text.length == 0) {
        [vc showTitle:@"请选择省份城市" delay:1.5];
    }else if (![Unity isValidCreditNumber:self.cardString]){
        [vc showTitle:@"银行卡号格式不正确" delay:1.5];
    }else if (_bankCard.text == nil || _bankCard.text.length == 0) {
        [vc showTitle:@"请输入银行卡号" delay:1.5];
    }else {
        NewPhotoController *vc2 = [[NewPhotoController alloc] init];
        vc2.nameStr     = self.name.text;
        vc2.IDStr       = self.idCard.text;
        vc2.emailStr    = @"";
        vc2.cardStr     = self.cardString;
        vc2.bankCode    = self.bankCode;
        vc2.bankName    = self.bank.text;
        vc2.province_id = self.province_id;
        vc2.city_id     = self.city_id;
        vc2.longitude   = _longitude;
        vc2.latitude    = _latitude;
        vc2.address     = _address;
        vc2.shopStr     = self.business.text;
        vc2.mobilephone = self.mobilephone;
        vc2.password    = self.password;
        [self.viewController.navigationController pushViewController:vc2 animated:YES];
    }
     */
}
- (void)shadowClick {
    [_locate cancel:nil];
    [UIView animateWithDuration:.2f animations:^{
        _shadow.alpha = 0;
    }completion:^(BOOL finished) {
        [_shadow removeFromSuperview];
        _shadow = nil;
    }];
}

#pragma mark BaiduMapLocationDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    _longitude = userLocation.location.coordinate.longitude;
    _latitude = userLocation.location.coordinate.latitude;
    
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){_latitude, _longitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_search reverseGeoCode:reverseGeoCodeSearchOption];
    if(!flag){
        NSLog(@"反geo检索发送失败");
    }
    //    停止定位
    [_locServer stopUserLocationService];
}
// 接收反向地理编码结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
        _address = result.address;
    }
    else {
        NSLog(@"反检索失败");
    }
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _first = textField;
    if ([textField isEqual:_city]) {
        [_business resignFirstResponder];
        [_name     resignFirstResponder];
        [_idCard   resignFirstResponder];
        [_bank     resignFirstResponder];
        [_bankCard resignFirstResponder];
        [self shadow];
        _locate = [[TSLocateView alloc] initWithTitle:@"选择省市" delegate:self];
        [_locate showInView:self];
    }else if ([textField isEqual:_bank]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_business resignFirstResponder];
            [_name     resignFirstResponder];
            [_idCard   resignFirstResponder];
            [_bank     resignFirstResponder];
            [_bankCard resignFirstResponder];
        });
        [self bankChoose];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// 选择省市
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [UIView animateWithDuration:.2f animations:^{
        _shadow.alpha = 0;
    }completion:^(BOOL finished) {
        [_shadow removeFromSuperview];
        _shadow = nil;
        
    }];
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select");
        TSLocateView *locateView = (TSLocateView *)actionSheet;
        TSLocation *location = locateView.locate;
        self.city.text = [NSString stringWithFormat:@"%@%@",location.state,location.city];
        self.province_id = location.province_id;
        self.city_id = location.city_id;
    }
    [_city endEditing:YES];
}

// 选择银行
- (void)bankChoose {
    
    BankListViewController *bvc  = [[BankListViewController alloc]init];
    __weak AttestationView *weak = self;
    bvc.changeBlock = ^(NSString *bankNames, NSString *bankid){
        weak.bank.text = bankNames;
        weak.bankCode = bankid;
    };
    [self.viewController.navigationController pushViewController:bvc animated:YES];
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.bankCard) {
        // 四位加一个空格
        if ([string isEqualToString:@""]) { // 删除字符
            if (textField.text.length>0) {
                if ((textField.text.length - 1) % 5 == 0) {
                    textField.text = [textField.text substringToIndex:textField.text.length - 1];
                }
                return YES;
            }
        } else {
            if ((textField.text.length +1)% 5 == 0) {
                textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
            }
        }
        return YES;
    }
    return YES;
}


@end
