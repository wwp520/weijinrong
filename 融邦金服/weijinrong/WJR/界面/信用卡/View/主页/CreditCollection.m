//
//  CreditCollection.m
//  weijinrong
//
//  Created by RY on 17/3/29.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "CreditCollection.h"
#import "CreditCell1.h"
#import "CreditCell2.h"
#import "CreditCell3.h"
#import "CreditCell4.h"
#import "CreditCell5.h"
#import "CreditCell6.h"
#import "CreditHeader.h"
#import "HomeFooter.h"
#import "CardWelfareController.h"
#import "IntegralController.h"
#import "CardManagerController.h"
#import "ApplicationViewController.h"
#import "LinkViewController.h"
#import "RunCardViewController.h"
#import "CreditUsedViewController.h"
#import "CardLinkController.h"
#import "CarTypeModel.h"
#import "LoadViewController.h"

#pragma mark 声明
@interface CreditCollection ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSArray * imageArray;
@end

#pragma mark 实现
@implementation CreditCollection

//图片懒加载
- (NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = @[@" 账单管理",@"进度查询",@"卡优惠",@"信用卡积分"];
    }
    return _imageArray;
}

#pragma mark 声明
+ (instancetype)initWithFrame:(CGRect)frame {
    CreditCollection *view = [[CreditCollection alloc] initWithFrame:frame];
    [view collection];
    return view;
}
- (UICollectionView *)collection {
    if (!_collection) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(ScreenWidth / 3.0, ScreenWidth / 9 * 2.5);
        flow.minimumLineSpacing = 0;
        flow.minimumInteritemSpacing = 0;
        flow.headerReferenceSize = CGSizeMake(ScreenWidth, ScreenWidth / 3);
        
        _collection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        
        [_collection registerNib:[UINib nibWithNibName:@"CreditCell1" bundle:nil] forCellWithReuseIdentifier:@"CreditCell1"];
        [_collection registerNib:[UINib nibWithNibName:@"CreditCell2" bundle:nil] forCellWithReuseIdentifier:@"CreditCell2"];
        [_collection registerNib:[UINib nibWithNibName:@"CreditCell3" bundle:nil] forCellWithReuseIdentifier:@"CreditCell3"];
        [_collection registerNib:[UINib nibWithNibName:@"CreditCell4" bundle:nil] forCellWithReuseIdentifier:@"CreditCell4"];
        [_collection registerNib:[UINib nibWithNibName:@"CreditCell5" bundle:nil] forCellWithReuseIdentifier:@"CreditCell5"];
        [_collection registerNib:[UINib nibWithNibName:@"CreditCell6" bundle:nil] forCellWithReuseIdentifier:@"CreditCell6"];
        [_collection registerNib:[UINib nibWithNibName:@"CreditHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CreditHeader"];
        [_collection registerNib:[UINib nibWithNibName:@"CreditHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CreditHeaderView"];
        [_collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
        [self addSubview:_collection];
    }
    return _collection;
}

- (void)setTypemodel:(CarTypeModel *)typemodel{
    _typemodel = typemodel;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collection reloadData];
    });
}

- (void)setModel:(CreditCardModel *)model{
    _model = model;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collection reloadData];
    });
}

- (void)setModell:(BankLinkInfoModel *)modell{
    _modell = modell;
    
 //  CreditHeader * header = [_collection dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CreditHeader" forIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
  //  header.bankNo = modell.bank[1].bankName;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collection reloadData];
    });
}

- (void)setModels:(CardBenifitModel *)models{
    _models = models;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collection reloadData];
    });
}

- (void)setListmodel:(CardBenifitListModel *)listmodel{
    _listmodel = listmodel;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collection reloadData];
    });
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 6;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.imageArray.count;
    }else if (section == 1) {
        return _modell.bank.count;
    }else if (section == 2) {
        return 1;
    }else if (section == 3) {
        return _models.list.count;
    }else if (section == 4) { //return 6
        return _typemodel.cardType.count >= 6 ? 6 : _typemodel.cardType.count;
    }else if (section == 5) {
        return _model.list.count;
    }else {
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CreditCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreditCell1" forIndexPath:indexPath];
        cell.name.text = @[@"账单管理",@"进度查询",@"卡优惠",@"信用卡积分"][indexPath.row];
        cell.icon.image = [UIImage  imageNamed:self.imageArray[indexPath.row]];
        return cell;
    }else if (indexPath.section == 1) {
        CreditCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreditCell1" forIndexPath:indexPath];
        [cell.icon sd_setImageWithURL:[NSURL  URLWithString:_modell.bank[indexPath.row].logoUrl]];
        cell.name.text = _modell.bank[indexPath.row].bankName;
        NSLog(@"+++++++++++++++%@",_modell.bank[indexPath.row].bankName);
        return cell;
    }else if (indexPath.section == 2) {
        CreditCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreditCell2" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 3) {     //精卡推荐
        CreditCell3 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreditCell3" forIndexPath:indexPath];
        [cell.logo sd_setImageWithURL:[NSURL URLWithString:_models.list[indexPath.row].logo] placeholderImage:[UIImage  imageNamed:@"moren.png"]];
        cell.titles.text = _models.list[indexPath.row].title;
        cell.body.text = _models.list[indexPath.row].body;
        cell.cardCount.text = [NSString  stringWithFormat:@"%@人",_models.list[indexPath.row].countCard];
        cell.model = _models.list[indexPath.row];
      //  [cell.applyBtn addTarget:self action:@selector(applyBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 4) {
        if (indexPath.row % 6 <= 1) {
            CreditCell4 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreditCell4" forIndexPath:indexPath];
            [cell.icon sd_setImageWithURL:[NSURL URLWithString:_typemodel.cardType[indexPath.row].desc]];
            cell.CarType.text = _typemodel.cardType[indexPath.row].key;
            return cell;
        }else {
            CreditCell5 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreditCell5" forIndexPath:indexPath];
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_typemodel.cardType[indexPath.row].desc]];
            cell.value.text = _typemodel.cardType[indexPath.row].key;
            return cell;
        }
    }else {
        CreditCell6 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreditCell6" forIndexPath:indexPath];
//        CreditCardModel * model = _model.list[indexPath.row];
        [cell.logo sd_setImageWithURL:[NSURL URLWithString:_model.list[indexPath.row].logo] placeholderImage:[UIImage  imageNamed:@"moren.png"]];
        cell.titles.text = _model.list[indexPath.row].title;
        cell.body.text  = _model.list[indexPath.row].body;
        cell.bankName.text = _model.list[indexPath.row].bankName;
        [cell.kmLb setTitle:[NSString stringWithFormat:@"%@km",_model.list[indexPath.row].km] forState:UIControlStateNormal];
        cell.storename.text = _model.list[indexPath.row].shopName;
        cell.cardmodel = _model.list[indexPath.row];
        return cell;
    }
}

- (void)applyBtn:(UIButton *)btn{
    CardLinkController *cardVC = [[CardLinkController alloc]init];
    cardVC.model = _listmodel;
    cardVC.openUrl = _listmodel.content;
    [self.viewController.navigationController pushViewController:cardVC animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    // 头视图
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            //封装头视图
            CreditHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CreditHeaderView" forIndexPath:indexPath];
            header.amount.text = _amount;
            header.sumAmount.text = _sumAmount;
            return header;
        }else{
            CreditHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CreditHeader" forIndexPath:indexPath];
            [headerView.name setText:@[@"",@"银行通道",@"推荐办卡",@"精卡推荐",@"用途卡精选",@"卡惠精选"][indexPath.section]];
            [headerView haveMorebtn:(indexPath.section == 5 || indexPath.section == 1)];
          //  headerView.bankNo = _modell.bank[indexPath.row].bankNo;
            [headerView setBtnTag:indexPath.section];
            return headerView;
        }
    }else {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        footer.backgroundColor = RGB(235, 235, 241, 1);
        return footer;
    }
    return nil;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CardManagerController *vc = [[CardManagerController alloc] init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            RunCardViewController * runVC = [[RunCardViewController  alloc]init];
            [self.viewController.navigationController pushViewController:runVC animated:YES];
        }else if (indexPath.row == 2) {
            CardWelfareController *vc = [[CardWelfareController alloc] init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 3) {
            IntegralController *vc = [[IntegralController alloc] init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 1) {
        CreditUsedViewController * creditVC = [[CreditUsedViewController  alloc]init];
        creditVC.bflistModel = self.listmodel;
        creditVC.bankNo = _modell.bank[indexPath.row].bankName;
        [self.viewController.navigationController  pushViewController:creditVC animated:YES];
    }
    if (indexPath.section == 2) {
        
        LoadViewController * loadVC = [[LoadViewController alloc]init];
        [self.viewController.navigationController pushViewController:loadVC animated:YES];
    }
    if (indexPath.section == 3) {
        
        WebController *vc = [[WebController alloc] init];
        vc.url = _models.list[indexPath.row].cardLink;
        vc.navTitle = @"精卡推荐";
        [self.viewController.navigationController pushViewController:vc animated:YES];
        
    }if (indexPath.section == 4) {
        CreditUsedViewController *creditVC = [[CreditUsedViewController  alloc]init];
        //        creditVC.cardType = _typemodel.cardType[indexPath.row].value;
        creditVC.cardTypeModel = _typemodel.cardType[indexPath.row];
        [self.viewController.navigationController pushViewController:creditVC animated:YES];
    }if (indexPath.section == 5) {
        
         CreditCardListModel *model = _model.list[indexPath.row];
        
        CardLinkController * cardVC = [[CardLinkController alloc]init];
        cardVC.openUrl = model.content;
        [self.viewController.navigationController pushViewController:cardVC animated:YES];
        
    }
    
}

#pragma mark UICollectionViewDelegateFlowLayout
// Cell尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        // 头顶四个
        return CGSizeMake(ScreenWidth / 4.0, ScreenWidth / 4.0);
    }else if (indexPath.section == 1) {
        // 展开的银行
        return CGSizeMake(ScreenWidth / 4.0, ScreenWidth / 4.0);
    }else if (indexPath.section == 2) {
        // 办卡有理
        return CGSizeMake(ScreenWidth, 100);
    }else if (indexPath.section == 3) {
        // 精卡推荐
        return CGSizeMake(ScreenWidth, 80);
    }else if (indexPath.section == 4) {
        // 用途卡精选
        if (indexPath.row % 6 <= 1) {
            return CGSizeMake(ScreenWidth / 2.0, ScreenWidth / 5.0);
        }else {
            return CGSizeMake(ScreenWidth / 4.0, ScreenWidth / 5.0);
        }
    }else if (indexPath.section == 5) {
        //
        return CGSizeMake(ScreenWidth, 80);
    }else {
        return CGSizeMake(ScreenWidth, ScreenWidth / 6.0);
    }
}
// Header尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) { //头视图高度
        return CGSizeMake(ScreenWidth, 130);
    }else if (section == 2){
        return CGSizeZero;
    }else{
        return CGSizeMake(ScreenWidth, 44);
    }
    //    return section == 0 || section == 2 ? CGSizeZero : CGSizeMake(ScreenWidth, 44);
}
// Footer尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section != 3 && section != 4) {
        return CGSizeMake(ScreenWidth, 1);
    }else if (section == 3){
        return CGSizeMake(ScreenWidth, 20);
    }else {
        return CGSizeMake(ScreenWidth, 0);
    }
}



@end
