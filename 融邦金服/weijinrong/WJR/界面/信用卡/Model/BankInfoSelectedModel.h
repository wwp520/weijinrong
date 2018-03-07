//
//  BankInfoSelectedModel.h
//  weijinrong
//
//  Created by ouda on 17/5/26.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

@interface BankInfoSelectedListModel : BaseModel
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString *  bankNo;  //编号
@property(nonatomic,strong)NSString *  bankName; //银行名称
@property(nonatomic,strong)NSString *  logoUrl;  //图片
@end


@interface CardTypeListModel : BaseModel
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSString * key;
@property(nonatomic,strong)NSString * value;
@property(nonatomic,strong)NSString * desc;
@end


@interface cardLevellModel : BaseModel
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString *  type;
@property(nonatomic,strong)NSString *  key;
@property(nonatomic,strong)NSString *  value;
@property(nonatomic,strong)NSString *  desc;//description
@end


@interface BankInfoSelectedModel : BaseModel
@property(nonatomic,retain)NSArray <BankInfoSelectedListModel *>*bank;
@property(nonatomic,retain)NSArray <CardTypeListModel *>*cardType;
@property(nonatomic,retain)NSArray <cardLevellModel *>*cardLevell;
@end
