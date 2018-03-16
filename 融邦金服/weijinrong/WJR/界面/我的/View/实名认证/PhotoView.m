//
//  PhotoView.m
//  chengzizhifu
//
//  Created by RY on 16/12/28.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "PhotoView.h"
#import "ZYHImageCompression.h"
#import "UIImage+ExitUIImage.h"
#import "PhotoModel.h"
#import "ResultsViewController.h"
#import "Unity.h"


// 10000-10005  默认图片
// 10006-10011  拍照图片
// 5000 - 5005 : 6个按钮
#define img_normal 10000
#define img_select 10006

#pragma mark 声明
@interface PhotoView()<UIImagePickerControllerDelegate,UIScrollViewDelegate,UINavigationControllerDelegate>{
    NSInteger index;
    UIButton *_selectBtn;
}
//等待框
@property (nonatomic,retain) UIProgressView * prog;
@property (nonatomic,retain) UILabel * progLab;


@property (strong, nonatomic) IBOutlet UIButton *person;
@property (strong, nonatomic) IBOutlet UIButton *cardA;
@property (strong, nonatomic) IBOutlet UIButton *cardB;
@property (strong, nonatomic) IBOutlet UIButton *bank;
@property (strong, nonatomic) IBOutlet UIButton *trust;
@property (strong, nonatomic) IBOutlet UIButton *shop;

@property (strong, nonatomic) IBOutlet UIImageView *person_img;
@property (strong, nonatomic) IBOutlet UIImageView *cardA_img;
@property (strong, nonatomic) IBOutlet UIImageView *cardB_img;
@property (strong, nonatomic) IBOutlet UIImageView *bank_img;
@property (strong, nonatomic) IBOutlet UIImageView *trust_img;
@property (strong, nonatomic) IBOutlet UIImageView *shop_img;

@property (nonatomic, strong) NSMutableArray *select_img;//选择后图片
@property (nonatomic, strong) NSMutableArray *normal_img;//选择后图片
@property (nonatomic, strong) NSMutableDictionary *upDict;//上传的图片
@end

#pragma mark 实现
@implementation PhotoView

#pragma mark 初始化
- (void)createProgressView {
    self.grayBView = [Unity backviewAddview_subViewFrame:self.viewController.view.bounds _viewColor:[UIColor grayColor]];
    self.grayBView.alpha=0.4;
    [self addSubview:self.grayBView];
    self.pView = [Unity backviewAddview_subViewFrame:CGRectMake(ScreenWidth/2-240/2, ScreenHeight/2-140/2-64, 240, 100) _viewColor:[UIColor whiteColor]];
    [self addSubview:self.pView];
    [self.pView.layer setMasksToBounds:YES];
    [self.pView.layer setCornerRadius:6.0];
    [Unity lableViewAddsuperview_superView:self.pView _subViewFrame:CGRectMake(10, 5, self.pView.width-10, 30) _string:@"正在上传" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
    self.prog=[[UIProgressView alloc]initWithFrame:CGRectMake(10, 50, 220, 100)];
    self.prog.progressViewStyle=UIProgressViewStyleDefault;
    self.progLab=[Unity lableViewAddsuperview_superView:self.pView _subViewFrame:CGRectMake(20, 55, 200, 40) _string:@"0%" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentCenter];
    [self.pView addSubview:self.prog];
}

#pragma mark 网络请求
- (IBAction)chooseClick:(UIButton *)sender {
    _selectBtn = sender;
    [self takePhoto];
}

#pragma mark 按钮点击
- (IBAction)finishClick:(UIButton *)sender {
    BaseViewController *base = (BaseViewController *)self.viewController;
    for (int i=0; i<6; i++) {
        if ([(UIImageView *)[self viewWithTag:10006 + i] image] == nil) {
            [(BaseViewController *)self.viewController showTitle:@"图片不完整" delay:1];
            return;
        }
    }
    [self changeImage];
}

#pragma mark 网络请求
//上传图片
- (void)changeImage {
    // 上传百分比
    [self createProgressView];
    // weak
    __weak BaseViewController *weakVc = (BaseViewController *)self.viewController;
    __weak PhotoView *weak = self;
    // 信息
    NSDictionary *params = @{@"mobilePhone":_mobilephone};
    // 图片
    NSMutableArray *arrayM = ({
        NSArray *name = @[@"hand",@"positive",@"reverse",@"cardpositive",
                          @"cardreverse",@"BusinessLicense"];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i = 0; i < name.count; i++) {
            AFNFileModel *model = ({
                AFNFileModel *model = [[AFNFileModel alloc]init];
                model.fileName = [NSString stringWithFormat:@"%@.jpg",name[i]];
                model.name = @"file";
                model.mimeType = @"multipart/form-data";
                UIImage *image = [(UIImageView *)[self viewWithTag:10006 + i] image];
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
            [weak getInfo];
        }else {
            [weakVc showTitle:model.retMessage delay:1];
        }
        // 界面
        [weak.pView setAlpha:0];
        [weak.grayBView setAlpha:0];
    } fail:^(NSError *error) {
        [weakVc showNetFail];
        [weak.pView setAlpha:0];
        [weak.grayBView setAlpha:0];
    } progess:^(double progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (ScreenHeight <= 480) {
                [weak.progLab setText:@"80%"];
            }else {
                float p = progress;
                [self.prog setProgress:p];
                [self.progLab setText:[NSString stringWithFormat:@"%0.1f%%",progress * 100]];
            }
        });
    }];
}
- (void)getInfo {    //添加店铺名称
    __weak BaseViewController *weakVc = (BaseViewController *)self.viewController;
    [weakVc showHudLoadingView:@"正在上传"];
    
    NSString *mercid = [SaveManager getStringForKey:@"mercId"];
 //   NSString *phone = [NSString stringWithFormat:@"%@mercid",GetAccount];      //商户编号
    NSString *pass = _password == nil ? GetPassword : _password;
    
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       self.nameStr,@"shortName",
                                       self.shopStr,@"merc_name",
                                       self.IDStr,@"crpIdNo",
                                       @"身份证",@"crpIdTyp",
                                       self.emailStr,@"email",
                                       self.cardStr,@"bankCardNumber",
                                       self.bankName,@"headquartersName",
                                       self.province_id,@"provinceId",
                                       self.city_id,@"cityId",
                                       self.address,@"address",
                                       self.bankCode,@"bankCode",
                                       self.creditCard,@"creditCard",
                                      self.mobilephone,@"mobilephone",
                                       ChannelNumber,@"agentNumber",
                                       mercid,@"mercid",
                                       [NSString stringWithFormat:@"%f",self.longitude],@"bdlng",
                                       [NSString stringWithFormat:@"%f",self.latitude],@"bdlat", nil];
        [params setObject:ChannelNumber forKey:@"agentNumber"];
        [params setObject:self.mobilephone forKey:@"mobilephone"];
        [params setObject:mercid forKey:@"mercid"];
        [params setObject:[pass md5] forKey:@"password"];
        
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
            rvc.nameStr=self.nameStr;
            rvc.IDStr=self.IDStr;
            rvc.cardStr=self.cardStr; 
            [weakVc.navigationController pushViewController:rvc animated:YES];
        }else {
            [weakVc showTitle:model.retMessage delay:1.5f];
        }
        
    } fail:^(NSError *error) {
        [(BaseViewController *)self.viewController showNetFail];
    }];
    
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
    UIImagePickerController* picker=	[[UIImagePickerController alloc] init];
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
        
        
        if (_selectBtn.tag == 5000) {
            [self.upDict setObject:image forKey:@"hand"];
        }else if (_selectBtn.tag == 5001){
            [self.upDict setObject:image forKey:@"positive"];
        }else if(_selectBtn.tag == 5002){
            [self.upDict setObject:image forKey:@"reverse"];
        }else if(_selectBtn.tag == 5003){
            [self.upDict setObject:image forKey:@"cardpositive"];
        }else if(_selectBtn.tag == 5004){
            [self.upDict setObject:image forKey:@"cardreverse"];
        }else if(_selectBtn.tag == 5005){
            [self.upDict setObject:image forKey:@"BusinessLicense"];
        }
        //显示和隐藏
        UIImageView *selectView = (UIImageView *)[self viewWithTag:10006 + _selectBtn.tag - 5000];
        selectView.image = [UIImage imageWithData:data];
        UIImageView *normalView = (UIImageView *)[self viewWithTag:10000 + _selectBtn.tag - 5000];
        normalView.alpha = 0;
        
    }
    
}

#pragma mark 不用看的
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
- (void)setSelectImg:(UIImageView *)image {
    image.layer.cornerRadius = 8;
    image.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    image.layer.borderColor = [UIColor grayColor].CGColor;
    image.layer.masksToBounds = YES;
}
- (NSMutableArray *)select_img {
    if (!_select_img) {
        _select_img = [[NSMutableArray alloc] init];
        for (int i=0; i<=5; i++) {
            [_select_img addObject:[self viewWithTag:img_normal + i]];
        }
    }
    return _select_img;
}
- (NSMutableArray *)normal_img {
    if (!_normal_img) {
        _normal_img = [[NSMutableArray alloc] init];
        for (int i=0; i<=5; i++) {
            [_normal_img addObject:[self viewWithTag:img_select + i]];
        }
    }
    return _normal_img;
}
- (NSDictionary *)getRequestparamWithDict:(NSDictionary *)dict {
    NSString *str1 = [KKTools dictionaryToJson:dict];
    return @{@"requestData":[Unity encryptionJsonString:str1]};
}



@end
