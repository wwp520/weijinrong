//
//  CardWelfareModel.h
//  weijinrong
//
//  Created by ouda on 17/5/18.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"


@interface CardWelfareListModel : BaseModel
@property(nonatomic,copy)NSString * title;//标题
@property(nonatomic,copy)NSString * body;//正文
@property(nonatomic,copy)NSString * content;//内容或url
@property(nonatomic,copy)NSString * countCard;//人数
@property(nonatomic,copy)NSString * logo;//image链接地址
@property(nonatomic,copy)NSString * bankName;//银行名称
@property(nonatomic,copy)NSString * startTime;//开始时间
@property(nonatomic,copy)NSString * endTime;//结束时间
@property(nonatomic,copy)NSString * publishTime;//发布时间
@property(nonatomic,copy)NSString * id;
@property(nonatomic,strong)NSString * linkIntercept;//截获地址
@property(nonatomic,strong)NSString * linkEnd;//最后的页面
@property(nonatomic,strong)NSString * interceptName;//姓名ID
@property(nonatomic,strong)NSString * interceptPhone;//手机ID
@property(nonatomic,strong)NSString * interceptIdentity;//身份证ID
@property(nonatomic,strong)NSString * interceptEnd;//最终提交ID
@property(nonatomic,strong)NSString * km;
@property(nonatomic,strong)NSString * linkUrl; //链接
@property(nonatomic,strong)NSString * shopName;
@end


@interface CardWelfareModel : BaseModel
@property(nonatomic,retain)NSArray <CardWelfareListModel *>*list;
@end
