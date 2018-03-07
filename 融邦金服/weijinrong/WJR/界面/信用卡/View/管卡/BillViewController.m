//
//  BillViewController.m
//  weijinrong
//
//  Created by ouda on 17/5/8.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "BillViewController.h"
#import "KKDateButton.h"
#import "BillViewCell.h"

@interface BillViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *redView;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)NSArray * array;
@property(nonatomic,strong)KKDateButton * btn;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView * whiteView;
@property(nonatomic,strong)UIView * line;
@end

@implementation BillViewController

//懒加载scrollView
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView  alloc]initWithFrame:CGRectMake(30, _redView.height - 40, ScreenWidth-60, (ScreenWidth-60) / 7)];
        _scrollView.backgroundColor = [UIColor  clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.contentSize = CGSizeMake(2 * ScreenWidth, 0);
        [_redView addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"账单汇总";
    [self scrollView];
    [self ceateUI];
    [self  tableView];
}

-(void)ceateUI{
    //布局
    int col=6;  //列数
    
    CGFloat x=0;
//    CGFloat y=0;
    CGFloat btnWH = (ScreenWidth-60) / 7;
    
    
    CGFloat  margin = btnWH/(col-1);
    
    for (int i=0; i<12; i++) {
//        int curCol = i % col;
        x = (margin + btnWH) * i;
        
        
        _btn = [KKDateButton initWithFrame:CGRectMake(x, 0, btnWH, btnWH)];
        _btn.backgroundColor = [UIColor whiteColor];
        _btn.userInteractionEnabled=NO;
        _btn.tag=i;
        _btn.yearStr =@"2006";
        _btn.monthStr = @"6月";
        [self.scrollView  addSubview:_btn];
        _scrollView.contentSize = CGSizeMake(CGRectGetMaxX(_btn.frame), 0);
    }
    
     _whiteView = [[UIView  alloc]initWithFrame:({
        CGFloat y = CGRectGetMaxY(_scrollView.frame) - 5;
        CGFloat height = ScreenWidth / 15 * 11 - y;
        CGRectMake(0, y, ScreenWidth, height);
    })];
    _whiteView.backgroundColor = [UIColor  whiteColor];
    [_redView addSubview:_whiteView];
    
    _line = [[UIView  alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_whiteView.frame), ScreenWidth, 1)];
    _line.backgroundColor = [UIColor  lightGrayColor];
    _line.alpha = 0.5;
    [self.view  addSubview:_line];
}


#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    BillViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle  mainBundle]loadNibNamed:@"BillViewCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark--tableView
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_line.frame), ScreenWidth, ScreenHeight-CGRectGetMaxY(_whiteView.frame)) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [self.view  addSubview:_tableView];
    }
    return _tableView;
}

@end

