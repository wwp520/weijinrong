//
//  BankListModel.h
//  chengzizhifu
//
//  Created by 快易 on 15/1/26.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "BaseModel.h"


@interface BankListInfoModel : BaseModel
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * bankid;
@property (nonatomic,copy) NSString * bankname;
@end

@interface BankListModel : BaseModel
@property (nonatomic,retain) NSArray<BankListInfoModel *> *list;
@property (nonatomic,retain) NSMutableArray * dataArray;
@end


