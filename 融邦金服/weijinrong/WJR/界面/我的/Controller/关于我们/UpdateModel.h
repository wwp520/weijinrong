//
//  UpdateModel.h
//  chengzizhifu
//
//  Created by 快易 on 15/1/26.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "BaseModel.h"

@interface UpdateModel : BaseModel
@property (nonatomic,copy) NSString * downUrl;
@property (nonatomic,copy) NSString * versionNo;
@property (nonatomic,copy) NSString * updateFlag;
@property (nonatomic,copy) NSString * versionId;
@property (nonatomic,copy) NSString * updatInfo;
@end
