//
//  RunCardModel.h
//  weijinrong
//
//  Created by ouda on 17/5/24.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

@interface RunCardListModel : BaseModel
@property(nonatomic,strong)NSString * bankName;   //银行名称
@property(nonatomic,strong)NSString * credate;     //申请时间
@property(nonatomic,strong)NSString * status;      //中间状态
@property(nonatomic,strong)NSString * status1;      //中间状态
@property(nonatomic,strong)NSString * logo;	     //图片地址
@property(nonatomic,strong)NSString * id;
@end


@interface RunCardModel : BaseModel
@property(nonatomic,retain)NSArray <RunCardListModel *>*list;
@end
