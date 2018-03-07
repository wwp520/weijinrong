//
//  AddCardController.m
//  weijinrong
//
//  Created by ouda on 17/6/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "AddCardController.h"
#import "AttestationView.h"
#import "TSLocateView.h"
#import "BankListViewController.h"

@interface AddCardController ()<UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *cardnoTF;
@property (weak, nonatomic) IBOutlet UITextField *cityTF;
@property (weak, nonatomic) IBOutlet UITextField *bankTF;

@property (nonatomic, strong) UITextField *first;//第一响应者
@property (nonatomic, strong) AttestationView *attestation;
@property(nonatomic,strong)UIScrollView * scroll;
@property (nonatomic, strong) UIButton *shadow;//阴影
@property (nonatomic, strong) TSLocateView *locate;//选择城市
// 地图
@property (nonatomic, strong) BMKReverseGeoCodeOption *searchGeo;//百度搜索
@property (nonatomic, strong) BMKLocationService *locServer;//百度定位
@property (nonatomic, strong) BMKGeoCodeSearch *search;//百度检索
@property (nonatomic, copy  ) NSString *province_id;//省份ID
@property (nonatomic, copy  ) NSString *city_id;//城市ID

// 信息
@property (nonatomic, strong) NSString *address;//地址
@property (nonatomic, strong) NSString *bankCode;
@end

@implementation AddCardController

//保存
- (IBAction)saveBtn:(id)sender {
    
    [self addBank];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"新增银行卡";
    [self createUI];
}


// 添加银行卡
- (void)addBank {
    [self showHudLoadingView:@"正在获取"];
    
//    bankCardNumber; //银行卡号
//    headquartersName; //总行名称
//    provinceId; //省id
//    cityId; //市id
//    bankCode; //银行id
//    mercId;//商户编号
    
    
    NSString *cardNoTf = ({ //银行卡号
        NSString *str = @"";
        NSArray *array = [_cardnoTF.text componentsSeparatedByString:@" "];
        if (array.count > 0) {
            str = [array componentsJoinedByString:@""];
        }
        str;
    });
    
    
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          cardNoTf,@"bankCardNumber",
                          _bankTF.text,@"headquartersName",
                          _province_id,@"provinceId",
                          _city_id,@"cityId",
                          _bankCode,@"bankCode",
                          _nameTF.text,@"name",
                          [SaveManager getStringForKey:@"mercId"],@"mercId", nil];
    [DongManager rewardBankAdd:dict success:^(id requestData) {
        [self hiddenHudLoadingView];
        BaseModel *model = [BaseModel decryptBecomeModel:requestData];
//        [self showTitle:model.retMessage delay:1.5f];
        if (model.retCode == 0) {
            [self popDelay];
        }else {
        [self showTitle:model.retMessage delay:1.5f];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}


- (void)createUI{
//    [self scroll];
//    [self attestation];
    
    [_nameTF setImage:@"资源 7@0.5x(1)" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    [_cardnoTF  setImage:@"资源 8@0.5x(1)" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    [_cityTF setImage:@"dd@0.5x" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    [_bankTF setImage:@"dd@0.5x" width:50 radius:8 color:RGB(200, 200, 200, 1)];
    
    _saveBtn.layer.borderColor = [UIColor redColor].CGColor;
    _saveBtn.layer.borderWidth = 1;
    _saveBtn.layer.masksToBounds = YES;
    _saveBtn.layer.cornerRadius = 5;
    _nameTF.layer.masksToBounds = YES;
    _nameTF.layer.cornerRadius = 5;
    _cardnoTF.layer.masksToBounds = YES;
    _cardnoTF.layer.cornerRadius = 5;
    _cityTF.layer.masksToBounds = YES;
    _cityTF.layer.cornerRadius = 5;
    _bankTF.layer.masksToBounds = YES;
    _bankTF.layer.cornerRadius = 5;
}

- (UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
        _scroll.delegate = self;
        _scroll.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scroll];
    }
    return _scroll;
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
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
//    _longitude = userLocation.location.coordinate.longitude;
//    _latitude = userLocation.location.coordinate.latitude;
//    
//    //发起反向地理编码检索
//    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){_latitude, _longitude};
//    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
//                                                            BMKReverseGeoCodeOption alloc]init];
//    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
//    BOOL flag = [_search reverseGeoCode:reverseGeoCodeSearchOption];
//    if(!flag){
//        NSLog(@"反geo检索发送失败");
//    }
//    //    停止定位
//    [_locServer stopUserLocationService];
//}
//// 接收反向地理编码结果
//- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
//    if (error == BMK_SEARCH_NO_ERROR) {
//        _address = result.address;
//    }
//    else {
//        NSLog(@"反检索失败");
//    }
//}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _first = textField;
    if ([textField isEqual:_cityTF]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_nameTF resignFirstResponder];
            [_bankTF resignFirstResponder];
            [_cardnoTF resignFirstResponder];
            [_cityTF resignFirstResponder];
        });
        [self shadow];
        _locate = [[TSLocateView alloc] initWithTitle:@"选择省市" delegate:self];
        [_locate showInView:self.view];
    }else if ([textField isEqual:_bankTF]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_nameTF resignFirstResponder];
            [_bankTF resignFirstResponder];
            [_cardnoTF resignFirstResponder];
            [_cityTF resignFirstResponder];
        });
        [_nameTF becomeFirstResponder];
        [self bankChoose];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// 返回第一响应者
- (UITextField *)getFirst {
    return _first;
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
        _cityTF.text = [NSString stringWithFormat:@"%@%@",location.state,location.city];
        self.province_id = location.province_id;
        self.city_id = location.city_id;
    }
    [_cityTF endEditing:YES];
}
// 选择银行
- (void)bankChoose {
    BankListViewController *bvc  = [[BankListViewController alloc] init];
    __weak AddCardController *weak = self;
    bvc.changeBlock = ^(NSString *bankNames, NSString *bankid){
        weak.bankTF.text = bankNames;
        weak.bankCode = bankid;
    };
    [self.navigationController pushViewController:bvc animated:YES];
}


#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _cardnoTF) {
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
