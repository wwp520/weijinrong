//
//  AFNManager.m
//  AFN3.0
//
//  Created by RY on 16/10/18.
//  Copyright © 2016年 RY. All rights reserved.
//

#import "AFNManager.h"

@implementation AFNManager
static AFHTTPSessionManager *netManager;


//================================= Https请求 =================================//
+ (AFHTTPSessionManager *)manager {
    if (netManager == nil) {
        netManager = [AFHTTPSessionManager manager];
    }
//    AFHTTPSessionManager *manager = netManager;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    manager.requestSerializer.timeoutInterval = 20.0;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    // 声明获取到的数据格式
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    manager.securityPolicy = ({
        NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"payserver" ofType:@"cer"];
        NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
        NSSet *certSet = [NSSet setWithObject:certData];
        
        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone withPinnedCertificates:certSet];
        policy.allowInvalidCertificates = YES;
        policy.validatesDomainName = NO;
        policy;
    });
    
    
    
    //客服端请求验证 重写 setSessionDidReceiveAuthenticationChallengeBlock 方法
    __weak typeof(self)weakSelf = self;
    __weak typeof(AFHTTPSessionManager *)weakManager = manager;
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *credential =nil;
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            if([weakManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if(credential) {
                    disposition =NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition =NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        } else {
            // client authentication
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            NSString *p12 = [[NSBundle mainBundle] pathForResource:@"oudapay"ofType:@"p12"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            if(![fileManager fileExistsAtPath:p12]) {
                NSLog(@"client.p12:not exist");
            }
            else {
                NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                
                if ([[weakSelf class]extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data]) {
                    SecCertificateRef certificate = NULL;
                    SecIdentityCopyCertificate(identity, &certificate);
                    const void*certs[] = {certificate};
                    CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                    credential = [NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                    disposition =NSURLSessionAuthChallengeUseCredential;
                }
            }
        }
        *_credential = credential;
        return disposition;
    }];
    
    return manager;
}

+ (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:@"ouda20161222"
                                                                  forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}



//================================= 请求方式 =================================//


// GET
+ (void)GET:(NSString *)url param:(NSDictionary *)param success:(SuccessBlock)success fail:(AFNErrorBlock)fail progress:(CurrentProgress)progress {
    // 创建请求类
    AFHTTPSessionManager *manager = [self manager];
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前数据请求的进度
        //        NSLog(@"%0.2f",downloadProgress.fractionCompleted);
        if (progress != nil) {
            progress(downloadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success != nil) {
            NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            success(responseStr);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        if (fail != nil) {
            fail(error);
        }
    }];
}

// POST
+ (void)POST:(NSString *)url param:(NSDictionary *)param success:(SuccessBlock)success fail:(AFNErrorBlock)fail progress:(CurrentProgress)progress {
    // 创建请求类
    AFHTTPSessionManager *manager = [self manager];
    [manager POST:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前数据请求的进度
        //        NSLog(@"%0.2f",downloadProgress.fractionCompleted);
        if (progress != nil) {
            progress(downloadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success != nil) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        if (fail != nil) {
            fail(error);
        }
    }];
}

// 下载
+ (void)download:(NSString *)urlStr progress:(CurrentProgress)progress success:(DownLoadBlock)success {
    // 1.创建管理者对象
    AFHTTPSessionManager *manager = [self manager];
    // 2.设置请求的URL地址
    NSURL *url = [NSURL URLWithString:urlStr];
    // 3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 4.下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载进度
        //        NSLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        progress(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 下载地址
        NSLog(@"默认下载地址%@",targetPath);
        // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
        //        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        return [NSURL fileURLWithPath:filePath]; // 返回的是文件存放在本地沙盒的地址
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 下载完成调用的方法
        success(filePath, response);
    }];
    // 5.启动下载任务
    [task resume];
}


/**
 上传文件
 
 @param param     带参数的文件
 @param urlString 文件路径
 @param files     AFNFileModel (设置文件的内容、属性)
 */
+ (void)uploadWithparam:(NSDictionary *)param UrlString:(NSString *)urlString fileArrya:(NSArray *)files successBlock:(SuccessBlock) success failBlock:(AFNErrorBlock)fail progress:(CurrentProgress)progress {
    // 创建管理者对象
    AFHTTPSessionManager *manager = [self manager];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 参数
    [manager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        for (AFNFileModel *model in files) {
            [formData appendPartWithFileData:model.fileData name:model.name fileName:model.fileName mimeType:model.mimeType];
        }
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
        //        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
        progress(1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        //请求成功
        success(responseStr);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        fail(error);
    }];
}





//================================= 请求方式 =================================//

/**
 判断网络状态
 */
+ (void)AFNetworkStatus:(void (^)(AFNetworkReachabilityStatus state))block {
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                block(AFNetworkReachabilityStatusUnknown);
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                block(AFNetworkReachabilityStatusNotReachable);
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                block(AFNetworkReachabilityStatusReachableViaWWAN);
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                block(AFNetworkReachabilityStatusReachableViaWiFi);
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
}


/*json
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if(error) {
        NSLog(@"JSON解析失败");
        return nil;
    }
    return dic;
}


/*json
 * @brief 把字典转换成字符串
 * @param jsonString JSON格式的字符串
 * @return 返回字符串
 */
+ (NSString*)URLEncryOrDecryString:(NSDictionary *)paramDict IsHead:(BOOL)_type {
    
    NSArray *keyAry =  [paramDict allKeys];
    NSString *encryString = @"";
    for (NSString *key in keyAry)
    {
        NSString *keyValue = [paramDict valueForKey:key];
        encryString = [encryString stringByAppendingFormat:@"&"];
        encryString = [encryString stringByAppendingFormat:@"%@",key];
        encryString = [encryString stringByAppendingFormat:@"="];
        encryString = [encryString stringByAppendingFormat:@"%@",keyValue];
    }
    
    return encryString;
}


@end
