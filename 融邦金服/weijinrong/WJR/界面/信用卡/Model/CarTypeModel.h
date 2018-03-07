//
//  CarTypeModel.h
//  weijinrong
//
//  Created by ouda on 17/6/12.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

@interface CarTypeListModel : BaseModel
@property(nonatomic,strong)NSString * id;//id
@property(nonatomic,strong)NSString * key;//卡类型名字
@property(nonatomic,strong)NSString * value;//值
@property(nonatomic,strong)NSString * desc;//图片地址
@end

@interface CarTypeModel : BaseModel
@property(nonatomic,retain)NSArray <CarTypeListModel *>*cardType;
@end
