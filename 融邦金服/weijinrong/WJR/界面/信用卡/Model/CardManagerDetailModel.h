//
//  CardManagerDetailModel.h
//  weijinrong
//
//  Created by ouda on 17/5/11.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

//"id":"286",
//"billId":"61",
//"merchantName":"李海波",
//"tradeDate":"04/20",
//"amount":"1.00"
@interface CardManagerBillListModel : BaseModel
@property(nonatomic,strong)NSString * id; //主键
@property(nonatomic,copy  )NSString * billId;//总金额
@property(nonatomic,copy  )NSString * merchantName;//商户名称
@property(nonatomic,copy  )NSString * tradeDate;//交易日期
@property(nonatomic,copy  )NSString * amount;//金额
@property(nonatomic,copy  )NSString * tradeType; //交易类型
@end

@interface CardManagerDetailListModel : BaseModel
@property(nonatomic,strong)NSString * billId;       //主键
@property(nonatomic,copy  )NSString * countAmount;  //总金额
@property(nonatomic,copy  )NSString * countTime;    //时间
@property(nonatomic,copy  )NSString * Date;         //日期
@property(nonatomic,copy  )NSString * annual;       //年
@property(nonatomic,assign,getter=isUnfolded)BOOL unfolded;    //是否展开
@end

@interface CardManagerDetailModel : BaseModel      //DetailsList主model
@property(nonatomic,retain)NSArray<CardManagerDetailListModel *>* DetailsList;
@property(nonatomic,strong)NSMutableArray<CardManagerBillListModel *> *BillDetailList;
@property(nonatomic,strong)NSString * creditLimit;   //额度
@property(nonatomic,strong)NSString * integration;   //积分
@property(nonatomic,strong)NSString * cardNo;
@property(nonatomic,strong)NSString * bankNo;
@property(nonatomic,strong)NSString * repaymentAmount;  //应还金额
@property(nonatomic,strong)NSString * minAmount;    //最低应还金额
@end
