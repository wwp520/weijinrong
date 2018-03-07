//
//  HomeDataSource.h
//  weijinrong
//
//  Created by RY on 17/6/17.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 代理
@protocol HomeDataSourceDelegate <NSObject>
@required
// 点击数据中哪组数据 哪个Model
- (void)clickModelArr:(NSInteger)section model:(NSInteger)row;
// 点击那个尾视图(广告)
- (void)clickFooter:(NSInteger)row;
@end

#pragma mark - 数据整理
@interface HomeDataSource : NSObject<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) LoginModel *model;
@property (nonatomic, weak  ) BaseViewController *weakVc;
@property (nonatomic, weak  ) id<HomeDataSourceDelegate> delegate;
@end
