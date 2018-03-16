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
#import "PhotoModel.h"
#import "PhotoView.h"
#import "ZYHImageCompression.h"
#import "UIImage+ExitUIImage.h"


#pragma mark 声明
@interface AttestationView ()<UITextFieldDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UIActionSheetDelegate>
{
   UIButton *_selectBtn;
}

//等待框
@property (nonatomic,retain) UIProgressView * prog;
@property (nonatomic,retain) UILabel * progLab;

// 输入框
@property (strong, nonatomic) IBOutlet UIButton *next;
@property (nonatomic, strong) UITextField *first;//第一响应者
@property (nonatomic, strong) TSLocateView *locate;//选择城市
@property (nonatomic, strong) NSString *cardString;//银行卡号(没有空格)
@property (nonatomic, strong) UIButton *shadow;//阴影
@property (nonatomic,strong) PhotoView *photoView;

@property (nonatomic, strong) NSMutableArray *select_img;//选择后图片
@property (nonatomic, strong) NSMutableArray *normal_img;//选择后图片
@property (nonatomic, strong) NSMutableDictionary *upDict;//上传的图片


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

#pragma mark 初始化
- (void)createProgressView {
    _photoView.grayBView = [Unity backviewAddview_subViewFrame:self.viewController.view.bounds _viewColor:[UIColor grayColor]];
    _photoView.grayBView.alpha=0.4;
    [self addSubview:_photoView.grayBView];
    _photoView.pView = [Unity backviewAddview_subViewFrame:CGRectMake(ScreenWidth/2-240/2, ScreenHeight/2-140/2-64, 240, 100) _viewColor:[UIColor whiteColor]];
    [self addSubview:_photoView.pView];
    [_photoView.pView.layer setMasksToBounds:YES];
    [_photoView.pView.layer setCornerRadius:6.0];
    [Unity lableViewAddsuperview_superView:_photoView.pView _subViewFrame:CGRectMake(10, 5, _photoView.pView.width-10, 30) _string:@"正在上传" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
    self.prog=[[UIProgressView alloc]initWithFrame:CGRectMake(10, 50, 220, 100)];
    self.prog.progressViewStyle=UIProgressViewStyleDefault;
    self.progLab=[Unity lableViewAddsuperview_superView:_photoView.pView _subViewFrame:CGRectMake(20, 55, 200, 40) _string:@"0%" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentCenter];
    [_photoView.pView addSubview:self.prog];
}


//拍照上传
- (IBAction)uploadBtn:(id)sender {
    _selectBtn = sender;
    [self takePhoto];
}

#pragma mark 网络请求
//上传图片
- (void)changeImage {
    // 上传百分比
    [self createProgressView];
    // weak
    __weak BaseViewController *weakVc = (BaseViewController *)self.viewController;
   // __weak PhotoView *weak = self;
    // 信息
    NSDictionary *params = @{@"mobilePhone":_mobilephone};
    // 图片
    NSMutableArray *arrayM = ({
        NSArray *name = @[@"hand"];
       // NSArray *name = @[@"hand",@"positive",@"reverse",@"cardpositive",
 //                         @"cardreverse",@"BusinessLicense"];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i = 0; i < name.count; i++) {
            AFNFileModel *model = ({
                AFNFileModel *model = [[AFNFileModel alloc]init];
                model.fileName = [NSString stringWithFormat:@"%@.jpg",name[i]];
                model.name = @"file";
                model.mimeType = @"multipart/form-data";
                UIImage *image = [(UIImageView *)[self viewWithTag:10000 + i] image];
                model.fileData = UIImagePNGRepresentation(image);
                model;
            });
            [arrayM addObject:model];
        }
        arrayM;
    });
    
    //图片上传
    //    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
    //        NSString *str = [KKTools dictionaryToJson:params];
    //        [KKTools encryptionJsonString:str];
    //    })];
    //    NSDictionary *params2 = [[NSDictionary alloc] initWithObjectsAndKeys:
    //                            GetAccount, @"userName",
    //                             @"upload1",@"url",
    //                             [SaveManager getStringForKey:@"token"],@"token",
    //                             [SaveManager getStringForKey:@"session"],@"session",
    //                             oldParam,@"inParam",nil];
    //    NSDictionary *newParam = @{@"param":params2};
    
    
    [KKManager upload:params images:arrayM success:^(id requestData) {
        // 隐藏
        [weakVc hiddenHudLoadingView];
        // 解析
        
        NSString *resStr   = [KKTools decryptJsonString:requestData];
        NSDictionary *dict = [KKTools dictionaryWithJsonString:resStr];
        PhotoModel *model  = [PhotoModel mj_objectWithKeyValues:dict];
        if (model.retCode == 0) {
            [self getInfo];
        }else {
            [weakVc showTitle:model.retMessage delay:1];
        }
        // 界面
        [_photoView.pView setAlpha:0];
        [_photoView.grayBView setAlpha:0];
    } fail:^(NSError *error) {
        [weakVc showNetFail];
        [_photoView.pView setAlpha:0];
        [_photoView.grayBView setAlpha:0];
    } progess:^(double progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (ScreenHeight <= 480) {
                [self.progLab setText:@"80%"];
            }else {
                float p = progress;
                [self.prog setProgress:p];
                [self.progLab setText:[NSString stringWithFormat:@"%0.1f%%",progress * 100]];
            }
        });
    }];
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
                                    //   self.name.text,@"shortName",
                                       @"见习经理",@"shortName",
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
            [self.viewController.navigationController popToRootViewControllerAnimated:YES];
            /*
            ResultsViewController * rvc=[[ResultsViewController alloc]init];
            rvc.nameStr = self.name.text;
            rvc.IDStr = self.idCard.text;
            rvc.cardStr = self.cardString;
            [weakVc.navigationController pushViewController:rvc animated:YES];
             */
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
    [self changeImage];
  //  [self getInfo];
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


#pragma mark UIImagePickerControllerDelegate
// 打开照相机
- (void)takePhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    if (self.viewController.presentedViewController) {
        return;
    }
    //    [[[UIApplication sharedApplication].windows objectAtIndex:1] makeKeyAndVisible];
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing= NO;
    picker.view.backgroundColor = [UIColor blackColor];
    picker.sourceType =	sourceType;//		UIImagePickerControllerSourceTypePhotoLibrary;
    [self.viewController presentViewController:picker animated:YES completion:nil];
    
}
// 打开本地相册
- (void)localPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self.viewController presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]){
        //先把图片转成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        CGSize size = [ZYHImageCompression get_ImageCompressionProportion:image];
        image = [image imageByScalingAndCroppingForSize:size];
        
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 0.25);
        }
        else {
            data = UIImagePNGRepresentation(image);
        }
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        image = [Unity imageWithImageSimple:image scaledToSize:CGSizeMake(size.width, size.height)];
        
        
        if (_photoBtn.tag == 5000) {
            [self.upDict setObject:image forKey:@"hand"];
        }
        
        _photoImage.image = [UIImage imageWithData:data];
         _photo2Image.alpha = 0;
        /*
        //显示和隐藏
        UIImageView *selectView = (UIImageView *)[self viewWithTag:10000 + _selectBtn.tag - 5000];
        selectView.image = [UIImage imageWithData:data];
        UIImageView *normalView = (UIImageView *)[self viewWithTag:10000 + _selectBtn.tag - 5000];
        normalView.alpha = 0;
         */
    }
}

#pragma mark 不用看的
- (PhotoView *)photoView{
    if (!_photoView) {
        _photoView = [PhotoView initWithFrame:CGRectMake(0, 0, 200, 200)];
     //   _photoView = [[NSBundle mainBundle] loadNibNamed:@"PhotoView" owner:nil options:nil].firstObject;
        _photoView.height = 530;
    }
    return _photoView;
}

/*
+ (instancetype)initWithFrame:(CGRect)frame {
    PhotoView *view = [[NSBundle mainBundle] loadNibNamed:@"PhotoView" owner:nil options:nil].firstObject;
    view.frame = frame;
    view.height = 530;
    [view setUI];
    return view;
}
- (void)setUI {
    [self setBtn:_person];
    [self setBtn:_cardA];
    [self setBtn:_cardB];
    [self setBtn:_bank];
    [self setBtn:_trust];
    [self setBtn:_shop];
    
    [self setSelectImg:_person_img];
    [self setSelectImg:_cardA_img];
    [self setSelectImg:_cardB_img];
    [self setSelectImg:_bank_img];
    [self setSelectImg:_trust_img];
    [self setSelectImg:_shop_img];
}
- (void)setBtn:(UIButton *)btn {
    btn.layer.cornerRadius = 8;
    btn.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    btn.layer.masksToBounds = YES;
}
*/

@end
