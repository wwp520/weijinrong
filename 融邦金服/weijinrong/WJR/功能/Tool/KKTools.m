//
//  KKTools.m
//  BusinessPeople
//
//  Created by RY on 17/1/10.
//  Copyright © 2017年 RY. All rights reserved.
//

#import "KKTools.h"
#import "sys/utsname.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSString+MD5.h"
#import "PushView.h"
#import "AppDelegate.h"

#define APPDELEGATE  ((AppDelegate *)[UIApplication sharedApplication].delegate)

@implementation KKTools

//=================================== 界面 ===================================//
// 设置右侧图标
+ (void)setRightWithVc:(BaseViewController *)vc Image:(NSString *)title action:(SEL)sel {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 30, 30);
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setBackgroundImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
        [btn addTarget:vc action:sel forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
    vc.navigationItem.rightBarButtonItem = item;
}
// 设置右侧图标
+ (void)setLeftWithVc:(BaseViewController *)vc Image:(NSString *)title action:(SEL)sel {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setBackgroundImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
        [btn addTarget:vc action:sel forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
    vc.navigationItem.leftBarButtonItem = item;
}
// 输入框左侧图标
+ (void)setFiledLeft:(NSString *)str field:(UITextField *)textField {
    textField.leftView = ({
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        image.image = [UIImage imageNamed:str];
        image.contentMode = UIViewContentModeScaleAspectFit;
        image;
    });
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    
}
// 输入框右侧图标
+ (void)setFiledRight:(NSString *)str field:(UITextField *)textField {
    textField.rightView = ({
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        image.contentMode  = UIViewContentModeScaleAspectFit;
        image.image        = [UIImage imageNamed:str];
        image;
    });
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    
}
// 获取当前显示的控制器
+ (BaseViewController *)getCurrentVC {
    BaseViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[BaseViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

//=================================== 转换 ===================================//
// 字符串转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
// 字典转换为字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
+ (NSString *)dictionaryToJson2:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
// 字典转换为JSON
+ (NSString *)convertToJsonData:(NSDictionary *)dict {
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
// 字符串转换成字典
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return array;
}


//=================================== 验证 ===================================//
// 验证手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    NSString * MU =@"^((14[5,7])|(13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,1-9]))\\d{8}$";
    NSPredicate *regextestMU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MU];
    if ([regextestMU evaluateWithObject:mobileNum] == YES) {
        return YES;
    }else {
        return NO;
    }
}
// 信用卡验证
+ (BOOL)isValidCreditNumber:(NSString*)value {
    if (value.length>9) {
        NSString * lastNum = [[value substringFromIndex:(value.length-1)] copy];//取出最后一位
        NSString * forwardNum = [[value substringToIndex:(value.length -1)] copy];//前15或18位
        NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i=0; i<forwardNum.length; i++) {
            NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
            [forwardArr addObject:subStr];
        }
        
        NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i =(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
            [forwardDescArr addObject:forwardArr[i]];
        }
        
        NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
        NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 >9
        NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
        for (int i=0; i< forwardDescArr.count; i++) {
            NSInteger num = [forwardDescArr[i] intValue];
            if (i%2) {//偶数位
                [arrEvenNum addObject:[NSNumber numberWithInt:num]];
            }else{//奇数位
                if (num * 2 < 9) {
                    [arrOddNum addObject:[NSNumber numberWithInt:num * 2]];
                }else{
                    NSInteger decadeNum = (num * 2) / 10;
                    NSInteger unitNum = (num * 2) % 10;
                    [arrOddNum2 addObject:[NSNumber numberWithInt:unitNum]];
                    [arrOddNum2 addObject:[NSNumber numberWithInt:decadeNum]];
                }
            }
        }
        __block  NSInteger sumOddNumTotal = 0;
        [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
            sumOddNumTotal += [obj integerValue];
        }];
        __block NSInteger sumOddNum2Total = 0;
        [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
            sumOddNum2Total += [obj integerValue];
        }];
        __block NSInteger sumEvenNumTotal =0 ;
        [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
            sumEvenNumTotal += [obj integerValue];
        }];
        NSInteger lastNumber = [lastNum integerValue];
        NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
        return (luhmTotal%10 ==0)?YES:NO;
    }
    return NO;
}
// 身份证验证
+ (BOOL)validateIdentityCard:(NSString *)identityCard {
    //    BOOL flag;
    //    if (identityCard.length <= 0) {
    //        flag = NO;
    //        return flag;
    //    }
    //    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    //    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //    return [identityCardPredicate evaluateWithObject:identityCard];
    
    //判断位数
    
    
    if ([identityCard length] != 15 && [identityCard length] != 18) {
        return NO;
    }
    NSString *carid = identityCard;
    
    long lSumQT =0;
    
    //加权因子
    
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    
    //校验码
    
    unsigned char sChecker[11]={'1','0','X','9','8', '7', '6', '5', '4', '3', '2'};
    
    
    
    //将15位身份证号转换成18位
    
    NSMutableString *mString = [NSMutableString stringWithString:identityCard];
    
    if ([identityCard length] == 15) {
        
        [mString insertString:@"19" atIndex:6];
        
        long p = 0;
        
        const char *pid = [mString UTF8String];
        
        for (int i=0; i<=16; i++)
            
        {
            
            p += (pid[i]-48) * R[i];
            
        }
        
        int o = p%11;
        
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        
        [mString insertString:string_content atIndex:[mString length]];
        
        carid = mString;
        
    }
    
    //判断地区码
    
    NSString * sProvince = [carid substringToIndex:2];
    
    if (![KKTools areaCode:sProvince]) {
        
        return NO;
        
    }
    
    //判断年月日是否有效
    
    
    
    //年份
    
    int strYear = [[KKTools getStringWithRange:carid Value1:6 Value2:4] intValue];
    
    //月份
    
    int strMonth = [[KKTools getStringWithRange:carid Value1:10 Value2:2] intValue];
    
    //日
    
    int strDay = [[KKTools getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setTimeZone:localZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil) {
        
        return NO;
        
    }
    
    const char *PaperId  = [carid UTF8String];
    
    //检验长度
    
    if( 18 != strlen(PaperId)) return -1;
    
    
    
    //校验数字
    
    for (int i=0; i<18; i++)
        
    {
        
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
            
        {
            
            return NO;
            
        }
        
    }
    
    //验证最末的校验码
    
    for (int i=0; i<=16; i++)
        
    {
        
        lSumQT += (PaperId[i]-48) * R[i];
        
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] )
        
    {
        
        return NO;
        
    }
    
    return YES;
}
// 验证email
+ (BOOL)verfierEmail:(NSString *)email {
    BOOL result = YES;
    
    NSString* regex = @"(^\\s*([A-Za-z0-9_-]+(\\.\\w+)*@(\\w+\\.)+\\w{2,5})\\s*$)";
    
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    result = [pred evaluateWithObject:email];
    
    return result;
}
// 验证密码
+ (BOOL)verfierPassword:(NSString *)pwd {
    BOOL result = YES;
    
    NSString* regex = @"^[0-9a-zA-Z_]{6,20}";
    
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    result = [pred evaluateWithObject:pwd];
    
    return result;
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */

+ (BOOL)areaCode:(NSString *)code {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@"北京" forKey:@"11"];
    
    [dic setObject:@"天津" forKey:@"12"];
    
    [dic setObject:@"河北" forKey:@"13"];
    
    [dic setObject:@"山西" forKey:@"14"];
    
    [dic setObject:@"内蒙古" forKey:@"15"];
    
    [dic setObject:@"辽宁" forKey:@"21"];
    
    [dic setObject:@"吉林" forKey:@"22"];
    
    [dic setObject:@"黑龙江" forKey:@"23"];
    
    [dic setObject:@"上海" forKey:@"31"];
    
    [dic setObject:@"江苏" forKey:@"32"];
    
    [dic setObject:@"浙江" forKey:@"33"];
    
    [dic setObject:@"安徽" forKey:@"34"];
    
    [dic setObject:@"福建" forKey:@"35"];
    
    [dic setObject:@"江西" forKey:@"36"];
    
    [dic setObject:@"山东" forKey:@"37"];
    
    [dic setObject:@"河南" forKey:@"41"];
    
    [dic setObject:@"湖北" forKey:@"42"];
    
    [dic setObject:@"湖南" forKey:@"43"];
    
    [dic setObject:@"广东" forKey:@"44"];
    
    [dic setObject:@"广西" forKey:@"45"];
    
    [dic setObject:@"海南" forKey:@"46"];
    
    [dic setObject:@"重庆" forKey:@"50"];
    
    [dic setObject:@"四川" forKey:@"51"];
    
    [dic setObject:@"贵州" forKey:@"52"];
    
    [dic setObject:@"云南" forKey:@"53"];
    
    [dic setObject:@"西藏" forKey:@"54"];
    
    [dic setObject:@"陕西" forKey:@"61"];
    
    [dic setObject:@"甘肃" forKey:@"62"];
    
    [dic setObject:@"青海" forKey:@"63"];
    
    [dic setObject:@"宁夏" forKey:@"64"];
    
    [dic setObject:@"新疆" forKey:@"65"];
    
    [dic setObject:@"台湾" forKey:@"71"];
    
    [dic setObject:@"香港" forKey:@"81"];
    
    [dic setObject:@"澳门" forKey:@"82"];
    
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        
        return NO;
        
    }
    
    return YES;
    
}
+ (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger )value2 {
    return [str substringWithRange:NSMakeRange(value1,value2)];
}



//=================================== 时间 ===================================//
// 返回时间字符串
+ (NSString *)strWithDate:(NSString *)dateFormat today:(NSInteger)days {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:days * 60 * 60 * 24];
    NSDateFormatter *formatter = ({
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:dateFormat];
        formatter;
    });
    return [formatter stringFromDate:date];
}

//=================================== 加密 ===================================//
+ (NSString *)encryptionJsonString:(NSString *)string {//加密数据
    NSString *str = [self keyString];
    NSArray *arr = [self divisionStr:str];
    NSMutableArray * arr1=[NSMutableArray arrayWithArray:arr];
    [arr1 insertObject:[self kCCEncrypt:string password:str] atIndex:1];
    NSString * json=[arr1 componentsJoinedByString:@""];
    [arr1 insertObject:[json md5] atIndex:3];
    return [arr1 componentsJoinedByString:@"|"];
}
+ (NSString *)decryptJsonString:(NSString *)string {//解密方法
    NSArray *arr = [string componentsSeparatedByString:@"|"];
    NSMutableArray *arr1=[NSMutableArray arrayWithArray:arr];
    if (arr1.count >= 4) {
        NSString *lastStr = arr1[3];
        NSString *str0 = arr1[0];
        NSString *str1 = arr1[1];
        NSString *str2 = arr1[2];
        [arr1 removeLastObject];
        if ([[[arr1 componentsJoinedByString:@""] md5] isEqualToString:[lastStr lowercaseString]]) {
            NSMutableArray  * keyArr=[NSMutableArray array];
            [keyArr addObject:str0];
            [keyArr addObject:str2];
            NSString *key = [keyArr componentsJoinedByString:@""];
            NSString *result1 = [[NSString alloc] initWithData:[self hexToByteToNSData:key]  encoding:NSUTF8StringEncoding];
            return [self kCCDecrypt:str1 password:result1];
        }else{
            return @"数据不匹配";
        }
    }else{
        return  @"数据错误";
    }
    return nil;
}
+ (NSData *)hexToByteToNSData:(NSString *)str{//16进制字符串转换为NSData
    int j=0;
    Byte bytes[[str length]/2];
    for(int i=0;i<[str length];i++)
    {
        int int_ch;  ///两位16进制数转化后的10进制数
        unichar hex_char1 = [str characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        unichar hex_char2 = [str characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        int_ch = int_ch1+int_ch2;
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:[str length]/2 ];
    return newData;
}
+ (NSString *)keyString{//截取字符串后八位
    NSString * str=[self uuid];
    NSArray * array=[str componentsSeparatedByString:@"-"];
    if (array[4]==nil) {
        return nil;
    }
    return [array[4] substringToIndex:8];
}
+ (NSString *)uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString); return result ;
}
+ (NSArray  *)divisionStr:(NSString *)string{//分割字符串
    NSData * data=[string dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray * array=[NSMutableArray array];
    if ([[self zhuanhuan:data] length]<16) {
        return nil;
    }else{
        NSString * str=[[self zhuanhuan:data] substringToIndex:8];
        NSString * str1=[[self zhuanhuan:data] substringFromIndex:8];
        [array addObject:str];
        [array addObject:str1];
    }
    return array;
}
+ (NSString *)zhuanhuan:(NSData *)data{//2进制转换为16进制
    Byte *bytes=(Byte*)[data bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++)
    {
        NSString *newHexStr=[NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr=[NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr=[NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return [hexStr uppercaseString];
}
+ (NSString *)kCCEncrypt:(NSString*)plainText password:(NSString*)pwd{
    const void *vplainText;
    size_t plainTextBufferSize;
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    plainTextBufferSize = [data length];
    vplainText = (const void *)[data bytes];
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    const void *vkey = (const void *)[pwd UTF8String];
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey,
                       kCCKeySizeDES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    NSString *result;
    //加密
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    result =[self zhuanhuan:myData];
    return result;
}
+ (NSString*)kCCDecrypt:(NSString*)plainText password:(NSString *)pwd{//解密
    const void *vplainText;
    size_t plainTextBufferSize;
    NSData *EncryptData=[self hexToByteToNSData:plainText];
    plainTextBufferSize = [EncryptData length];
    vplainText = [EncryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    const void *vkey = (const void *)[pwd UTF8String];
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey,
                       kCCKeySizeDES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    NSString *result;
    
    result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                           length:(NSUInteger)movedBytes]
                                   encoding:NSUTF8StringEncoding];
    
    return result;
}


//================================ 切换根控制器 ================================//
+ (void)becomeTabController {
    // 跳转
    BaseTabBarController *tab = [[BaseTabBarController alloc] init];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    tab.view.y = ScreenHeight;
//    [window addSubview:tab.view];
//    [UIView animateWithDuration:.3f delay:.1f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        tab.view.y = 0;
//    } completion:^(BOOL finished) {
//        [tab removeFromParentViewController];
//        window.rootViewController = tab;
//    }];
    [[KKTools getCurrentVC] presentViewController:tab animated:YES completion:nil];
}
// 回到登录
+ (void)becomeLoginController {
//    // 跳转
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    BaseNavigationController *login = [[BaseNavigationController alloc] initWithRootViewController:[[LoginController alloc] init]];
//    login.view.y = ScreenHeight;
//    [window addSubview:login.view];
//    [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        login.view.y = 0;
//    } completion:^(BOOL finished) {
//        [login removeFromParentViewController];
//    }];
    window.rootViewController = login;
}


// 从通知进来
+ (void)presentPushController:(UserPushModel *)model click:(KKBlock)click {
    if (!model) {
        return;
    }
    
    PushView *vc = [PushView loadFromFrame:ScreenBounds click:^{
        if (click) {
            click();
        }
    }];
    vc.model = model;
    vc.width = ScreenWidth;
    vc.height = ScreenHeight;
    vc.y = ScreenHeight;
    APPDELEGATE.window.backgroundColor = [UIColor redColor];
    [APPDELEGATE.window addSubview:vc];
    [APPDELEGATE.window bringSubviewToFront:vc];
    [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        vc.y = 0;
    } completion:^(BOOL finished) {
    }];
}


@end
