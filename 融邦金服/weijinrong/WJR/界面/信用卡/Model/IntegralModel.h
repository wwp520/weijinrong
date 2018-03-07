//
//  IntegralModel.h
//  weijinrong
//
//  Created by ouda on 17/5/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

@interface IntegralListModel : BaseModel    //list集合
@property(nonatomic,copy)NSString * title;//标题
@property(nonatomic,copy)NSString * body;//正文
@property(nonatomic,copy)NSString * content;//内容或url
@property(nonatomic,copy)NSString * logo;//image链接地址
@property(nonatomic,copy)NSString * bankName;//银行名称
@property(nonatomic,copy)NSString * startTime;//开始时间
@property(nonatomic,copy)NSString * endTime;//结束时间
@property(nonatomic,copy)NSString * publishTime;//发布时间
@property(nonatomic,copy)NSString * id;
@end



@interface IntegralModel : BaseModel    //主model
@property(nonatomic,retain)NSArray <IntegralListModel *>*list;
//@property(nonatomic,retain)NSMutableArray * dataArray;
@end

