//
//  文件名: CreditAddController.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/7
//

#import "CreditAddController.h"
#import "CardEmailController.h"
#import "CardManualController.h"

#pragma mark - 声明
@interface CreditAddController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@end

#pragma mark - 实现
@implementation CreditAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"添加信用卡"];
    [self table];
}
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.bounces = NO;
        [_table setLineHide];
        [_table setLinePadding];
        [self.view addSubview:_table];
    }
    return _table;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
        }break;
        case 1:{
            // 邮箱导入
            CardEmailController *vc = [[CardEmailController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 2:{
            // 手动导入
            CardManualController *vc = [[CardManualController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 3:{
            
        }break;
            
        default:
            break;
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @[@"短信导入",@"邮箱导入",@"手动导入",@"网银导入"][indexPath.row];
    return cell;
}

@end
