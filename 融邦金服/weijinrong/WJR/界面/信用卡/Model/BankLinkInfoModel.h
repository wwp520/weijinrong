//
//  BankLinkInfoModel.h
//  weijinrong
//
//  Created by ouda on 17/5/25.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

@interface BankLinkInfoListModel : BaseModel
@property(nonatomic,strong)NSString * bankNo;  //编号
@property(nonatomic,strong)NSString * bankName;//银行名称
@property(nonatomic,strong)NSString * logoUrl;//图片
@end


@interface BankLinkInfoModel : BaseModel
@property(nonatomic,retain)NSArray <BankLinkInfoListModel *>*bank;
@end
