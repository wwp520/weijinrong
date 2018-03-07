//
//  HomeSliderCell.h
//  weijinrong
//
//  Created by RY on 17/6/15.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeSliderCell : UICollectionViewCell

@property (nonatomic, copy) KKIntBlock click;
@property (nonatomic, strong) NSArray<LoginItemModel *> *models;


@end
