//
//  文件名: CardManualController.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/10
//

#import "CardManualController.h"
#import "CardManualCell.h"

#pragma mark - 声明
@interface CardManualController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *placeHoder;
@property(nonatomic,strong)UIButton * AddBtn;
@property(nonatomic,strong)BaseModel * model;
@end

#pragma mark - 实现
@implementation CardManualController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"手动导入"];
    [self createUI];
    [self table];
}

-(void)createUI{    //CGRectGetMaxY(_table.frame)+20
    _AddBtn = [[UIButton alloc]init];
    _AddBtn.frame = CGRectMake(0, CGRectGetMaxY(_table.frame)+20, ScreenWidth-40, 40);
    _AddBtn.layer.cornerRadius = 5;
    _AddBtn.layer.masksToBounds = YES;
    _AddBtn.backgroundColor = [UIColor  redColor];
    _AddBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _AddBtn.layer.borderWidth = 2;
    [_AddBtn  setTitle:@"确认添加" forState:UIControlStateNormal];
    [_AddBtn  addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

}

//确认添加
-(void)btnClick:(UIButton *)btn{
    [self showHudLoadingView:@"正在获取..."];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i=0; i<_names.count; i++) {
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        CardManualCell *cell = [_table cellForRowAtIndexPath:index];
        NSString *str1 = cell.desc.text;
        [arr addObject:cell.desc.text];
        NSLog(@"###################%@######################",str1);
    }

    NSString * oldParam = [NSString stringWithFormat:@"requestData=%@",({
        NSString *str = [KKTools dictionaryToJson:@{
                                @"mercId":[SaveManager  getStringForKey:@"mercId"],
                                @"cardNo":arr[0],   //银行卡后四位
                                @"bankName":arr[1],     //银行名称
                                @"name":arr[2],
                                @"billDate":arr[3],             //账单日
                                @"repaymentDate":arr[4],             //还款日
                                 @"creditLimit":arr[5],            //信用卡额度
                                 @"billAmount":arr[6],            //账单额度
                                 @"minAmount":arr[7],            //最低还款额
                                 @"integration":arr[8],
                                }];        //积分
        [KKTools encryptionJsonString:str];
    })];
    
    [DongManager  AutoAdd:oldParam success:^(id requestData) {
        [self  hiddenHudLoadingView];
        _model = [BaseModel decryptBecomeModel:requestData];
        if (_model.retCode == 0) {
            [self  showTitle:@"导入成功" delay:1];
        }
        NSLog(@"---------------------邮箱导入：%@",requestData);
    } fail:^(NSError *error) {
        [self  showNetFail];
    }];
 
}

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        [_table setLinePadding];
        [_table setLineHide];
//        self.table.tableFooterView = _AddBtn;
        [_table  setTableFooterView:_AddBtn];
        [self.view addSubview:_table];
    }
    return _table;
}
- (NSArray *)names {
    if (!_names) {
        _names = @[@"信用卡后四位",@"银行",@"姓名",
                   @"账单日",@"还款日",@"信用卡额度",
                   @"账单金额",@"最低还款额",@"积分"];
    }
    return _names;
}
- (NSArray *)placeHoder {
    if (!_placeHoder) {
        _placeHoder = @[@"----",@"招商银行",@"招商",
                        @"2.15",@"3.57",@"10000.00",
                        @"122.02",@"选填",@"选填"];
    }
    return _placeHoder;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MIN(self.names.count, self.placeHoder.count);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
//    CardManualCell *cell = [tableView cellForRowAtIndexPath:index];
//    NSString *str = cell.desc.text;
//    NSLog(@"###############################%@",str);
    
    CardManualCell *cell = [CardManualCell loadWithTable:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name.text = self.names[indexPath.row];
    cell.desc.placeholder = self.placeHoder[indexPath.row];
    cell.desc.keyboardType = [self getDescKeyboardType:indexPath.row];
    cell.desc.inputView = nil;
    return cell;
}
- (UIKeyboardType)getDescKeyboardType:(NSInteger)row {
    UIKeyboardType type;
    switch (row) {
        case 0:type = UIKeyboardTypeNumberPad;break;
        case 1:;break;
        case 2:;break;
        case 3:;break;
        case 4:;break;
        case 5:type = UIKeyboardTypeDecimalPad;break;
        case 6:type = UIKeyboardTypeDecimalPad;break;
        case 7:;break;
        case 8:;break;
    }
    return type;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.enableAutoToolbar = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    manager.enableAutoToolbar = NO;
}

@end
