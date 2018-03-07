//
//  TableDataSource.h
//  TableHeadChang
//
//  Created by ouda on 17/3/15.
//  Copyright © 2017年 ouda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TableDataSource : NSObject<UITableViewDataSource>

@property(nonatomic, strong) NSArray *models;

@end
