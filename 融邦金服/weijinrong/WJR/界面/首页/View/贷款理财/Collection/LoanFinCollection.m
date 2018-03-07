//
//  文件名: LoanFinCollection.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/5
//

#import "LoanFinCollection.h"
#import "LoanFinCollectionCell.h"
#import "LoanFinCollectionHead.h"

#pragma mark - 声明
@interface LoanFinCollection()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collection;
@end

#pragma mark - 实现
@implementation LoanFinCollection

#pragma mark - 初始化
// code init
+ (instancetype)loadCode:(CGRect)frame {
    LoanFinCollection *view = [[LoanFinCollection alloc] initWithFrame:frame];
    [view collection];
    return view;
}
- (UICollectionView *)collection {
    if (!_collection) {
        UICollectionViewFlowLayout *flow = ({
            UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
            flow.itemSize = CGSizeMake(ScreenWidth / 3, ScreenWidth / 3);
            flow.minimumLineSpacing = 0;
            flow.minimumInteritemSpacing = 0;
            flow.headerReferenceSize = CGSizeMake(ScreenWidth, 50);
            flow;
        });
        
        _collection = ({
            UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
            collection.delegate   = self;
            collection.dataSource = self;
            collection.backgroundColor = [UIColor whiteColor];
            collection;
        });
        [self addSubview:_collection];
        
        
        [_collection registerNib:[UINib nibWithNibName:@"LoanFinCollectionHead" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LoanFinCollectionHead"];
        [_collection registerNib:[UINib nibWithNibName:@"LoanFinCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"LoanFinCollectionCell"];
    }
    return _collection;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _moneyCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LoanFinCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LoanFinCollectionCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    LoanFinCollectionHead *header = (LoanFinCollectionHead *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LoanFinCollectionHead" forIndexPath:indexPath];
    header.name.text = @"超市";
    return header;
}


@end














