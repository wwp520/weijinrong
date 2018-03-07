//
//  文件名: LoginModel.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/10
//

#import "LoginModel.h"

@implementation LoginPageModel

@end

@implementation LoginItemModel

@end

@implementation LoginModel

+ (void)load {
    [LoginModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list" : @"LoginItemModel",
                 @"ad" : @"LoginPageModel"
                 };
    }];
    [LoginModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ad" : @"homePageNotice",
                 };
    }];
    [LoginItemModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 };
    }];
    [LoginPageModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 };
    }];
}
- (void)managerModelForType {
    NSMutableArray *arr1 = [[NSMutableArray alloc] init];
    NSMutableArray *arr2 = [[NSMutableArray alloc] init];
    NSMutableArray *arr3 = [[NSMutableArray alloc] init];
    for (LoginItemModel *item in self.list) {
        if ([item.groupType isEqualToString:@"0"]) {
            [arr1 addObject:item];
        }else if ([item.groupType isEqualToString:@"1"]) {
            [arr2 addObject:item];
        }else if (![item.groupType isEqualToString:@"99"]) {
            [arr3 addObject:item];
        }
    }
    _modelTypes = @[arr1,arr2,arr3];
}

@end
