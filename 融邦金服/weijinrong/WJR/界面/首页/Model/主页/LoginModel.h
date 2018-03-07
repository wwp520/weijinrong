//
//  文件名: LoginModel.h
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/10
//

#import "BaseModel.h"

#pragma mark - 声明

// 广告
@interface LoginPageModel : BaseModel
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *noticeType;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *close;
@property (nonatomic, copy) NSString *createTime;
@end

// 功能
@interface LoginItemModel : BaseModel
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *businesscode;
@property (nonatomic, copy) NSString *businessname;
@property (nonatomic, copy) NSString *imageurl;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *extends1;
@property (nonatomic, copy) NSString *extends2;
@property (nonatomic, copy) NSString *extends3;
@property (nonatomic, copy) NSString *groupType;
@end


@interface LoginModel : BaseModel
@property (nonatomic, strong) NSString *agentNumber;
@property (nonatomic, strong) NSString *mercId;
@property (nonatomic, strong) NSString *creationName;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) NSString *mercSts;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *profitMin;
@property (nonatomic, strong) NSString *profitMax;
@property (nonatomic, strong) NSMutableArray<LoginPageModel *> *ad;
@property (nonatomic, strong) NSMutableArray<LoginItemModel *> *list;
@property (nonatomic, strong) NSArray<NSMutableArray<LoginItemModel *> *> *modelTypes;

// 修改模型存储方式
- (void)managerModelForType;

@end
