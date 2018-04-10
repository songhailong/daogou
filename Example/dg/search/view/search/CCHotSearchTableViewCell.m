//
//  CCHotSearchTableViewCell.m
//  che_Example
//
//  Created by 杨红磊 on 2017/12/5.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "CCHotSearchTableViewCell.h"
#import "CCCCHotSearchCellModel.h"
#import "CCHotSearchCollectionViewCell.h"
#import <commonLib/MSActiveControllerFinder.h>
#import "CCSearchTableViewController.h"
#import "CCCCHotSearchCellModel.h"

@interface CCHotSearchTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *connectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cHeight;
@property (nonatomic,assign) NSInteger cellHeight;
@property (nonatomic,strong) NSArray *hots;


@property (nonatomic,strong) CCCCHotSearchCellModel *model;
@end

@implementation CCHotSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.connectionView.delegate=self;
    self.connectionView.dataSource=self;
    self.connectionView.scrollEnabled=NO;
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
//    flowLayout.itemSize = CGSizeMake(CCwidth*0.5, CCwidth*0.5+90);
    self.connectionView.collectionViewLayout=flowLayout;
    
    UINib *nib =[UINib nibWithNibName:@"CCHotSearchCollectionViewCell" bundle:nil];
    [self.connectionView registerNib:nib forCellWithReuseIdentifier:@"CCHotSearchCollectionViewCell"];
    
}

-(void)update:(id<baseCellModelProtocal>)cellModel{
    CCCCHotSearchCellModel *model =(CCCCHotSearchCellModel *)cellModel;
    self.model=model;
    self.hots=model.hots;
    
    if (model.collectionHeight>0) {
        self.cHeight.constant=model.collectionHeight;
    }
    
    [self.connectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hots.count;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *key = self.hots[indexPath.row];
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize size = [key sizeWithAttributes:dict];
    return CGSizeMake(size.width+32, 32);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CCHotSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CCHotSearchCollectionViewCell" forIndexPath:indexPath];
    [cell update:self.hots[indexPath.row]];
    
    CGFloat height = self.connectionView.collectionViewLayout.collectionViewContentSize.height;
    if (height!=self.model.collectionHeight) {
        self.model.collectionHeight=height;
        self.model.cacheHeight=0;//重置为零 使cell高度重新计算
        MSActiveControllerFinder *finder =[MSActiveControllerFinder finder];
        CCSearchTableViewController *nav = (CCSearchTableViewController *)finder.activeTopController();
        if ([nav isKindOfClass:[CCSearchTableViewController class]]) {
            [nav updateCell];
        }
    }
    
    return cell;
}

@end
