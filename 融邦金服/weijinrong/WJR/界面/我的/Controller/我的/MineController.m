//
//  MineController.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "MineController.h"
#import "MineTable.h"
#import "MineHeader.h"
#import "MineFooter.h"
#import "NewSetModel.h"
#import "DongManager.h"
#import "MineHeader.h"
#import "BaseModel.h"
#import "UserModel.h"
#import "ShenHe.h"
#import "HomeController.h"
#import <LinkPayLoanSDK/LinkPayLoanSDK.h>
#import "NewAttestationController.h"
#import "ZYHImageCompression.h"
#import "UIImage+ExitUIImage.h"
#import "Unity.h"
#import "PhotoView.h"
#import "PhotoModel.h"

#pragma mark 声明
@interface MineController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIActionSheetDelegate>
{
    UIButton * _selectBtn;
}
@property (nonatomic, strong) MineTable *table;
@property (nonatomic, strong) MineHeader *header;
@property (nonatomic, strong) MineFooter *footer;
@property (nonatomic, strong) NewSetModel *model;
@property (nonatomic,strong) PhotoView *photoView;
@property (nonatomic, strong) NSMutableDictionary *upDict;//上传的图片

//等待框
@property (nonatomic,retain) UIProgressView * prog;
@property (nonatomic,retain) UILabel * progLab;
@end

#pragma mark 实现
@implementation MineController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _header.iconBtn.layer.masksToBounds = YES;
    _header.iconBtn.layer.cornerRadius = 55;
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _header.iconBtn.layer.masksToBounds = YES;
    _header.iconBtn.layer.cornerRadius = 55;
    [self table];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _header.iconBtn.layer.masksToBounds = YES;
    _header.iconBtn.layer.cornerRadius = 55;
    [self changeLoginStatus];
    if ([KKStaticParams sharedKKStaticParams].currentLogin == YES) {
        [self getUserStatus];
    }else {
        //登录
        [self pushLoginVc:^{
            // 登陆成功
            [self getUserStatus];
        }close:^{
            //首页
            [self.navigationController.tabBarController setSelectedIndex:0];
        }];
    }
}

//拍照上传头像
- (void)iconBtnClick:(UIButton *)btn{
    _selectBtn = btn;

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开相机",@"打开相册",nil];
    [sheet showInView:self.view];

    
   // [self takePhoto];
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


#pragma mark 初始化
- (void)createProgressView {
    _photoView.grayBView = [Unity backviewAddview_subViewFrame:self.view.bounds _viewColor:[UIColor grayColor]];
    _photoView.grayBView.alpha=0.4;
    [self.view addSubview:_photoView.grayBView];
    _photoView.pView = [Unity backviewAddview_subViewFrame:CGRectMake(ScreenWidth/2-240/2, ScreenHeight/2-140/2-64, 240, 100) _viewColor:[UIColor whiteColor]];
    [self.view addSubview:_photoView.pView];
    [_photoView.pView.layer setMasksToBounds:YES];
    [_photoView.pView.layer setCornerRadius:6.0];
    [Unity lableViewAddsuperview_superView:_photoView.pView _subViewFrame:CGRectMake(10, 5, _photoView.pView.width-10, 30) _string:@"正在上传" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentLeft];
    self.prog=[[UIProgressView alloc]initWithFrame:CGRectMake(10, 50, 220, 100)];
    self.prog.progressViewStyle=UIProgressViewStyleDefault;
    self.progLab=[Unity lableViewAddsuperview_superView:_photoView.pView _subViewFrame:CGRectMake(20, 55, 200, 40) _string:@"0%" _lableFont:TitleSize _lableTxtColor:TitleColor _textAlignment:NSTextAlignmentCenter];
    [_photoView.pView addSubview:self.prog];
}


#pragma mark 网络请求
//上传图片
- (void)changeImage {
    // 上传百分比
    [self createProgressView];
    // weak
    __weak BaseViewController *weakVc = (BaseViewController *)self;
    // __weak PhotoView *weak = self;
    // 信息 _mobilephone
    NSDictionary *params = @{@"mobilePhone":GetAccount};
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
                UIImage *image = _header.iconBtn.imageView.image;
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
            [self getUserStatus];
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



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {//打开相机
        [self openCamera];
    }else if (buttonIndex == 1){//系统相册
        [self openPhotoLibrary];
    }
}

/**
 *  调用照相机
 */

- (void)openCamera{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:NO completion:^{
            // 改变状态栏的颜色  为正常  这是这个独有的地方需要处理的
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
        }];
    }
    else{
        NSLog(@"没有摄像头");
    }
}

/**
 *  打开相册
 */

-(void)openPhotoLibrary{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.navigationBar.translucent = NO;　　//这句话设置导航栏不透明(!!!!!!!!!!!  解决问题)
        [imagePicker.navigationBar setBarTintColor:[UIColor colorWithRed:25/255.0 green:109/255.0 blue:242/255.0 alpha:1]];
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:^{
            // 改变状态栏的颜色  为正常  这是这个独有的地方需要处理的
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
            NSLog(@"打开相册");
        }];
    }else{
        NSLog(@"不能打开相册");
    }
    
}

#pragma mark - UIImagePickerControllerDelegate
// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0){
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
       
        if(!image){
            [_header.iconBtn setBackgroundImage:[UIImage imageNamed:@"个人头像.png"] forState:UIControlStateNormal];
        }else{
            [_header.iconBtn setBackgroundImage:image forState:UIControlStateNormal];
        }
        
        
        [self changeImage];
    
        [picker dismissViewControllerAnimated:NO completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }];
    });
}


//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)changeLoginStatus {
    if ([KKStaticParams sharedKKStaticParams].currentLogin == NO) {
        _header.logined.alpha = 0;
        _header.loginBtn.alpha = 1;
        _table.table.tableFooterView = [UIView new];
    }else {
        _header.logined.alpha = 1;
        _header.loginBtn.alpha = 0;
        _header.name.text = GetAccount;
        _table.table.tableFooterView = [self footer];
    }
}

- (MineTable *)table {
    if (!_table) {
        _table = [MineTable initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49)];
        _table.table.tableHeaderView = [self header];
        _footer.backgroundColor = [UIColor whiteColor];
        _table.table.tableFooterView = [self footer];
        _table.table.bounces = NO;
        [self.view addSubview:_table];
    }
    return _table;
}

- (MineHeader *)header {
    if (!_header) {
        _header = [MineHeader loadFromFrame:CGRectMake(0, 0, ScreenWidth, 0) icon:^{
            
        } login:^{
            LoginController *login = [[LoginController alloc] init];
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:login];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }];
    }
    if ([ShenHe sharedShenHe].isSh == YES) {
        _header.statusW.constant = 0;
    }
    return _header;
}

// 获取用户状态
- (void)getUserStatus {
    
    [DongManager getUserStatus:^(id requestData) {
        UserModel *model = [UserModel decryptBecomeModel:requestData];
        if (model.retCode == 0) {
            //认证过
          //  model.mercSts = @"10";
            if([model.mercSts isEqualToString:@"10"]){ //未认证
                [_header.statusBtn setImage:[UIImage imageNamed:@"未认证.png"] forState:UIControlStateNormal];
                [_header.statusBtn addTarget:self action:@selector(StatusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
            }else {//认证
                    [_header.statusBtn setImage:[UIImage imageNamed:@"已认证"] forState:UIControlStateNormal];
                
                [_header.iconBtn sd_setImageWithURL:[NSURL URLWithString:model.url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"个人头像.png"]];
                 [_header.iconBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else {
            [self showNetFail];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}

//如果是未认证,跳转至实名认证
- (void)StatusBtnClick:(UIButton *)btn{
    NewAttestationController * newVC = [[NewAttestationController alloc]init];
    [self.navigationController pushViewController:newVC animated:YES];
}

// 退出登录
- (MineFooter *)footer {
    if (!_footer) {
        _footer = [MineFooter loadFromFrame:CGRectMake(0, 0, ScreenWidth, 150) click:^{
            [CKAlertManager clickShowAlert:@"是否退出" message:@"是否退出当前账号" actions:@[@"取消",@"确认"] click:^(NSString *str) {
                if ([str isEqualToString:@"确认"]) {
                    
                    [self showHudLoadingView:@"等待中"];
                    DeviceModel *model = [NSString getPhoneInfo];
                    
                    // 退出登录请求接口（session可不传，无返回数据）
                    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                            GetAccount ,@"creationName",
                                            [GetPassword md5],@"password",
                                            model.phoneModel,@"phoneModel",
                                            model.sysVersionNumber,@"sysVersionNumber",
                                            model.appName,@"appName",
                                            model.appVersion,@"appVersion",
                                            model.appBuild,@"appBuild",
                                            ChannelNumber,@"agentNumber",
                                            @"",@"province",
                                            @"",@"cityCode",nil];
                    [DongManager logout:params success:^(id requestData) {
                        [self hiddenHudLoadingView];
                        _model = [LoginModel decryptBecomeModel:requestData];
                        AutoLogin(@"0");
                        [LinkPaySDK linkPaySdkLogOut];
                        [KKStaticParams sharedKKStaticParams].currentLogin = NO;
                        [self changeLoginStatus];
                    } fail:^(NSError *error) {
                        NSLog(@"失败");
                    }];
                    
                }
            }];
        }];
    }
    return _footer;
}



#pragma mark UIImagePickerControllerDelegate
// 打开照相机
- (void)takePhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    if (self.presentedViewController) {
        return;
    }
    //    [[[UIApplication sharedApplication].windows objectAtIndex:1] makeKeyAndVisible];
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing= NO;
    picker.view.backgroundColor = [UIColor blackColor];
    picker.sourceType =	sourceType;//		UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

// 打开本地相册
- (void)localPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

/*
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}
 */

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
        
        [_header.iconBtn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
        
        //self.header.iconBtn.imageView.image = image;
        [self changeImage];
        
        
        if (_header.iconBtn.tag == 5000) {
            [self.upDict setObject:image forKey:@"hand"];
        }
        
        /*
        _photoImage.image = [UIImage imageWithData:data];
        _photo2Image.alpha = 0;
        
         //显示和隐藏
         UIImageView *selectView = (UIImageView *)[self viewWithTag:10000 + _selectBtn.tag - 5000];
         selectView.image = [UIImage imageWithData:data];
         UIImageView *normalView = (UIImageView *)[self viewWithTag:10000 + _selectBtn.tag - 5000];
         normalView.alpha = 0;
         */
    }
}



@end
