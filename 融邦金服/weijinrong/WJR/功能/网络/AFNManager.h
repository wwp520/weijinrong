//
//  AFNManager.h
//  AFN3.0
//
//  Created by RY on 16/10/18.
//  Copyright © 2016年 RY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFNFileModel.h"



//================================== 请求回调 ==================================//
// 成功回调
typedef void (^SuccessBlock)(id requestData);
// 失败回调
typedef void (^AFNErrorBlock)(NSError * error);
// 当前下载进度
typedef void (^CurrentProgress)(double progress);
// 文件下载回调
typedef void (^DownLoadBlock)(NSURL *path, id requestData);

//================================== Block ==================================//
typedef void (^KKBlock)();
typedef void (^KKIntBlock)(NSInteger i);
typedef void (^KKStrBlock)(NSString *str);
typedef void (^KKArrBlock)(NSArray *arr);
typedef void (^KKDicBlock)(NSDictionary *dict);
typedef void (^KKDateBlock)(NSDate *date);
typedef void (^KKImageBlock)(UIImage *image);

///超时时间
//const NSTimeInterval kTimeOutInterval = 20;


@interface AFNManager : NSObject

// GET
+ (void)GET:(NSString *)url param:(NSDictionary *)param success:(SuccessBlock)success fail:(AFNErrorBlock)fail progress:(CurrentProgress)progress;

// POST
+ (void)POST:(NSString *)url param:(NSDictionary *)param success:(SuccessBlock)success fail:(AFNErrorBlock)fail progress:(CurrentProgress)progress;
// 下载
+ (void)download:(NSString *)urlStr progress:(CurrentProgress)progress success:(DownLoadBlock)success;

/**
 上传文件
 
 @param param     带参数的文件
 @param urlString 文件路径
 @param files     AFNFileModel (设置文件的内容、属性)
 */
+ (void)uploadWithparam:(NSDictionary *)param UrlString:(NSString *)urlString fileArrya:(NSArray *)files successBlock:(SuccessBlock) success failBlock:(AFNErrorBlock)fail progress:(CurrentProgress)progress;

/**
 判断网络状态
 */
+ (void)AFNetworkStatus:(void (^)(AFNetworkReachabilityStatus state))block;


/*json
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/*json
 * @brief 把字典转换成字符串
 * @param jsonString JSON格式的字符串
 * @return 返回字符串
 */
+(NSString*)URLEncryOrDecryString:(NSDictionary *)paramDict IsHead:(BOOL)_type;

@end
