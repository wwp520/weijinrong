//
//  CreditUsedViewController.m
//  weijinrong
//
//  Created by ouda on 17/5/22.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CreditUsedViewController.h"
#import "CreditCell3.h"
#import "CreditUsedCell.h"
#import "BankUsedCell.h"
#import "BankUsedView.h"
#import "CreditListBtn.h"
#import "ApplicationViewController.h"
#import "BankInfoSelectedModel.h"
#import "CardWelfareModel.h"
#import "CardLinkController.h"
#import "BankRewardModel.h"
#import "HomeBtn.h"
#import "ShareLinkController.h"
#import "CodeLinkController.h"

#define LISTBTN_TAG 99

@interface CreditUsedViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSInteger curPage;
}
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;   //下方table
@property (nonatomic, strong) BankUsedView *listTable;  //3个Btn弹出的table
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) BankInfoSelectedModel *headModel;
@property (nonatomic, strong) CardBenifitModel *tableModel;
@property(nonatomic,strong)NSMutableArray<CardBenifitListModel *> * dataArray;
@property (nonatomic,strong) NSString * weburl;
@property (nonatomic,strong) NSString * guangdaUrl;
@end

@implementation CreditUsedViewController

- (NSMutableArray<CardBenifitListModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (instancetype)init {
    if (self = [super init]) {
        _bankNo = nil;
        _cardType = nil;
        _cardLevel = nil;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    curPage = 1;
    [self setNavTitle:@"信用卡"];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self createUI];
    [self getTopCellInfo];
    [self.view bringSubviewToFront:_headerView];
    
    HomeBtn *homeBtn = [HomeBtn initWithTitle:@"分享" icon:nil];
    UIButton *btn = (UIButton *)homeBtn.customView;
    self.navigationItem.rightBarButtonItem = homeBtn;
    [btn addTarget:self action:@selector(DrawBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 是否点击具体某张卡进来的
    if (_cardTypeModel) {
        CreditListBtn *btn = [_headerView viewWithTag:LISTBTN_TAG + 1];
        btn.name.text = _cardTypeModel.key;
        _cardType = _cardTypeModel.value;
    }
}


//分享
- (void)DrawBtnClick:(UIButton *)btn{
    CodeLinkController * shareVC = [[CodeLinkController alloc]init];
    shareVC.webUrl = self.weburl;
    [self.navigationController pushViewController:shareVC animated:YES];
}


- (void)createUI {
    [self headerView];
    [self titles];
    [self listTable];
    [self tableView];
    [self setupRefresh];
}


//刷新
- (void)setupRefresh {
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerLoading)];
}
//进入刷新状态
- (void)headerRefreshing{
    curPage=1;
    [self.dataArray removeAllObjects];
    [self getTableInfo:curPage];
    [_tableView.mj_header endRefreshing];
}
//进入加载状态
- (void)footerLoading{
    curPage ++;
    [self getTableInfo:curPage];
    [_tableView.mj_footer endRefreshing];
}


// 条件筛选
- (void)getTopCellInfo {
    [self showHudLoadingView:@"正在获取。。。"];
   
    [DongManager BankInfoSelected:nil success:^(id requestData) {
        [self getTableInfo:curPage];
        // 解析
        _headModel = [BankInfoSelectedModel decryptBecomeModel:requestData];
        if (_headModel.retCode == 0) {
            _listTable.model = _headModel;
        }else {
            [self showTitle:_headModel.retMessage delay:1.5];
        }
    } fail:^(NSError *error) {
        [self getTableInfo:curPage];
    }];
}

//全部银行需要刷新
- (void)getTableInfo:(NSInteger)page {
    NSInteger cityId = [KKStaticParams sharedKKStaticParams].cityId;
    NSString *oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[SaveManager getStringForKey:@"mercId"],@"mercId",
                                     @(cityId),@"bdcitycode",
                                     @(page),@"pageNum", //当前页
                                     @"10",@"pageSize",//显示条数
                                     @"12",@"type",
                                      nil];
        if (_bankNo) {
            [dict setObject:_bankNo forKey:@"bankNo"];
            if ([_bankNo isEqualToString:@"全部银行"]) {
                _bankNo = @"bank";
            }else if([_bankNo isEqualToString:@"中信银行"]){
                _bankNo = @"zhongxin";
            }else if([_bankNo isEqualToString:@"浦发银行"]){
                _bankNo = @"pufa";
            }else if([_bankNo isEqualToString:@"兴业银行"]){
                _bankNo = @"xingye";
            }else if([_bankNo isEqualToString:@"光大银行"]){
                _bankNo = @"guangda";
            }else if([_bankNo isEqualToString:@"民生银行"]){
                _bankNo = @"minsheng";
            }
        }
        if (_cardType) {
            [dict setObject:_cardType forKey:@"remark"];
        }
        if (_cardLevel) {
            [dict setObject:_cardLevel forKey:@"cardLevel"];
        }
        
        //综合
        _weburl = [NSString stringWithFormat:@"http://223.98.189.173:8081/ouda_pms/PmsCreditInfo/bankcard.action?mobile=%@&banktype=%@&cardlevel=%@&cardtype=%@",GetAccount,_bankNo,_cardLevel,_cardType];
        
        //光大
       // _guangdaUrl = [NSString stringWithFormat:@"http://223.98.189.173:8081/ouda_pms/PmsCreditInfo/bankcard.action?mobile=%@&banktype=%@&pid=%@",GetAccount,_bankNo,];

        
        NSString *str = [KKTools dictionaryToJson:dict];  //类型
        [KKTools encryptionJsonString:str];
        
    })];
        
    
    [DongManager CardBenefit:oldParam success:^(id requestData) {
        [self hiddenHudLoadingView];
        [BaseModel decryptBecomeModel:requestData];
        
        
        //解析数据
        _tableModel = [CardBenifitModel decryptBecomeModel:requestData];
        if (_tableModel.retCode == 0) {
            [self.dataArray addObjectsFromArray:_tableModel.list];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               [_tableView reloadData];
            });
            
        }else {
            [self showTitle:_tableModel.retMessage delay:1.5];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
    
}


- (void)listBtnClick:(UIButton *)btn {
    
    
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // 列表移动
        if (_listTable.y < 0) {
            _listTable.y = CGRectGetMaxY(_headerView.frame);
            _listTable.tag = btn.tag;
        }
        else {
            if (_listTable.tag == btn.tag) {
                CGFloat height = self.tableView.height;
                _listTable.y = -(height - 64 - _headerView.height);
            }else {
                // 更改显示的数据
                NSLog(@"123");
                _listTable.tag = btn.tag;
            }
        }
        // 三角移动
        if (_listTable.y < 0) {
            for (int i=0; i<_titles.count; i++) {
                CreditListBtn *subBtn = [self.headerView viewWithTag:LISTBTN_TAG + i];
                subBtn.icon.transform = CGAffineTransformMakeRotation(0);
            }
        }
        else {
            for (int i=0; i<_titles.count; i++) {
                CreditListBtn *subBtn = [self.headerView viewWithTag:LISTBTN_TAG + i];
                subBtn.icon.transform = CGAffineTransformMakeRotation(subBtn.tag == btn.tag ? M_PI : 0);
            }
        }
    } completion:^(BOOL finished) {
        [_listTable setTag:btn.tag];
        [_listTable.tableView reloadData];
    }];
}

#pragma mark--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CreditUsedCell * cell = [CreditUsedCell loadWithTable:tableView];
    if (self.dataArray.count > indexPath.row) {
        CardBenifitListModel *model = self.dataArray[indexPath.row];
        
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage  imageNamed:@"moren.png"]];
        cell.desc.text = model.body;
        cell.number.text = [NSString  stringWithFormat:@"%@人",model.countCard];
        cell.benifitModel = model;      //立即申请
        cell.name.text = model.title;
        
        //光大
        _guangdaUrl = [NSString stringWithFormat:@"http://223.98.189.173:8081/ouda_pms/PmsCreditInfo/bankcard.action?mobile=%@&banktype=%@&pid=%@",GetAccount,_bankNo,model.id];
    
        
      //  [cell.applyBtn addTarget:self action:@selector(applyBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.shareBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

/*
//立即申请
- (void)applyBtn:(UIButton *)btn{
    CardLinkController * cardVC = [[CardLinkController alloc]init];
    cardVC.model = _bflistModel;
    cardVC.openUrl = _bflistModel.content;
    [self.navigationController pushViewController:cardVC animated:YES];
}
 */

//分享
- (void)shareBtn:(UIButton *)btn{
    CodeLinkController * VC = [[CodeLinkController alloc]init];
    VC.webUrl = self.guangdaUrl;
    [self.navigationController pushViewController:VC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

//直接跳转到相关链接
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CardLinkController * linVC = [[CardLinkController  alloc]init];
    linVC.model = self.dataArray[indexPath.row];
    linVC.openUrl = self.dataArray[indexPath.row].cardLink;
    [self.navigationController pushViewController:linVC animated:YES];
}

#pragma mark--懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:({
            CGFloat height = ScreenHeight  - _headerView.height - 10;
            CGRectMake(0, CGRectGetMaxY(_headerView.frame), ScreenWidth, height);
        }) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [_tableView setLineHide];
        [self.view  addSubview:_tableView];
    }
    return _tableView;
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
        _headerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_headerView];
    }
    return _headerView;
}
- (BankUsedView *)listTable {
    if (!_listTable) {
        _listTable = [BankUsedView loadCode:({
            CGFloat height = self.tableView.height + 10-64;
            CGFloat y = -(height  - _headerView.height);
            CGRectMake(0, y, ScreenWidth, height);
        }) click:^(NSInteger i) {
            CreditListBtn *btn = [_headerView viewWithTag:_listTable.tag];
            // 设置头视图文字
            if (_listTable.tag == LISTBTN_TAG) {
                // 银行
                btn.name.text = i == 0 ? @"全部银行" :_headModel.bank[i - 1].bankName;
                _bankNo = i == 0 ? nil : _headModel.bank[i - 1].bankName;
            }else if (_listTable.tag == LISTBTN_TAG + 1) {
                // 用途
                btn.name.text = i == 0 ? @"全部用途" :_headModel.cardType[i - 1].key;
                _cardType = i == 0 ? nil : _headModel.cardType[i - 1].value;
            }else if (_listTable.tag == LISTBTN_TAG + 2) {
                // 类型
                btn.name.text = i == 0 ? @"全部种类" :_headModel.cardLevell[i - 1].key;
                _cardLevel = i == 0 ? nil : _headModel.cardLevell[i - 1].value;
            }
            // 隐藏列表
            [self listBtnClick:({
                UIButton *btn = [UIButton new];
                btn.tag = _listTable.tag;
                btn;
            })];
            // 请求
            [self showHudLoadingView:@"正在获取。。。"];
            curPage = 1;
            [self.dataArray removeAllObjects];
            [self getTableInfo:curPage];
        }];
        _listTable.backgroundColor = [UIColor redColor];
        [self.view  addSubview:_listTable];
    }
    return _listTable;
}
- (NSMutableArray *)titles {
    if (!_titles) {
        _titles = @[@"全部银行",@"全部用途",@"全部种类"].mutableCopy;
        for (int i=0; i<_titles.count; i++) {
            CreditListBtn *btn = [CreditListBtn initWithFrame:({
                CGFloat padding = 10;
                CGFloat width = (ScreenWidth - (_titles.count + 1) * padding) / _titles.count;
                CGFloat height = 40;
                CGFloat x = i * width + (i + 1) * padding;
                CGFloat y = 10;
                CGRectMake(x, y, width, height);
            }) text:_titles[i]];
            [btn setTag:LISTBTN_TAG + i];
            btn.titleLabel.textColor = [UIColor blackColor];
            [btn addTarget:self action:@selector(listBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.headerView addSubview:btn];
        }
    }
    if (_bankNo) {
        CreditListBtn *btn = [_headerView viewWithTag:LISTBTN_TAG];
        btn.name.text = _bankNo;
    }
    if (_cardType) {
        CreditListBtn *btn = [_headerView viewWithTag:LISTBTN_TAG + 1];
        btn.name.text = _cardType;
    }
    if (_cardLevel) {
        CreditListBtn *btn = [_headerView viewWithTag:LISTBTN_TAG + 2];
        btn.name.text = _cardLevel;
    }
    return _titles;
}

@end
