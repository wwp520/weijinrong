//
//  ZYTable2.m
//  weijinrong
//
//  Created by ouda on 2018/3/15.
//  Copyright © 2018年 oudapay. All rights reserved.
//

#import "ZYTable2.h"
#import "ZYPTCell.h"
#import "ZYWebController.h"
#import "ZYDKController.h"
//#import "LoanController.h"
#import "LoanFinController.h"

@interface ZYTable2 ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSArray *contentArray;
@property (nonatomic,strong) NSArray *iconArray;
@property (nonatomic,strong) NSArray *urlArray;
@end

@implementation ZYTable2

+ (instancetype)initWithFrame:(CGRect)frame{
    ZYTable2 *table = [[ZYTable2 alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    table.delegate = table;
    table.dataSource = table;
    table.separatorStyle = UITableViewCellSelectionStyleNone;
    table.showsVerticalScrollIndicator = NO;
    table.showsHorizontalScrollIndicator = NO;
    [table setLineHide];
    [table setLineAll];
    return table;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZYPTCell *cell = [ZYPTCell loadWithTable1:tableView];
    cell.bmgBtn.userInteractionEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.icon.image = [UIImage imageNamed:self.iconArray[indexPath.row]];
    cell.titleLb.text = self.titleArray[indexPath.row];
    cell.contentLb.text = self.contentArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) { //拍拍贷
        ZYDKController * VC = [[ZYDKController alloc]init];
        VC.navTitle = @"拍拍贷";
        VC.url = @"http://m.ppdai.com/landingcpsnew.html?regsourceid=yunshangpingtai";
        [self.viewController.navigationController pushViewController:VC animated:YES];
    }else if(indexPath.row == 1){ //马上金融
        ZYDKController * VC = [[ZYDKController alloc]init];
        VC.navTitle = @"马上金融";
        VC.url = @"http://c.msxf.com/80008068-2-1";
        [self.viewController.navigationController pushViewController:VC animated:YES];
    }else if(indexPath.row == 2){  //平安普惠
    
        /*
        ZYDKController * VC = [[ZYDKController alloc]init];
        VC.navTitle = @"平安普惠";
        VC.url = @"http://c.msxf.com/80008068-2-1";  //页面未找到,先跳链接
        [self.viewController.navigationController pushViewController:VC animated:YES];
        
            LoanController *otherVC = [[LoanController alloc]init];
            otherVC.navTitle = @"我要贷款";
            [self.viewController.navigationController pushViewController:otherVC animated:YES];
        */
    }else if(indexPath.row == 3){  //你我贷
        ZYDKController * VC = [[ZYDKController alloc]init];
        VC.navTitle = @"你我贷";
        VC.url = @"https://ka.niwodai.com/loans-mobile/?nwd_ext_aid=3000002475451772&source_id=";
        [self.viewController.navigationController pushViewController:VC animated:YES];
    }else if(indexPath.row == 4){  //学生贷
        ZYDKController * VC = [[ZYDKController alloc]init];
        VC.navTitle = @"学生贷";
        VC.url = @"https://m.nonobank.com/mxdsite/mxdwxsite/borrow.html?an_id=236";
        [self.viewController.navigationController pushViewController:VC animated:YES];
    }else{  //白领贷
        ZYDKController * VC = [[ZYDKController alloc]init];
        VC.navTitle = @"白领贷";
        VC.url = @"https://m.nonobank.com/mxdsite/landing/?isSchool=true&userStatus=whiteCollar&am_id=2360";
        [self.viewController.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark--懒加载
- (NSArray *)iconArray{
    if (!_iconArray) {
        _iconArray = @[@"paipaiLoan@2x",@"newnewLoan@2x",@"safeLoan@2x",@"money_new_day1@2x",@"money_new_day2@2x",@"money_new_day3@2x"];
    }
    return _iconArray;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"拍拍贷渠道",@"马上金融渠道",@"平安普惠渠道",@"你我贷渠道",@"学生贷渠道",@"白领贷渠道"];
    }
    return _titleArray;
}

- (NSArray *)contentArray{
    if (!_contentArray) {
        _contentArray = @[@"50起贷,门槛超低的贷款方式",@"日常消费型贷款方式",@"车贷/房贷/寿险贷,多样的贷款方式",@"申请过程简单快捷的贷款方式",@"最适合学生人群的抵款方式",@"最适合白领人群的贷款方式"];
    }
    return _contentArray;
}

-  (NSArray *)urlArray{
    if (!_urlArray) {
        _urlArray = @[@"http://m.ppdai.com/landingcpsnew.html?regsourceid=yunshangpingtai",@"http://c.msxf.com/80008068-2-1",@"",@"https://ka.niwodai.com/loans-mobile/?nwd_ext_aid=3000002475451772&source_id=",@"https://m.nonobank.com/mxdsite/mxdwxsite/borrow.html?an_id=2360",@""];
    }
    return _urlArray;
}

@end
