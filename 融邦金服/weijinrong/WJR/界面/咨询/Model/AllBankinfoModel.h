//
//  AllBankinfoModel.h
//  weijinrong
//
//  Created by ouda on 17/6/14.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

@interface AllBankinfoListModel : BaseModel
@property(nonatomic,strong)NSString *  id;
@property(nonatomic,strong)NSString *  bankNo;//银行编号
@property(nonatomic,strong)NSString *  bankName;//银行名称
@property(nonatomic,strong)NSString *  logoUrl; //图片
@end

@interface AllBankinfoModel : BaseModel
@property(nonatomic,retain)NSArray <AllBankinfoListModel *>*bank;
@end
