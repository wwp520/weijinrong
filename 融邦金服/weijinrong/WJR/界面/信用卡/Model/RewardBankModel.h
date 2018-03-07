//
//  RewardBankModel.h
//  weijinrong
//
//  Created by ouda on 17/6/13.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BaseModel.h"

@interface RewardBankListModel : BaseModel
@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *mercId;
@property(nonatomic,strong) NSString *settlementname;
@property(nonatomic,strong) NSString *clrMerc;
@property(nonatomic,strong) NSString *bankProvince;
@property(nonatomic,strong) NSString *bankCity;
@property(nonatomic,strong) NSString *banksysnumber;
@property(nonatomic,strong) NSString *headquartersbank;
@property(nonatomic,strong) NSString *cardname;
@property(nonatomic,strong) NSString *shortbankcardnumber;
@property(nonatomic,strong) NSString *shortbankcardname;
@property(nonatomic,strong) NSString *provinceid;
@property(nonatomic,strong) NSString *cityid;
@property(nonatomic,strong) NSString *bankcode;

//              "id":25,
//            "mercId":"991090610329507",
//            "settlementname":"王卫平",
//            "clrMerc":"6214835323614527",
//            "bankProvince":"0",
//            "bankCity":"重庆,重庆市",
//            "banksysnumber":"03080000",
//            "headquartersbank":"招商银行",
//            "cardname":"银联IC普卡",
//            "shortbankcardnumber":"尾号4527",
//            "shortbankcardname":"银联IC普卡",
//            "provinceid":"4",
//            "cityid":"4",
//            "bankcode":"CMB"
@end

@interface RewardBankModel : BaseModel
@property(nonatomic,strong) NSMutableArray<RewardBankListModel *> *list;
@end
