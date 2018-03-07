//
//  文件名: IntegralShop.m
//  工程名: weijinrong
//
//  创建人: KK
//  创建时间: 17/4/6
//

#import "IntegralShop.h"
#import "IntegralShopCell.h"
#import "IntegralShopHead.h"

#pragma mark - 声明
@interface IntegralShop()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collection;
@end

#pragma mark - 实现
@implementation IntegralShop

#pragma mark - 初始化
// code init
+ (instancetype)loadCode:(CGRect)frame {
    IntegralShop *view = [[IntegralShop alloc] initWithFrame:frame];
    [view collection];
    return view;
}

-(void)setModel:(IntegralShopModel *)model{
    _model = model;
    [self.collection   reloadData];
}

- (UICollectionView *)collection {
    if (!_collection) {
        _collection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:({
            UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
            flow.itemSize = CGSizeMake(ScreenWidth / 5, ScreenWidth / 5 / 3 * 2);
            flow.minimumLineSpacing = 0;
            flow.minimumInteritemSpacing = 0;
            flow.headerReferenceSize = CGSizeMake(ScreenWidth, 50);
            flow;
        })];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = [UIColor whiteColor];
        [_collection registerNib:[UINib nibWithNibName:@"IntegralShopCell" bundle:nil] forCellWithReuseIdentifier:@"IntegralShopCell"];
        [_collection registerNib:[UINib nibWithNibName:@"IntegralShopHead" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IntegralShopHead"];
        [self addSubview:_collection];
    }
    return _collection;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _model.bank.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IntegralShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IntegralShopCell" forIndexPath:indexPath];
    [cell.logourl  sd_setImageWithURL:[NSURL  URLWithString:_model.bank[indexPath.row].logoUrl]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    IntegralShopHead *header = (IntegralShopHead *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IntegralShopHead" forIndexPath:indexPath];
    return header;
}


@end
