//
//  Unity.m
//  PowerOnHD
//
//  Created by Srain on 13-5-29.
//  Copyright (c) 2013年 lu yingzhi. All rights reserved.
//

#import "Unity.h"
#import "AppDelegate.h"
#import "sys/utsname.h"
#import "NSString+MD5.h"


//#define DESKEY @"D6D2402F1C98E208FF2E863AA29334BD65AE1932A821502D9E5673CDE3C713ACFE53E2103CD40ED6BEBB101B484CAE83D537806C6CB611AEE86ED2CA8C97BBE95CF8476066D419E8E833376B850172107844D394016715B2E47E0A6EECB3E83A361FA75FA44693F90D38C6F62029FCD8EA395ED868F9D718293E9C0E63194E87"
#define DESKEY @"111111111111111111111111"

@implementation Unity
+(BOOL)isIOS7
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
+(UIColor*)getBackColor
{
    return [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
}
+(UIColor*)getTableItemSeleteColor
{
    return [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
}
+(NSDate *)stringToDate:(NSString *)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:string];
    
    return destDate;
}
+(NSDate *)stringToTime:(NSString *)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:string];
    
    return destDate;
}
+(NSDate *)stringToTimeMM:(NSString *)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    NSDate *destDate= [dateFormatter dateFromString:string];

    return destDate;
}
+(NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
+(NSString *)timeToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
+(NSString *)timeToMMString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(CGFloat) getLabelHeightWithWidth:(CGFloat)labelWidth andDefaultHeight:(CGFloat)labelDefaultHeight andFontSize:(CGFloat)fontSize andText:(NSString *)text
{
	CGSize constraint = CGSizeMake(labelWidth, 20000.0f);
	
	CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	
	CGFloat labelHeight = MAX(size.height, labelDefaultHeight);
	
	return labelHeight;
}
+(NSString*)systemTime
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	return [dateFormatter stringFromDate:[NSDate date]];
}
+ (NSString *)roundUp:(NSString *)number afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal;
    
    NSDecimalNumber *roundedOunces;
//    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:number];
//    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:number];
    ouncesDecimal = [[NSDecimalNumber alloc] initWithString:number];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}
//显示alertview
+(void)showAlertView:(NSString *)alertString
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:alertString delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
    [alert show];
}

+(NSString*)systemTimeToMM
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
	return [dateFormatter stringFromDate:[NSDate date]];
}

//时间戳转换标准时间
+(NSString*)systemStampToTime:(NSString *)stamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[stamp doubleValue]];
    return [self countTimeLenght:date];
}

//计算时间间隔
+(NSString *)countTimeLenght:(NSDate *)data
{
    NSDate *nowData = [NSDate new];
    
    NSString *string = nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date1 = [formatter stringFromDate:data];
    NSString *date2 = [formatter stringFromDate:nowData];
    if ([date1 isEqualToString:date2]) {
        //如果是今天的
        NSTimeInterval timeCount = [nowData timeIntervalSinceDate:data];
        if (timeCount/(60)<60) { //分钟
            int count = timeCount/(60);
            if (count == 0) {
                string = @"刚刚";
            }else{
                string = [NSString stringWithFormat:@"%d分钟前",count];
            }
        }else if(timeCount/(60*60)>=1){ //小时
            int count = timeCount/(60*60);
            string = [NSString stringWithFormat:@"%d小时前",count];
        }
    }else{
        //不是今天的
        string = [self dateToString:data];
    }
    
    return string;
}

//计算距离，把距离转换为公里，不足一公里为米
+(NSString*)systemMToKM:(NSString*)juli
{
    CGFloat height = [juli floatValue];
    if (height<1000 && height>=0) {
        return [NSString stringWithFormat:@"%.0fm",height];
    }else{
        return [NSString stringWithFormat:@"%.0fkm",height/1000];
    }
}

//encodeURL只能用来对url中的component编码，不能用来对整个url进行编码。
+(NSString*)encodeURL:(NSString*) unescapedString
{
    NSString* escapedUrlString= (NSString*) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)unescapedString, NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]{}", kCFStringEncodingUTF8 ));
        
    return escapedUrlString ;
}

- (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


+(UIColor *)getColor:(NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

static BOOL memoryInfo(vm_statistics_data_t *vmStats)
{
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)vmStats, &infoCount);
    
    return kernReturn == KERN_SUCCESS;
}


+(void)logMemoryInfo
{
    vm_statistics_data_t vmStats;
    if (memoryInfo(&vmStats)) {
        NSLog(@"free: %lf M\nactive: %lu\ninactive: %lu\nwire: %lu\nzero fill: %lu\nreactivations: %lu\npageins: %lu\npageouts: %lu\nfaults: %u\ncow_faults: %u\nlookups: %u\nhits: %u",(vmStats.free_count * vm_page_size/ 1024.0) / 1024.0,vmStats.active_count * vm_page_size,vmStats.inactive_count * vm_page_size,vmStats.wire_count * vm_page_size,vmStats.zero_fill_count * vm_page_size,vmStats.reactivations * vm_page_size,vmStats.pageins * vm_page_size,vmStats.pageouts * vm_page_size,vmStats.faults,vmStats.cow_faults,vmStats.lookups,vmStats.hits);
    }
}

//计算坐标比例
+(CGFloat)countcoordinatesX:(CGFloat)numberX
{
    CGFloat percentage = numberX / 320;  //百分比
    return [UIScreen mainScreen].bounds.size.width * percentage;
}

//计算坐标比例Y
+(CGFloat)countcoordinatesY:(CGFloat)numberY
{
//    CGFloat percentage = numberY / 558;
    CGFloat percentage = numberY / 568;  //百分比
    return [UIScreen mainScreen].bounds.size.height * percentage;
}

+(CGFloat)countcoordinatesW:(CGFloat)numberW
{
    CGFloat percentage = numberW / [UIScreen mainScreen].bounds.size.width;  //百分比
    return [UIScreen mainScreen].bounds.size.width * percentage;
}

+(BOOL)strToBool:(NSString*)str
{
    BOOL result = NO;
    if ([str intValue] == 0 || [str isEqualToString:@"false"]) {
        result = NO;
    }else if ([str intValue] == 1 || [str isEqualToString:@"true"]){
        result = YES;
    }
    return result;
}
+(UIViewController*)getViewController:(UIView*)view {
    
    for (UIView* next = [view superview]; next; next = next.superview) {
        
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController*)nextResponder;
            
        }
        
    }
    
    return nil;
    
}
+(NSString*)intToString:(int)temp
{
    return [NSString stringWithFormat:@"%d",temp];
}

+(void)toViewController:(UINavigationController*)navigationController withLastCount:(int)count
{
    int nvcount = [navigationController.viewControllers count];
    if (count>=0 &&  nvcount >= count) {
        UIViewController* tempviewController = [navigationController.viewControllers objectAtIndex:([navigationController.viewControllers count]-count)];
        if (tempviewController!=nil) {
            [navigationController popToViewController:tempviewController animated:YES];
        }
    }
    
}

+ (BOOL)isBlankString:(NSString *)string
{
    
    if (string == nil) {
        
        return YES;
        
    }
    
    if (string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}
//信用卡校验
+(BOOL)verfierBankCard:(NSString *)card
{
    BOOL result = YES;
    
    NSString* regex = @"^(4\\d{12}(?:\\d{3})?)$";
    
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    result = [pred evaluateWithObject:card];
    
    return result;
}
//验证email
+(BOOL)verfierEmail:(NSString *)email
{
    BOOL result = YES;
    
    NSString* regex = @"(^\\s*([A-Za-z0-9_-]+(\\.\\w+)*@(\\w+\\.)+\\w{2,5})\\s*$)";
    
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    result = [pred evaluateWithObject:email];
    
    return result;
}

//验证6-18位字母或数字的密码
+(BOOL)verfierPwd:(NSString*)password
{
    BOOL result = YES;
    
    if (password.length <6 || password.length >18) {
        result = NO;
    }
    
    return result;
}
+(BOOL)verfierPassword:(NSString *)pwd
{
    BOOL result = YES;
    
    NSString* regex = @"^[0-9a-zA-Z_]{6,20}";
    
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    result = [pred evaluateWithObject:pwd];
    
    return result;
}

//验证手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
//    NSString * MU = @"^((13[0-9])|(15[0-9])|(18[0-9])|(14[0-9]))\\d{8}$";
    NSString * MU =@"^((14[5,7])|(13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,1-9]))\\d{8}$";
    
//    NSString * MU = @"1[0-9]{10}";
    NSPredicate *regextestMU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MU];
    if ([regextestMU evaluateWithObject:mobileNum] == YES) {
        return YES;
    }else
    {
        return NO;
    }
    /*
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }  */
}

//手机号转为187****5578
+ (NSString *)phoneFormat:(NSString *)phone
{
    NSString *str = [phone substringToIndex:3];
    NSString *str1 = [phone substringFromIndex:7];
    
    return [NSString stringWithFormat:@"%@****%@",str,str1];
}


+(CGPoint) GetPointParentView:(UIView *)view
{
    CGPoint size = CGPointMake(0, 0);
    id le=[view superview];
    while (le != nil) {
        CGPoint tempsize=(((UIView *)le).frame).origin;
        if(tempsize.x > 0 || tempsize.y>0)
        {
            size.x+=tempsize.x;
            size.y+=tempsize.y;
            le=[le superview];
        }
    }
    return size;
}

+(UILabel *)lableViewAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _string:(NSString *)string _lableFont:(UIFont *)font _lableTxtColor:(UIColor *)color _textAlignment:(NSTextAlignment)alignment
{
    UILabel *lable = [[UILabel alloc]initWithFrame:rect];
    lable.backgroundColor = [UIColor clearColor];
    lable.text = string;
    lable.font = font;
    lable.textColor = color;
    lable.textAlignment = alignment;
    [superview addSubview:lable];
    
    return lable;
}

+(UIButton *)buttonAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _tag:(id)viewcontroller _action:(SEL)action _string:(NSString *)string _imageName:(NSString *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitle:string forState:UIControlStateNormal];
    if(viewcontroller != nil)
        [button addTarget:viewcontroller action:action forControlEvents:UIControlEventTouchUpInside];
    [superview addSubview:button];
    
    return button;
}

+(UIImageView *)imageviewAddsuperview_superView:(UIView *)superview _subViewFrame:(CGRect)rect _imageName:(NSString *)image _backgroundColor:(UIColor *)color
{
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:rect];
    if(image != nil && image.length>0)
        imageview.image = [UIImage imageNamed:image];
    else if(color != nil)
        imageview.backgroundColor = color;
    [superview addSubview:imageview];
    
    return imageview;
}

+(UITextField *)textFieldAddSuperview_superView:(UIView *)superview
                                  _subViewFrame:(CGRect)rect
                                        _placeT:(NSString *)placeholder
                               _backgroundImage:(UIImage *)background
                                      _delegate:(id)delegate
                                      andSecure:(BOOL)ture
                             andBackGroundColor:(UIColor *)color
{
    UITextField * textfield = [[UITextField alloc] initWithFrame:rect];
    if (placeholder != nil) {
        textfield.placeholder = placeholder;
    }
    if (background != nil) {
        textfield.background = background;
    }
    textfield.delegate = delegate;
    textfield.secureTextEntry = ture;
    textfield.backgroundColor = color;
    textfield.font=TitleSize;
    [superview addSubview:textfield];
    return textfield;
}
+(UITextField *)textFieldWithLeftViewAddSuperview_superView:(UIView *)superview
                                  _subViewFrame:(CGRect)rect
                                        _placeT:(NSString *)placeholder
                               _backgroundImage:(UIImage *)background
                                      _delegate:(id)delegate
                                      andSecure:(BOOL)ture
                             andBackGroundColor:(UIColor *)color
{
    UITextField * textfield = [[UITextField alloc] initWithFrame:rect];
    if (placeholder != nil){
        textfield.placeholder = placeholder;
    }
    if (background != nil){
        textfield.background = background;
    }
    textfield.delegate = delegate;
    textfield.secureTextEntry = ture;
    textfield.backgroundColor = color;
    textfield.font=TitleSize;
    textfield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [superview addSubview:textfield];
    return textfield;
}


+(UIView *)backviewAddview_subViewFrame:(CGRect)rect _viewColor:(UIColor *)color
{
    UIView *subview = [[UIView alloc]initWithFrame:rect];
    subview.backgroundColor = color;
    
    return subview;
}



/*
 * 常用信用卡卡号规则
 * Issuer Identifier  Card Number                            Length
 * Diner's Club       300xxx-305xxx, 3095xx, 36xxxx, 38xxxx  14
 * American Express   34xxxx, 37xxxx                         15
 * VISA               4xxxxx                                 13, 16
 * MasterCard         51xxxx-55xxxx                          16
 * JCB                3528xx-358xxx                          16
 * Discover           6011xx                                 16
 * 银联                622126-622925                          16
 *
 * 信用卡号验证基本算法：
 * 偶数位卡号奇数位上数字*2，奇数位卡号偶数位上数字*2。
 * 大于10的位数减9。
 * 全部数字加起来。
 * 结果不是10的倍数的卡号非法。
 * prefrences link:http://www.truevue.org/licai/credit-card-no
 *
 */
+ (BOOL)isValidCreditNumber:(NSString*)value
{
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

BOOL isNumber (char ch)
{
    if (!(ch >= '0' && ch <= '9')) {
        return FALSE;
    }
    return TRUE;
}

+ (BOOL) isValidNumber:(NSString*)value{
    const char *cvalue = [value UTF8String];
    int len = strlen(cvalue);
    for (int i = 0; i < len; i++) {
        if(!isNumber(cvalue[i])){
            return FALSE;
        }
    }
    return TRUE;
}

//身份证验证
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
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
    
    if (![Unity areaCode:sProvince]) {
        
        return NO;
        
    }
    
    //判断年月日是否有效
    
    
    
    //年份
    
    int strYear = [[Unity getStringWithRange:carid Value1:6 Value2:4] intValue];
    
    //月份
    
    int strMonth = [[Unity getStringWithRange:carid Value1:10 Value2:2] intValue];
    
    //日
    
    int strDay = [[Unity getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    
    
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

+ (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger )value2;

{
    return [str substringWithRange:NSMakeRange(value1,value2)];
}



/**
 
 * 功能:判断是否在地区码内
 
 * 参数:地区码
 
 */

+ (BOOL)areaCode:(NSString *)code

{
    
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



//截取图片，链接URL，下载缩率图
+ (NSString *)stringFormatter:(NSString *)phoneString {
    NSString *str1 = [phoneString substringToIndex:14];
    NSString *str2 = [phoneString substringFromIndex:14];
    
    return [NSString stringWithFormat:@"%@%@%@",str1,@"slt-",str2];
}


//判断是否是键盘图片
+ (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}
//字符串转换成字典
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
//字符串转换成数组
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//判断麦克风是否可用
+ (BOOL)canRecordMicrophone
{
    return nil;
}
+ (NSString*)kCCEncrypt:(NSString*)plainText password:(NSString*)pwd{
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
    return hexStr;
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

+ (NSString *)stringFromHexString:(NSString *)hexString{ //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString;
}
+ (NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString); return result ;
}
+ (NSString *)keyString{//截取字符串后八位
    NSString * str=[self uuid];
    NSArray * array=[str componentsSeparatedByString:@"-"];
    if (array[4]==nil) {
        return nil;
    }
    return [array[4] substringToIndex:8];
}
+ (NSArray *)divisionStr:(NSString *)string{//分割字符串
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
+ (NSString *)encryptionJsonString:(NSString *)string{//加密数据
    NSString * str = [Unity keyString];
    NSArray * arr=[Unity divisionStr:str];
    NSMutableArray * arr1=[NSMutableArray arrayWithArray:arr];
    [arr1 insertObject:[Unity kCCEncrypt:string password:str] atIndex:1];
    NSString * json=[arr1 componentsJoinedByString:@""];
    [arr1 insertObject:[json md5] atIndex:3];
    return [arr1 componentsJoinedByString:@"|"];
}
+ (NSString *)decryptJsonString:(NSString *)string{//解密方法
    NSArray * arr=[string componentsSeparatedByString:@"|"];
    NSMutableArray * arr1=[NSMutableArray arrayWithArray:arr];
    if (arr1.count>=4) {
        NSString * lastStr=arr1[3];
        NSString * str0=arr1[0];
        NSString * str1=arr1[1];
        NSString * str2=arr1[2];
        [arr1 removeLastObject];
        if ([[[arr1 componentsJoinedByString:@""] md5] isEqualToString:[lastStr lowercaseString]]) {
            NSMutableArray  * keyArr=[NSMutableArray array];
            [keyArr addObject:str0];
            [keyArr addObject:str2];
            NSString * key=[keyArr componentsJoinedByString:@""];
            NSString * result1 = [[NSString alloc] initWithData:[Unity hexToByteToNSData:key]  encoding:NSUTF8StringEncoding];
            return [Unity kCCDecrypt:str1 password:result1];
        }else{
            return @"数据不匹配";
        }
    }else{
       return  @"数据错误";
    }
    return nil;
}

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
@end
