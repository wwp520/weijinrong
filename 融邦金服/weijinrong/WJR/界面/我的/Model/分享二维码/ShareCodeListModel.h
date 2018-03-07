//
//  ShareCodeListModel.h
//  weijinrong
//
//  Created by RY on 17/5/24.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

//"Id":"2",
//"salerType":"1",
//"salerNo":"991090610329507",
//"profit":"0.1"

@interface ShareCodeListSubModel : BaseModel

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *salerType;
@property (nonatomic, strong) NSString *salerNo;
@property (nonatomic, strong) NSString *profit;

@end



@interface ShareCodeListModel : BaseModel

@property (nonatomic, strong) NSArray<ShareCodeListSubModel *> *list;

@end
