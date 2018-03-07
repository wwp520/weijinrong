//
//  LoadInfoViewController.m
//  weijinrong
//
//  Created by ouda on 17/5/19.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "LoadInfoViewController.h"
#import "Unity.h"
#import "ZYHImageCompression.h"
#import "UIImage+ExitUIImage.h"
#import "LookUpdateInfoModel.h"


@interface LoadInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;


@property (nonatomic, strong) NSMutableDictionary *upDict;//上传的图片
@property(nonatomic,strong)BaseModel * models;
@property(nonatomic,strong)LookUpdateInfoModel * modelss;
@end

@implementation LoadInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"上传信息";
    [self cteateUI];
    [self getInfo];
}

- (void)cteateUI{
    _submitBtn.layer.cornerRadius = 5;
    _submitBtn.layer.masksToBounds = YES;
    
    UILabel * nameLb = [[UILabel  alloc]init];
    nameLb.frame = CGRectMake(40, 0, 80, 25);
    nameLb.text = @"真实姓名:";
    nameLb.textColor = [UIColor  lightGrayColor];
    nameLb.textAlignment=NSTextAlignmentLeft;
    nameLb.font=[UIFont  systemFontOfSize:15];
    _name.leftView = nameLb;
    _name.leftViewMode = UITextFieldViewModeAlways;
    _name.contentMode= UIViewContentModeScaleAspectFit;
    
    
    UILabel * numLb = [[UILabel  alloc]init];
    numLb.frame = CGRectMake(40, 0, 80, 25);
    numLb.text = @"身份证号:";
    numLb.textColor = [UIColor  lightGrayColor];
    numLb.textAlignment=NSTextAlignmentLeft;
    numLb.font=[UIFont  systemFontOfSize:15];
    _numberTF.leftViewMode = UITextFieldViewModeAlways;
    _numberTF.contentMode= UIViewContentModeScaleAspectFit;
    _numberTF.leftView = numLb;
    
    
    UILabel * phoneLb = [[UILabel  alloc]init];
    phoneLb.frame = CGRectMake(40, 0, 80, 25);
    phoneLb.text = @"联系方式:";
    phoneLb.textColor = [UIColor  lightGrayColor];
    phoneLb.textAlignment=NSTextAlignmentLeft;
    phoneLb.font=[UIFont  systemFontOfSize:15];
    _phoneTF.leftViewMode = UITextFieldViewModeAlways;
    _phoneTF.contentMode= UIViewContentModeScaleAspectFit;
    _phoneTF.leftView = phoneLb;
   
}

//查询更新信息
- (void)getInfo {
    [self showHudLoadingView:@"正在获取。。。"];
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [SaveManager  getStringForKey:@"mercId"],@"mercId",
                                                   _model.id,@"id",
                                                   nil]];  //类型
        [KKTools encryptionJsonString:str];
    })];

    
    [DongManager  LookUpdataInfo:oldParam success:^(id requestData) {
        [self hiddenHudLoadingView];
        
        _modelss = [LookUpdateInfoModel  decryptBecomeModel:requestData];
//        //解析数据
        if (_modelss.retCode == 0) {
          
            
            NSLog(@"---------------查询更新信息成功---------------");
            //如果有值显示出来
            if (_modelss.applicntName.length != 0) {
                _name.text = _modelss.applicntName;
            }
            if (_modelss.crpIdNo.length != 0) {
               _numberTF.text = _modelss.crpIdNo;
            }
            if (_modelss.mobilephone.length != 0) {
               _phoneTF.text = _modelss.mobilephone;
            }
            
        }else{
            [self showTitle:_modelss.retMessage delay:1.5f];
        }
        
        
    } fail:^(NSError *error) {
        [self  showNetFail];
    }];
  
}
// 上传图片信息
- (void)getPhoto {
    [self showHudLoadingView:@"正在获取。。。"];
    
    AFNFileModel *model = [[AFNFileModel alloc]init];
    model.fileData = UIImagePNGRepresentation(_photoBtn.imageView.image);
    model.fileName = @"123.jpg";
    model.name = @"file";
    model.mimeType = @"multipart/form-data";
    
    NSDictionary *params = @{@"mobilePhone":GetAccount};
    
    [KKManager fileautograph:params image:model success:^(id requestData) {
        BaseModel *model = [BaseModel decryptXiaoModel:requestData];
        if (model.retCode == 0) {
            [self getText];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    } progess:^(double progress) {
        
    }];
}
// 上传文字信息
- (void)getText {
    NSString *oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [SaveManager  getStringForKey:@"mercId"],@"mercId",
                              _name.text,@"applicantName",//申请人姓名
                              _numberTF.text,@"crpIdNo",//身份证号
                              _phoneTF.text,@"mobilephone",//手机号
                              _model.id,@"id",
                              nil];
        NSString *str = [KKTools dictionaryToJson:dict];
        [KKTools encryptionJsonString:str];
    })];
    
    
    [DongManager SubmitInfo:oldParam success:^(id requestData) {
        [self hiddenHudLoadingView];
        
        _models = [BaseModel decryptBecomeModel:requestData];
        [self showTitle:_models.retMessage delay:1.5f];
        //解析数据
        if (_models.retCode == 0) {
            NSLog(@"%@",requestData);
        }else {
            NSLog(@"失败");
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}

//提交审核信息
- (IBAction)submitBtn:(id)sender {
    
    [self getPhoto];
    

}


//调取相机
- (IBAction)photoBtn:(id)sender {
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        NSLog(@"该设备无摄像头");
    }
    
}

#pragma mark--UIImagePickerControllerDelegate
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
        
        [_photoBtn setImage:image forState:UIControlStateNormal];
        [_photoBtn setImage:image forState:UIControlStateHighlighted];
        
//         [self.upDict setObject:image forKey:@"hand"];
        
        //照片显示
        
    }
}


@end
