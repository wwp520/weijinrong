//
//  LoanController.m
//  chengzizhifu
//
//  Created by Mac  on 16/5/12.
//  Copyright © 2016年 ZYH. All rights reserved.
//

#import "LoanController.h"
#import "LoadCell.h"
#import "LoadModel.h"
#import "HouseLoanController.h"
#import "LifeLoanController.h"
#import "CarLoanController.h"
#import "Unity.h"
#import "UIView+Extension.h"

@interface LoanController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation LoanController

#pragma mark - 父类重写

- (void)createNavigation{
    self.navTitle= @"平安普惠";
    self.dataSource = [NSMutableArray array];
    NSArray *titles = @[@"房主类(业主贷、优房贷、宅e贷)",@"车主贷",@"寿险贷"];
    NSArray *details = @[@"额度2-15万；3-50万；30-1500万",@"额度2-15万；年龄21-55周岁",@"额度2-25万；年龄21-55岁"];
    NSArray *icons = @[@"房主类",@"车主贷",@"寿险贷"];
    
    UIColor *color1 = [UIColor colorWithRed:248/256.0 green:128/256.0 blue:45/256.0 alpha:1];
    UIColor *color2 = [UIColor colorWithRed:143/256.0 green:195/256.0 blue:31/256.0 alpha:1];
    UIColor *color3 = [UIColor colorWithRed:46/256.0 green:167/256.0 blue:224/256.0 alpha:1];
    NSArray *titleColors = @[color1, color2,color3];
    for (int i = 0; i < icons.count; i++) {
        LoadModel *model = [[LoadModel alloc]initWithIconStr:icons[i] title:titles[i] detailTitle:details[i] titleColor:titleColors[i]];
        [self.dataSource addObject:model];
    }
}

- (void)leftBtnPressed:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self showUI];
}

- (UIView *)tableHeader {
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)];
    
    //banner
    UIImageView *banner = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    banner.image = [UIImage imageNamed:@"load"];
    [headView addSubview:banner];
    
    //title
    UILabel *titlelabel = [Unity lableViewAddsuperview_superView:headView _subViewFrame:CGRectMake(0, banner.height + banner.top, banner.width, 30) _string:@" 贷款种类" _lableFont: [UIFont systemFontOfSize:14]_lableTxtColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] _textAlignment:NSTextAlignmentLeft];
    titlelabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    return headView;
}

- (void)showUI {
    self.tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableview.y = 0;
    self.tableview.height = ScreenHeight;
    self.tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"LoadCell";
    LoadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LoadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    LoadModel *model = self.dataSource[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = nil;
    switch (indexPath.row) {
        case 0:
            vc = [[HouseLoanController alloc]init];
            break;
        case 1:
            vc = [[CarLoanController alloc]init];
            break;
        case 2:
            vc = [[LifeLoanController alloc]init];
            break;
        default:
            break;
    }
    
    if (vc != nil) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
