//
//  CreditLinkModel.h
//  weijinrong
//
//  Created by ouda on 17/6/2.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

@interface CreditLinkListModel : BaseModel
@property(nonatomic,strong)NSString *  title;//标题
@property(nonatomic,strong)NSString *  body;//正文
@property(nonatomic,strong)NSString *  content;//内容或url
@property(nonatomic,strong)NSString *  logo;//image链接地址
@property(nonatomic,strong)NSString *  bankName;//银行名称
@property(nonatomic,strong)NSString *  startTime;//开始时间
@property(nonatomic,strong)NSString *  endTime;//结束时间
@property(nonatomic,strong)NSString *  publishTime;//发布时间
@property(nonatomic,strong)NSString *  countCard;//办卡人数
@property(nonatomic,strong)NSString *  cardLink;//办卡连接
@property(nonatomic,strong)NSString * id;
@end


@interface CreditLinkModel : BaseModel
@property (nonatomic, strong) NSArray<CreditLinkListModel *> *list;
@end
