//
//  Code39.m
//  Code39Test
//
//  Created by Lin Patrick on 10/17/15.
//  Copyright © 2015 Gemmy Planet, Inc. All rights reserved.
//

#import "Code39.h"

@implementation Code39

+ (UIImage *)code39ImageFromString:(NSString *)strSource
                             Width:(CGFloat)barcodew
                            Height:(CGFloat)barcodeh {
    
    
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    [filter setValue:[strSource dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
    // 4.获取生成的图片
    CIImage *ciImg=filter.outputImage;
    //放大ciImg,默认生产的图片很小
    
    //5.设置二维码的前景色和背景颜色
    CIFilter *colorFilter=[CIFilter filterWithName:@"CIFalseColor"];
    //5.1设置默认值
    [colorFilter setDefaults];
    [colorFilter setValue:ciImg forKey:@"inputImage"];
    [colorFilter setValue:[CIColor colorWithRed:0 green:0 blue:0] forKey:@"inputColor0"];
    [colorFilter setValue:[CIColor colorWithRed:1 green:1 blue:1] forKey:@"inputColor1"];
    //5.3获取生存的图片
    ciImg = colorFilter.outputImage;
    
    CGAffineTransform scale = CGAffineTransformMakeScale(10, 10);
    ciImg = [ciImg imageByApplyingTransform:scale];
    
    
    //6.在中心增加一张图片
    UIImage *img=[UIImage imageWithCIImage:ciImg];
    //7.生存图片
    //7.1开启图形上下文
    UIGraphicsBeginImageContext(img.size);
    //7.2将二维码的图片画入
    //BSXPCMessage received error for message: Connection interrupted   why??
    [img drawInRect:CGRectMake(10, 10, img.size.width-20, img.size.height-20)];
    //7.3在中心划入其他图片
    
    UIImage *centerImg = [UIImage imageNamed:@"Center"];
    
    CGFloat centerW=barcodew;
    CGFloat centerH=barcodeh;
    CGFloat centerX=(img.size.width  - centerImg.size.width) * 0.5;
    CGFloat centerY=(img.size.height - centerImg.size.height) * 0.5;
    
    [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
    
    //7.4获取绘制好的图片
    UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
    
    //7.5关闭图像上下文
    UIGraphicsEndImageContext();
    //设置图片
    return finalImg;
}

@end
