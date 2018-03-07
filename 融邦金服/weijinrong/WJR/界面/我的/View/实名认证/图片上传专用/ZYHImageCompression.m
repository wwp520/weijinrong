//
//  ZYHImageCompression.m
//  chengzizhifu
//
//  Created by 快易 on 15/1/8.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "ZYHImageCompression.h"

@implementation ZYHImageCompression
+(CGSize)get_ImageCompressionProportion:(UIImage *)image
{
    CGSize size = image.size;
    CGFloat HBL = ScreenHeight / size.height;
    CGFloat WBL = ScreenWidth / size.width;
    
    if (size.width <= ScreenWidth && size.height <= ScreenHeight) {
        return size;
    }
    else if (size.width > ScreenWidth && size.height <= ScreenHeight) {
        size.width = ScreenWidth;
        size.height = size.height * WBL;
        NSString * str = [NSString stringWithFormat:@"%.0f",size.height];
        size.height = [str floatValue];
    }
    else if (size.height > ScreenHeight && size.width <= ScreenWidth) {
        size.height = ScreenHeight;
        size.width = size.width * HBL;
        NSString * str = [NSString stringWithFormat:@"%.0f",size.width];
        size.width = [str floatValue];
    }
    else if (size.height > ScreenHeight && size.width > ScreenWidth) {
        if (HBL < WBL) {
            size.height = ScreenHeight;
            size.width = size.width * HBL;
            NSString * str = [NSString stringWithFormat:@"%.0f",size.width];
            size.width = [str floatValue];
        }
        else
        {
            size.width = ScreenWidth;
            size.height = size.height * WBL;
            NSString * str = [NSString stringWithFormat:@"%.0f",size.height];
            size.height = [str floatValue];
        }
    }
    return size;
}
@end
