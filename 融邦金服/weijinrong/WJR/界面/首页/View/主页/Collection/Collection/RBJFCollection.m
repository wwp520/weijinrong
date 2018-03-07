//
//  RBJFCollection.m
//  weijinrong
//
//  Created by ouda on 17/6/6.
//  Copyright © 2017年 oudapay. All rights reserved.
//
#import "RBJFCollection.h"
#import "HomeCell.h"
#import "CreditCell1.h"
#import "SDCycleScrollView.h"
#import "RBJFHeader.h"
#import "RBJFHeaderView.h"

#pragma mark - 声明
@interface RBJFCollection ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) RBJFHeader *header;
@property (nonatomic, strong) RBJFHeaderView *headerView;
@end


#pragma mark - 实现
@implementation RBJFCollection
//懒加载
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"支付服务",@"金融服务",@"第三方服务"];
    }
    return _titleArray;
}

static NSString *HeaderID = @"header";
static NSString *FooterID = @"footer";

+ (instancetype)initWithFrame:(CGRect)frame {
    RBJFCollection *view = [[RBJFCollection alloc] initWithFrame:frame];
    [view collection];
    return view;
}

- (UICollectionView *)collection {
    if (!_collection) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(ScreenWidth / 3.0, ScreenWidth / 9 * 2.5);
        flow.minimumLineSpacing = 0;
        flow.minimumInteritemSpacing = 0;
        flow.headerReferenceSize = CGSizeMake(ScreenWidth, 40);
        
        
        _collection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        
        [_collection registerNib:[UINib nibWithNibName:@"CreditCell1" bundle:nil] forCellWithReuseIdentifier:@"CreditCell1"];
        [self addSubview:_collection];
        
        
        // 注册头部
        [_collection registerClass:[RBJFHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RBJFHeader"];
        [_collection registerClass:[RBJFHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RBJFHeaderView"];
    }
    return _collection;
}



#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 3;
    }else {
        return 6;
    }
}

//每个Item布局
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {    //
        CreditCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreditCell1" forIndexPath:indexPath];
        cell.icon.image = [UIImage  imageNamed:@"1.png"];
        return cell;
    }else if (indexPath.section == 1){
        CreditCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreditCell1" forIndexPath:indexPath];
        cell.icon.image = [UIImage  imageNamed:@"1.png"];
        return cell;
    }else {
        CreditCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreditCell1" forIndexPath:indexPath];
        cell.icon.image = [UIImage  imageNamed:@"1.png"];
        return cell;
    }
}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(self.frame.size.width, 220);
    }
    else {
        return CGSizeMake(self.frame.size.width, 30);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(self.frame.size.width / 2, self.frame.size.width / 2 / 2);
    }
    else {
        return CGSizeMake(self.frame.size.width / 3, self.frame.size.width / 3 / 3 * 2);
    }
}


// 返回每一组的头部或尾部视图
// 会自动的在每一组的头部和尾部加上这个视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    // 如果当前想要的是头部视图
    // UICollectionElementKindSectionHeader是一个const修饰的字符串常量,所以可以直接使用==比较
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
             RBJFHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RBJFHeaderView" forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            headerView.label.text = self.titleArray[indexPath.section];
            return headerView;
        }else{
            RBJFHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RBJFHeader" forIndexPath:indexPath];
            header.backgroundColor = [UIColor groupTableViewBackgroundColor];
            header.label.text = self.titleArray[indexPath.section];
            return header;
        }
    }
    return nil;
}



@end
