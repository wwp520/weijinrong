//
//  CreditCardModel.h
//  weijinrong
//
//  Created by ouda on 17/5/18.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"


@interface CreditCardListModel : BaseModel
@property(nonatomic,strong)NSString * countCard; //办卡人数
@property(nonatomic,strong)NSString * title;//标题
@property(nonatomic,strong)NSString * body;//正文
@property(nonatomic,strong)NSString * content;//内容或url
@property(nonatomic,strong)NSString * logo;//image链接地址
@property(nonatomic,strong)NSString * bankName;//银行名称
@property(nonatomic,strong)NSString * km;//千米
@property(nonatomic,strong)NSString * shopName; //店名称

@end


@interface CreditCardModel : BaseModel
@property(nonatomic,retain)NSArray <CreditCardListModel *>*list;
@end
