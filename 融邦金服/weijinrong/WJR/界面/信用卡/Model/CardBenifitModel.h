//
//  CardBenifitModel.h
//  weijinrong
//
//  Created by ouda on 17/5/23.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

@interface CardBenifitListModel : BaseModel
@property(nonatomic,strong)NSString * countCard; //办卡人数
@property(nonatomic,strong)NSString * title;//标题
@property(nonatomic,strong)NSString * body;//正文
@property(nonatomic,strong)NSString * logo;//image链接地址
@property(nonatomic,strong)NSString * bankName;  //银行名称
@property(nonatomic,strong)NSString * id;      
@property(nonatomic,strong)NSString * content;  //相关链接
@property(nonatomic,strong)NSString * cardLink; //卡链接
@property(nonatomic,strong)NSString * linkIntercept;
@property(nonatomic,strong)NSString * interceptName;
@property(nonatomic,strong)NSString * interceptPhone;
@property(nonatomic,strong)NSString * interceptIdentity;
@property(nonatomic,strong)NSString * linkEnd;//最后的页面
@property(nonatomic,strong)NSString * interceptName1;//姓名ID1
@property(nonatomic,strong)NSString * interceptIdentity1;//姓名ID2
@property(nonatomic,strong)NSString * interceptPhone1;//姓名ID3
@end


@interface CardBenifitModel : BaseModel
@property(nonatomic,retain)NSArray <CardBenifitListModel *>*list;
@end
