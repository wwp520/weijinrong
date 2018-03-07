//
//  Unity.h
//  PowerOnHD
//
//  Created by Srain on 13-5-29.
//  Copyright (c) 2013年 lu yingzhi. All rights reserved.
//
#define tabbarheight 49

#define PAGE_NUM 20 //翻页数量
#define PAGE_MAX_NUM 10000  //获取答题列表时的最大翻页数量
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width


#define TitleColor [Unity getColor:@"#535353"]
#define OrangeColor [Unity getColor:@"#e56c2b"]
#define LineColor [Unity getColor:@"#ededed"]
#define TitleSize [UIFont systemFontOfSize:14]
#define TitleMaxSize [UIFont systemFontOfSize:17]
#define TitleMinSize [UIFont systemFontOfSize:13]
#define TIME 120
#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#include <mach/mach.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "UIImageView+WebCache.h"


#define Internationalization(A)\
 NSLocalizedString(A, @"")

#define THESECRETKEY @"01010101010101010101010101010101" 
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)

@interface Unity : NSObject
+(BOOL)isIOS7;

+(UIColor*)getBackColor;
+(UIColor*)getTableItemSeleteColor;

+(NSDate *)stringToDate:(NSString *)string;
+(NSDate *)stringToTime:(NSString *)string;
+(NSDate *)stringToTimeMM:(NSString *)string;
+(NSString *)dateToString:(NSDate *)date;
+(NSString *)timeToString:(NSDate *)date;
+(NSString *)timeToMMString:(NSDate *)date;

//根据宽度和字体 自动计算文本高度
+(CGFloat) getLabelHeightWithWidth:(CGFloat)labelWidth andDefaultHeight:(CGFloat)labelDefaultHeight andFontSize:(CGFloat)fontSize andText:(NSString *)text;
+(NSString*)systemTime;     //系统时间
+(NSString*)systemTimeToMM;
//信用卡校验
+(BOOL)verfierBankCard:(NSString *)card;
//显示alertview
+(void)showAlertView:(NSString *)alertString;

//时间戳转换标准时间
+(NSString*)systemStampToTime:(NSString *)stamp;

//encodeURL只能用来对url中的component编码，不能用来对整个url进行编码。
+(NSString*)encodeURL:(NSString*) unescapedString;

//计算距离，把距离转换为公里，不足一公里为米
+(NSString*)systemMToKM:(NSString*)juli;

//获取文本颜色
+(UIColor *)getColor:(NSString *) stringToConvert;

//打印内存
+(void)logMemoryInfo;

//计算坐标比例X
+(CGFloat)countcoordinatesX:(CGFloat)numberX;
//计算坐标比例Y
+(CGFloat)countcoordinatesY:(CGFloat)numberY;
//计算宽度
+(CGFloat)countcoordinatesW:(CGFloat)numberW;

+(UIViewController*)getViewController:(UIView*)view;
+(NSString *)roundUp:(NSString*)number afterPoint:(int)position;//不四舍五入
+(NSString*)intToString:(int)temp;

+(void)toViewController:(UINavigationController*)navigationController withLastCount:(int)count;

+(BOOL)isBlankString:(NSString *)string;

+(BOOL)verfierEmail:(NSString *)email;
+(BOOL)verfierPwd:(NSString*)password;
//判断密码
+(BOOL)verfierPassword:(NSString *)pwd;
+(void)removeHUDFromSuperview; //移除等待页面
+(void)showErrorAlert: (id)sender
              message: (NSString *) errorStr;//显示错误信息

+(void)showWarningAlert: (id)sender      //显示警告信息
                message: (NSString *) errorStr;

+(void)showOKAlert: (id)sender          //显示成功信息
           message: (NSString *) okStr;
+(void)showHUD:(NSString *) titleStr;   //显示等待框
+(void)hideHUD;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+(CGPoint) GetPointParentView:(UIView *)view;//计算相对高度

+(UILabel *)lableViewAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _string:(NSString *)string  _lableFont:(UIFont *)font _lableTxtColor:(UIColor *)color _textAlignment:(NSTextAlignment)alignment;

+(UIButton *)buttonAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _tag:(id)viewcontroller _action:(SEL)action _string:(NSString *)string _imageName:(NSString *)image;

+(UIImageView *)imageviewAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _imageName:(NSString *)image _backgroundColor:(UIColor *)color;
+(UIView *)backviewAddview_subViewFrame:(CGRect)rect _viewColor:(UIColor *)color;

+(UITextField *)textFieldAddSuperview_superView:(UIView *)superview
                                  _subViewFrame:(CGRect)rect
                                        _placeT:(NSString *)placeholder
                               _backgroundImage:(UIImage *)background
                                      _delegate:(id)delegate
                                      andSecure:(BOOL)ture
                             andBackGroundColor:(UIColor *)color;
//带有leftView
+(UITextField *)textFieldWithLeftViewAddSuperview_superView:(UIView *)superview
                                              _subViewFrame:(CGRect)rect
                                                    _placeT:(NSString *)placeholder
                                           _backgroundImage:(UIImage *)background
                                                  _delegate:(id)delegate
                                                  andSecure:(BOOL)ture
                                         andBackGroundColor:(UIColor *)color;
//获取个人信息
+(NSString *)get_infoMessage_withKey:(NSString *)key;

//检验银行卡卡号是否符合规则
+ (BOOL)isValidCreditNumber:(NSString *)value;
//身份证验证
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//手机号转为187****5578
+ (NSString *)phoneFormat:(NSString *)phone;
//截取图片，链接URL，下载缩率图
+ (NSString *)stringFormatter:(NSString *)phoneString;
//文件下载路径
+(NSString *)get_field_string;
//服务规则
+(NSString *)get_serviceRules;
//支付url
+(NSString *)get_PayTheURL;

//检测是否开启麦克风
+ (BOOL)isHeadsetPluggedIn;

//判断是否是键盘图片
+ (BOOL)isContainsEmoji:(NSString *)string;
//字符串转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//字符串转换成数组
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;
//判断麦克风是否可用
+ (BOOL)canRecordMicrophone;
//加密
+ (NSString*)kCCEncrypt:(NSString*)plainText password:(NSString *)pwd;
//解密
+ (NSString*)kCCDecrypt:(NSString*)plainText password:(NSString *)pwd;

//16进制字符串转换为nsdata
+ (NSData *)hexToByteToNSData:(NSString *)str;
//2进制转换为16进制
+ (NSString *)zhuanhuan:(NSData *)data;
//16进制转换为10进制
+ (NSString *)stringFromHexString:(NSString *)hexString;
//生成UUID
+ (NSString *)uuid;
//截取字符串后八位
+ (NSString *)keyString;
//分割字符串
+ (NSArray *)divisionStr:(NSString *)string;
/** 加密数据 */
+ (NSString *)encryptionJsonString:(NSString *)string;
/** 解密数据 */
+ (NSString *)decryptJsonString:(NSString *)string;
//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;



@end
