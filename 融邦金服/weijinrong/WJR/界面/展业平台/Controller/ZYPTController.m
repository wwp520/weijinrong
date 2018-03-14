//
//  ZYPTController.m
//  weijinrong
//
//  Created by ouda on 2018/3/13.
//  Copyright © 2018年 oudapay. All rights reserved.
//

#import "ZYPTController.h"
#import "ZYPTView.h"
#import "AdvisoryScroll.h"
#import "ZYTable.h"

@interface ZYPTController ()
@property (nonatomic, strong) ZYPTView *zyView;
@property (nonatomic, strong) AdvisoryScroll *scroll;
@property (nonatomic, strong) ZYTable *table1;
@property (nonatomic, strong) ZYTable *table2;
@end

@implementation ZYPTController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"展业平台";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.navigationItem setTitleView:[self zyView]];
    [self scroll];
    [self table1];
    [self table2];
}

- (ZYPTView *)zyView {
    if (!_zyView) {
        _zyView = [ZYPTView initWithFrame:CGRectMake(0, 0, ScreenWidth, 44) click:^(NSInteger i) {
            [_scroll setContentOffset:CGPointMake(ScreenWidth * (i - 1), 0) animated:YES];
            if (i == 1) {
//                if (self.dataArray.count == 0) {
//                    [self headerRefreshing1];
//                }
            }else if (i == 2) {
//                if (self.dataArray2.count == 0) {
//                    [self headerRefreshing2];
//                }
            }
        }];
    }
    return _zyView;
}

- (AdvisoryScroll *)scroll {
    if (!_scroll) {
        _scroll = [AdvisoryScroll initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) click:^(NSInteger i) {
            [_zyView changeClick1:i];
            if (i == 0) {
//                if (self.dataArray.count == 0) {
//                    [self headerRefreshing1];
//                }
            }else if (i == 1) {
//                if (self.dataArray2.count == 0) {
//                    [self headerRefreshing2];
//                }
            }else if (i == 2) {
//                if (self.dataArray3.count == 0) {
//                    [self headerRefreshing3];
//                }
            }
        }];
        [_scroll setContentSize:CGSizeMake(ScreenWidth * 3, ScreenHeight - 64 - 49)];
        [_scroll setPagingEnabled:YES];
        _scroll.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scroll];
    }
    return _scroll;
}

- (ZYTable *)table1 {
    if (!_table1) {
        _table1 = [ZYTable initWithFrame:CGRectMake(0, 0, ScreenWidth, self.scroll.height)];
        [self.scroll addSubview:_table1];
    }
    return _table1;
}
- (ZYTable *)table2 {
    if (!_table2) {
        _table2 = [ZYTable initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, self.scroll.height)];
        [self.scroll addSubview:_table2];
    }
    return _table2;
}

@end
