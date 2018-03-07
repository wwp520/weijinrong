//
//  NewPhotoController.h
//  chengzizhifu
//
//  Created by RY on 16/12/28.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPhotoController : BaseViewController

/* 字符串 **/
@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *shopStr;  //店铺名称
@property (nonatomic, copy) NSString *IDStr;
@property (nonatomic, copy) NSString *emailStr;
@property (nonatomic, copy) NSString *cardStr;
@property (nonatomic, copy) NSString *province_id; //省份ID
@property (nonatomic, copy) NSString *city_id;     //城市ID
@property (nonatomic, copy) NSString *bankName;
@property (nonatomic, copy) NSString *bankCode;
@property (nonatomic, copy) NSString *creditCard; //信用卡

@property (nonatomic, strong) NSString *mobilephone;
@property (nonatomic, strong) NSString *password;

/* 经纬度 **/
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
@property (nonatomic, copy  ) NSString *address;

@end
