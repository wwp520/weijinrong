//
//  文件名: FinancialController.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/5
//

#import "FinancialController.h"
#import "LoanFinTable.h"
#import "LoanFinIcon.h"
#import "LoanFinCollection.h"


#pragma mark - 声明
@interface FinancialController()
@property (nonatomic, strong) LoanFinTable *table;
@property (nonatomic, strong) LoanFinIcon *icon;
@property (nonatomic, strong) LoanFinCollection *collection;
@property (nonatomic, strong) UIScrollView *scroll;
@end

#pragma mark - 实现
@implementation FinancialController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
- (void)createUI {
    [self setNavTitle:@"理财"];
    [self scroll];
    [self table];
    [self collection];
    [self.scroll setContentSize:CGSizeMake(0, CGRectGetMaxY(_collection.frame))];
}
- (UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight )];
        [self.view addSubview:_scroll];
    }
    return _scroll;
}
- (LoanFinTable *)table {
    if (!_table) {
        _table = [LoanFinTable loadCode:({
            CGFloat height = 80 * 3 + 150;
            CGRectMake(0, 0, ScreenWidth, height);
        })];
        _table.table.tableFooterView = [self icon];
        [self.scroll addSubview:_table];
    }
    return _table;
}
- (LoanFinIcon *)icon {
    if (!_icon) {
        _icon = [LoanFinIcon loadCode:CGRectMake(0, CGRectGetMaxY(_table.frame), ScreenWidth, 150)];
        _icon.backgroundColor = [UIColor redColor];
        [_icon setImageArr:({
            @[@"http://imgsrc.baidu.com/forum/pic/item/e5ff0081cb237db138012f73.jpg",
              @"http://img02.tooopen.com/images/20140504/sy_60294738471.jpg",
              @"http://pic.58pic.com/58pic/16/62/63/97m58PICyWM_1024.jpg"];
        }) click:^(NSInteger i) {
            
        }];
    }
    return _icon;
}
- (LoanFinCollection *)collection {
    if (!_collection) {
        _collection = [LoanFinCollection loadCode:CGRectMake(0, CGRectGetMaxY(_table.frame), ScreenWidth, ScreenWidth / 3 + 50)];
        _collection.moneyCount = 3;
        [self.scroll addSubview:_collection];
    }
    return _collection;
}




@end
