//
//  AFNFileModel.h
//  AFN3.0
//
//  Created by RY on 16/10/18.
//  Copyright © 2016年 RY. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 上传图片用到的Model */
@interface AFNFileModel : NSObject
@property (nonatomic, strong) NSData *fileData; //要上传的二进制文件
@property (nonatomic, copy) NSString *fileName; //文件名称
@property (nonatomic, copy) NSString *name;     //名称
@property (nonatomic, copy) NSString *mimeType; //类型
@end
