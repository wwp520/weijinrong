//
//  RewardCashController.m
//  weijinrong
//
//  Created by ouda on 17/6/10.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "RewardCashController.h"
#import "CardSelectController.h"
#import "WithdrawalPassController.h"
#import "CardHeadView.h"
#import "NewGetCashController.h"
#import "NewSetModel.h"

@interface RewardCashController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UILabel * getCashLb;
@property(nonatomic,strong)UITextField * getCashTF;
@property(nonatomic,strong)UILabel * recashLb;
@property(nonatomic,strong)UIButton *getBtn;  //全部提现
@property(nonatomic,strong)UIButton * sureBtn;
@property(nonatomic,strong)CardHeadView *headView;
@property(nonatomic,strong)RewardBankListModel *bankModel;//选择的银行卡
@property(nonatomic,strong)NewSetModel * model;
@end

@implementation RewardCashController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"奖励提现";
    [self tableView];
    [self createUI];
//    [self getMoney];
}


// 获取余额
//- (void)getMoney {
//    [self showHudLoadingView:@"正在获取请稍后"];
//    [DongManager getMoney:nil success:^(id requestData) {
//        [self hiddenHudLoadingView];
//        _model = [NewSetModel decryptBecomeModel:requestData];
//        if (_model.retCode == 0) {
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
//               _recashLb.text = [NSString stringWithFormat:@"当前奖励余额:  %@元", _model.amount];
//            });
//
//        }else {
//            [self showTitle:_model.retMessage delay:1];
//        }
//    } fail:^(NSError *error) {
//        [self showNetFail];
//    }];
//}


- (void)createUI{
    //提现金额
    _getCashLb = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_tableView.frame)+40, 100, 25)];
    _getCashLb.text = @"提现金额";
    _getCashLb.textColor = [UIColor lightGrayColor];
    [self.view addSubview:_getCashLb];
    
    
    //请输入提现金额
    UIImageView * imageView=[[UIImageView  alloc]initWithFrame:CGRectMake(10, 0, 25, 25)];
    imageView.image=[UIImage  imageNamed:@"资源 72.png"];
    _getCashTF = [[UITextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_getCashLb.frame)+40, ScreenWidth-100, 40)];
    _getCashTF.borderStyle = UITextBorderStyleNone;
    _getCashTF.placeholder = @"请输入提现金额";
    _getCashTF.leftView=imageView;
    _getCashTF.userInteractionEnabled = YES;
    _getCashTF.contentMode=UIViewContentModeScaleAspectFit;
    _getCashTF.leftViewMode=UITextFieldViewModeAlways;
    _getCashTF.delegate=self;
    [self.view  addSubview:_getCashTF];
    
    //当前奖励余额
    _recashLb = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_getCashTF.frame)+40, 200, 30)];
    _recashLb.text = [NSString stringWithFormat:@"当前奖励余额:  %@元",_amount];
    [self.view addSubview:_recashLb];
    
    //全部提现
    _getBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_recashLb.frame), CGRectGetMaxY(_getCashTF.frame)+40, 80, 30)];
    [_getBtn setTitle:@"全部提现" forState:UIControlStateNormal];
    [_getBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_getBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getBtn];
    
    
    //确认提现
    _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_getBtn.frame)+80, ScreenWidth-40, 50)];
    [_sureBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _sureBtn.layer.borderWidth = 1;
    _sureBtn.layer.cornerRadius = 5;
    _sureBtn.layer.masksToBounds  = YES;
    _sureBtn.layer.borderColor = [UIColor redColor].CGColor;
    [_sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
}

//全部提现
- (void)btnClick:(UIButton *)btn{
    _getCashTF.text = _amount;
}

//确认提现
- (void)sureClick:(UIButton *)btn{
//    if (!_bankModel) {
//        [self showTitle:@"请选择银行卡" delay:1.5f];
//    }else {
//        NewGetCashController * newVC = [[NewGetCashController alloc]init];
//        newVC.money = _getCashTF.text;
//        [self.navigationController pushViewController:newVC animated:YES];
//    }
    
    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:[NSDictionary dictionaryWithObjectsAndKeys:
                    [SaveManager  getStringForKey:@"mercId"],@"mercId",
                                                   
                            _bankModel.clrMerc,@"bankCardNumber", //银行卡号
                                                   nil]];  //类型
        [KKTools encryptionJsonString:str];
    })];

    
    [DongManager SureGetMoney:oldParam success:^(id requestData) {
        BaseModel * model = [BaseModel decryptBecomeModel:requestData];
        if (model.retCode == 0) {
                if (!_bankModel) {
                    [self showTitle:@"请选择银行卡" delay:1.5f];
                }else {
                    NewGetCashController * newVC = [[NewGetCashController alloc]init];
                    newVC.money = _getCashTF.text;
                    newVC.rewardmodel = _bankModel;
                    [self.navigationController pushViewController:newVC animated:YES];
                }
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
    
}

#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @"提现至";
    
    if (_bankModel) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@(%@)",_bankModel.headquartersbank,_bankModel.shortbankcardnumber];
    }else {
        cell.detailTextLabel.text = @"请选择银行卡";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CardSelectController * cardVC = [[CardSelectController alloc]init];
    cardVC.modelBlock = ^(RewardBankListModel *model){
        // 选择的银行卡数据
        _bankModel = model;
        dispatch_async(dispatch_get_main_queue(), ^{
           [_tableView reloadData];
        });
    };
    [self.navigationController pushViewController:cardVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)setAmount:(NSString *)amount {
    _amount = amount;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 70) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.bounces = NO;
        [_tableView setLineAll];
        [_tableView setLineHide];
        [self.view  addSubview:_tableView];
    }
    return _tableView;
}





@end
