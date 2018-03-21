//
//  WZCollectionViewController.m
//  TVSearch_Example
//
//  Created by che on 2018/1/19.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZCollectionViewController.h"
#import "WZCollectionReusableView.h"
#import "WZCollectionReusableModel.h"
#import "WZCollectionViewModel.h"
#import "WZCollectionViewCell.h"

#import <Masonry/Masonry.h>

@interface WZCollectionViewController ()

@property (strong,nonatomic) UIActivityIndicatorView *indicator;
@end

@implementation WZCollectionViewController

static NSString * const reuseIdentifier = @"WZCollectionViewController";

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayot];
        _collectionView.backgroundColor=[UIColor whiteColor];
        _collectionView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _collectionView.dataSource=self;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.delegate=self;
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowLayot{
    if (!_flowLayot) {
        _flowLayot= [[UICollectionViewFlowLayout alloc]init];
        _flowLayot.minimumLineSpacing=0;
        _flowLayot.minimumInteritemSpacing=0;
    }
    return _flowLayot;
}

-(void)loadView{
    [super loadView];
    [self.view addSubview:self.collectionView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消UIScrollView的自动调整特性
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:reuseIdentifier];
    
    
    self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRefreshing];
    }];
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame=CGRectMake(self.view.center.x-20, self.view.center.y-100, 40, 40);
    indicator.color=[UIColor colorWithHexString:@"0F9FFF"];
    CGAffineTransform transform = CGAffineTransformMakeScale(.7f, .7f);
    indicator.transform = transform;
    [(UIActivityIndicatorView *)indicator startAnimating];
    self.indicator=indicator;
    [self.view addSubview:indicator];
    
}

-(void)headerRefreshing{
    NSLog(@"子类实现");
}

-(void)footerRefreshing{
    NSLog(@"子类实现");
}

-(void)loadFinished{
    [self.indicator removeFromSuperview];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    WZCollectionReusableModel *model = self.dataSource[section];
    return model.items.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        WZCollectionReusableModel *model = self.dataSource[indexPath.section];
        UINib *cellNib = [UINib nibWithNibName:model.identifier bundle:nil];
        [collectionView registerNib:cellNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:model.identifier];
        
        WZCollectionReusableView *headerRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:model.identifier forIndexPath:indexPath];
        [headerRV update:model.headerModel];
        reusableView = headerRV;
    }
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WZCollectionReusableModel *model = self.dataSource[indexPath.section];
    WZCollectionViewModel *item = model.items[indexPath.row];
    
    UINib *cellNib = [UINib nibWithNibName:item.identifier bundle:nil];
    [collectionView registerNib:cellNib forCellWithReuseIdentifier:item.identifier];
    
    WZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: item.identifier forIndexPath:indexPath];
    [cell update:item];
    return cell;
}
@end
