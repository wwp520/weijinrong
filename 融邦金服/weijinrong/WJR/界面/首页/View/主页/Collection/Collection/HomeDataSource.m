//
//  HomeDataSource.m
//  weijinrong
//
//  Created by RY on 17/6/17.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "HomeDataSource.h"
#import "HomeSliderCell.h"
#import "HomeCell.h"
#import "HomeHeader.h"
#import "HomeFooter.h"
#import "ScanCodePayController.h"
#import "WithdrawalController.h"
#import "DoctorController.h"
#import "ShenHe.h"
#import "BaseViewController.h"
#import "UIView+Extension.h"

#import "CreditCardController.h"  
#import "WebController.h"
#import "RBJFHeaderView.h"
#import "RBJFHeader.h"


@implementation HomeDataSource

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _model.modelTypes.count - 1;;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return _model.modelTypes[section + 1].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {     //滑动的6个轮播按钮
        HomeSliderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSliderCell" forIndexPath:indexPath];
        [cell setModels:_model.modelTypes[1]];
        [cell setClick:^(NSInteger i){
            if ([self.delegate respondsToSelector:@selector(clickModelArr:model:)]) {
                [self.delegate clickModelArr:1 model:i];
            }
        }];
        return cell;
    }else {
        HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell" forIndexPath:indexPath];
        // 数据
        LoginItemModel *item = ({
            NSMutableArray<LoginItemModel *> *items = _model.modelTypes[indexPath.section + 1];
            items[indexPath.row];
        });
        // 赋值
        [cell.name setText:item.businessname];
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:item.imageurl] placeholderImage:[UIImage imageNamed:@"jiazaitu"]];
        return cell;
    }
}

//头尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    // 空
    if (indexPath.section == 1) {
        return nil;
    }
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // 头视图这个
        RBJFHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"RBJFHeader" forIndexPath:indexPath];

        [headerView location];
        /*
        [headerView setClick:^(NSInteger i) {
            // 回调点击
            if ([self.delegate   respondsToSelector:@selector(clickModelArr:model:)]) {
                [self.delegate clickModelArr:0 model:i];
            }
        }];
        if (_model) {
            headerView.model = _model;
        }
        if ([ShenHe sharedShenHe].isSh == YES) {
            headerView.scanL.constant = ScreenWidth / 2;
            headerView.icon2.alpha = 0;
            headerView.name2.alpha = 0;
            headerView.button2.alpha = 0;
        }
         */
        return headerView;
   }else  if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {    //轮播banner图
        HomeFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HomeFooter" forIndexPath:indexPath];
        footer.width = ScreenWidth;
        if (footer == nil) {
            footer = [[HomeFooter alloc] init];
        }
        if (_model && _model.ad.count != 0) {
            [footer setImageArr:({
                NSMutableArray *arrm = [[NSMutableArray alloc] init];
                for (LoginPageModel *page in _model.ad) {
                    [arrm addObject:page.picUrl];
                }
                arrm;
            }) click:^(NSInteger i) {
                if ([self.delegate respondsToSelector:@selector(clickFooter:)]) {
                    [self.delegate clickFooter:i];
                }
            }];
        }
        return footer;
    }
    return nil;
}



#pragma mark - UICollectionViewDelegate
//点击item跳转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(clickModelArr:model:)]) {
        [self.delegate clickModelArr:2 model:indexPath.row];
    }
    
}
//item高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([ShenHe sharedShenHe].isSh == NO) {
            if (ScreenHeight >= 667) {
                return CGSizeMake(ScreenWidth, 110 + 20 + 30 + 30);  //6个轮播Btn
            }else if (ScreenHeight >= 568){
                return CGSizeMake(ScreenWidth, ScreenWidth / 375.f * 130 + 20 + 30 + 10);  //6个轮
            }
        }else {
            return CGSizeMake(ScreenWidth, 0.1f);
        }
    }else {
        return CGSizeMake(ScreenWidth / 3.0, ScreenWidth / 4.0);
    }
    return CGSizeZero;
}

//头视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
   // if (section == 0) {
    //    return CGSizeMake(ScreenWidth, ScreenWidth / 3+20);
    //}
    if (section == 0) {
        return CGSizeMake(ScreenWidth, 20);
    }
    return CGSizeZero;
}

//尾视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        if (ScreenHeight >= 667) { // 苹果6
            
            return CGSizeMake(ScreenWidth, ScreenWidth / 375.f * 154);
            
        }else if (ScreenHeight >= 736){  //6Plus
            
            return CGSizeMake(ScreenWidth, ScreenWidth / 375.f * 140);
            
        }else if (ScreenHeight >= 568 ){
            
            return CGSizeMake(ScreenWidth, ScreenWidth / 375.f * 154);
        }
    }
    
    return CGSizeZero;
}

@end
