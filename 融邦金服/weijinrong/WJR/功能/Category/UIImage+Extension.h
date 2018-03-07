//
//  UIImage+Extension.h
//  BusinessPeople
//
//  Created by RY on 17/1/13.
//  Copyright © 2017年 RY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/** 更改大小 */
- (UIImage *)imageClipWithSize:(CGSize)targetSize ;
/** 更改大小 */
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize ;
/** 生成二维码 */
+ (UIImage *)qrWithStr:(NSString *)qrStr size:(CGFloat)size;


@end
