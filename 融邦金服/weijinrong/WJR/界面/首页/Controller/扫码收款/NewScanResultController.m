//
//  NewScanResultController.m
//  chengzizhifu
//
//  Created by RY on 17/1/6.
//  Copyright © 2017年 ZYH. All rights reserved.
//

#import "NewScanResultController.h"
#import "WeiChatPayTypeModel.h"
//#import "QRCodeGenerator.h"
#import "WeiChatCoderModel.h"
#import "AlipayPayModel.h"
#import "WeiChatSuccController.h"

#pragma mark 声明
@interface NewScanResultController (){
    NSInteger _returnTime;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bjY;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *payState;
@property (weak, nonatomic) IBOutlet UIImageView *qr;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSString *orderNum;//订单号
@end

#pragma mark 实现
@implementation NewScanResultController


#pragma mark 网络请求

#pragma mark 点击事件
- (void)share {
    //弹出分享
    UIImage *image = self.qr.image;
    
    //share分享时只能分享xcode中的图片
    if (image) {
        if (image) {
            [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
            [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                // 创建分享消息对象
                UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                // 创建图片内容对象
                UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
                [shareObject setShareImage:image];
                [messageObject setShareObject:shareObject];
                // 调用分享接口
                [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                    if (error) {
                        [self showTitle:@"分享失败" delay:2];
                    }else {
                        
                    }
                }];
            }];
        }
    }
}

#pragma mark 网络
// 微信付款
- (void)wei_url {
    NSDictionary *params = @{@"mercId":[SaveManager getStringForKey:@"mercId"],
                             @"payAmount":_money,
                             @"typeNo":@"A011",
                             @"dealgrade":@"6"};
    [self showHudLoadingView:@"正在获取..."];
    
    
    [DongManager weiChatPay:params success:^(id requestData) {
        [self hiddenHudLoadingView];
        _returnTime = 0;
        // 解析
        WeiChatPayTypeModel *model = [ WeiChatPayTypeModel decryptBecomeModel:requestData];
        // 显示
        if (model.retCode == 0) {
            [self setOrderNum:model.orderNum];
            [self.qr setImage:[Code39 code39ImageFromString:model.codeUrl Width:250.f Height:250.f]];
            NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!%@",requestData);
            [self getPayState];
        }else{
            [self showTitle:model.retMessage delay:1];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}
// 支付宝付款[SaveManager getStringForKey:@"mercId"]
- (void)alipy_url {
    NSDictionary *params = @{@"mercId":[SaveManager getStringForKey:@"mercId"],
                             @"payAmount":_money,
                             @"typeNo":@"A011",
                             @"dealgrade":@"7"};
    [self showHudLoadingView:@"正在获取..."];
    
    [DongManager alipyPay:params success:^(id requestData) {
        [self hiddenHudLoadingView];
        _returnTime = 0;
        // 解析
        WeiChatPayTypeModel *model = [ WeiChatPayTypeModel decryptBecomeModel:requestData];
        // 显示
        if (model.retCode == 0) {
            [self setOrderNum:model.orderNum];
            [self.qr setImage:[Code39 code39ImageFromString:model.codeUrl Width:250.f Height:250.f]];
            [self getPayState];
        }else{
            [self showTitle:model.retMessage delay:1];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}
// 请求扫码支付状态
- (void)getPayInfo {
    _returnTime += 5;
    NSInteger timeOut = 120;
    if (self.orderNum == nil || [self.orderNum isEqualToString:@""]) {
        return;
    }
    // 参数
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [SaveManager getStringForKey:@"mercId"],@"mercId",
                            self.orderNum,@"orderNum", nil];
    
    // 请求
    [DongManager payState:params success:^(id requestData) {
        AlipayPayModel *model = [AlipayPayModel decryptBecomeModel:requestData];
        // 未支付
        if (model.retCode != 0) {
            // 这里指的是20秒
            if (_returnTime >= timeOut) {
                [self showTitle:model.retMessage delay:1];
                [self popRootDelay];
            }
            return;
        }
        // 已支付
        [self showTitle:model.retMessage delay:1];
        [self success];
    } fail:^(NSError *error) {
        if (_returnTime >= timeOut) {
            [self showTitle:@"订单支付失败" delay:1];
            [self popRootDelay];
        }
    }];
}

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self networking];
}
- (void)createUI {
    // 界面设置
    [self setNavTitle:@"扫码支付"];
    [self createNavigation];
    [_payState.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view setBackgroundColor:RGB(233,233,233,1)];
    
    if (_money) {
        _price.text = _money;
    }else{
        _price.text = @"0.00";
    }
    // iPhone4s
    if (ScreenHeight == 480) {
        _bjY.constant = 10;
    }
    // 支付宝
    if (_type == 1) {
        [_payState setImage:[UIImage imageNamed:@"newLittle_alipy"] forState:UIControlStateNormal];
        [_payState setTitle:@"支付宝付款" forState:UIControlStateNormal];
        [_payState setTitleColor:RGB(75,177,236,1) forState:UIControlStateNormal];
    }
    // 分享
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:({
        UIButton *scanBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [scanBtn setImage:[UIImage imageNamed:@"newSet_share"] forState:UIControlStateNormal];
        scanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [scanBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        scanBtn;
    })];
}
- (void)networking {
    if (_type == 0) {
        [self wei_url];
    }else {
        [self alipy_url];
    }
}
// 定时请求支付状态
- (void)getPayState {
    NSTimer *payState = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getPayInfo) userInfo:nil repeats:YES];
    self.timer = payState;
    [[NSRunLoop mainRunLoop] addTimer:payState forMode:NSDefaultRunLoopMode];
}
// 支付成功
- (void)success {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *platform = _type == 1 ? @"支付宝支付已成功" : @"微信支付已成功";
        WeiChatSuccController *vc = [[WeiChatSuccController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.orderNum = _orderNum;
        vc.stateStr = platform;
        vc.money    = _money;
        [self.navigationController pushViewController:vc animated:YES];
        [self.timer invalidate];
        self.timer = nil;
    });
}


#pragma mark - QRCodeGenerator
- (UIImage *)createNonUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [[UIImage alloc]initWithCGImage:scaledImage scale:5 orientation:UIImageOrientationUp];
    //    return [UIImage imageWithCGImage:scaledImage];
}
- (CIImage *)createQRForStr:(NSString *)qrString {
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}
void ProviderReleaseBate2 (void *info, const void *data, size_t size){
    free((void*)data);
}
- (UIImage *)imageBlackToTransparent:(UIImage *)image withR:(CGFloat)red andG:(CGFloat)green andB:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            // change color
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseBate2);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

- (void)createNavigation{
    [self setNavTitle:@"扫码收款"];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

@end

