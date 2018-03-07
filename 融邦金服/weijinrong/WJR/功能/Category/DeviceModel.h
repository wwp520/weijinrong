//
//  文件名: DeviceModel.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/10
//

#import <Foundation/Foundation.h>

#pragma mark - 声明
@interface DeviceModel : NSObject

@property (nonatomic, strong) NSString *phoneModel;
@property (nonatomic, strong) NSString *sysVersionNumber;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic, strong) NSString *appBuild;

@end
