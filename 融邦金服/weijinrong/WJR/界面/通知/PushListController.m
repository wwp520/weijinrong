//
//  PushListController.m
//  weijinrong
//
//  Created by RY on 17/6/18.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "PushListController.h"
#import "MessageListModel.h"
#import "MessageCell.h"
#import "PushController.h"

#define messageNotArrM @"messageNotArrM"

#pragma mark - 声明
@interface PushListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *models;
@end

#pragma mark - 实现
@implementation PushListController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self table];
    [self getMessageList];
    [self setNavTitle:@"通知"];
}
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        [_table setLineHide];
        [_table setLineAll];
        [self.view addSubview:_table];
    }
    return _table;
}


// 网络请求
- (void)getMessageList {
    [self showHudLoadingView:@"正在获取..."];
    [DongManager getMessageList:^(id requestData) {
        [self hiddenHudLoadingView];
        
        
        NSMutableDictionary *newData = [NSMutableDictionary dictionaryWithDictionary:[KKTools dictionaryWithJsonString:requestData]];
        NSString *requestStr = [KKTools decryptJsonString:newData[@"outParam"]];
        NSDictionary *listDict = [AFNManager dictionaryWithJsonString:requestStr];
        NSArray *list = listDict[@"list"];
        
        _models = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in list) {
            MessageListModel *model = [MessageListModel mj_objectWithKeyValues:dict];
            [_models addObject:model];
        }
        if (_models.count != 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
               [self.table reloadData];
            });
            [self saveNotiList];
        }
    } fail:^(NSError *error) {
        [self showNetFail];
    }];
}
// 保存通知消息
- (void)saveNotiList {
    // 保存数据
    NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] valueForKey:messageNotArrM];
    if (arr == nil) {
        arr = [[NSMutableArray alloc] init];
        [[NSUserDefaults standardUserDefaults] setValue:arr forKey:messageNotArrM];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [MessageCell loadWithTable:tableView];
    
    MessageListModel *model = self.models[indexPath.row];
    [cell setDataWithModel:model];
    
    NSArray *arr = [[NSUserDefaults standardUserDefaults] valueForKey:messageNotArrM];
    [cell setBoldFont:![arr containsObject:model.ID]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 设置已读
    MessageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setBoldFont:NO];
    
    // 跳转
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageListModel *model = self.models[indexPath.row];
    
    
    UserPushModel *pushModel = [[UserPushModel alloc] init];
    pushModel.body = model.platform;
    pushModel.title = model.content;
    
    PushController *detail = [[PushController alloc] init];
    detail.model = pushModel;
    detail.navTitle = @"通知";
    detail.date.text = model.time;
    [self.navigationController pushViewController:detail animated:YES];
    
    // 切换
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:messageNotArrM]];
    [arrM addObject:model.ID];
    [[NSUserDefaults standardUserDefaults] setValue:arrM forKey:messageNotArrM];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

@end

