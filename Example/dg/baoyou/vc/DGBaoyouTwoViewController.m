//
//  DGBaoyouTwoViewController.m
//  dg_Example
//
//  Created by che on 2018/4/26.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGBaoyouTwoViewController.h"
#import "DGProductListModel.h"
#import "WZWebViewController.h"
#import "DGProductDetailViewController.h"
@interface DGBaoyouTwoViewController ()

@end

@implementation DGBaoyouTwoViewController

static NSString * const headerClass = @"WZHomeHeaderCollectionReusableView";



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"9.9包邮";

    self.collectionView.backgroundColor=[UIColor colorWithHexString:@"f5f5f5"];
    self.flowLayot.minimumLineSpacing=10;
    self.flowLayot.minimumInteritemSpacing=5;
    
    
    self.collectionView.frame= CGRectInset(self.view.bounds, 10, 10);
    
    self.page=1;
    
    [self headerRefreshing];
}

-(void)footerRefreshing{
    self.page=self.page+1;
    [self headerRefreshing];
}

-(void)headerRefreshing{
    
    NSDictionary *param =@{@"module":@"m2",@"pager":@(self.page).stringValue,@"cat":@""};
    
    [WZRequest GET:yhqcoupongetaction parameters:param headerFields:nil completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
        if (json!=nil) {
            [self loadFinished];
            NSInteger pageNum = [json[@"coupon"][@"pageNum"] integerValue];
            if (self.page<pageNum) {
                
                self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
                [self.collectionView.mj_footer endRefreshing];
            }else{
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.collectionView.mj_header endRefreshing];
            
            if (json!=nil) {
                NSMutableArray *data =[[NSMutableArray alloc] init];
                
                NSMutableArray *servers = [DGProductListModel parseArray:json[@"coupon"][@"coupons"]];
                WZCollectionReusableModel *model =  [self.dataSource firstObject];
                if (model==nil||self.page==1) {
                    model = [[WZCollectionReusableModel alloc] initWithParam:headerClass headerModel:@{@"title":@""} items:servers];
                }else{
                    NSArray *item = model.items;
                    item = [item arrayByAddingObjectsFromArray:servers];
                    model.items=item;
                }
                [data addObject:model];
                self.dataSource=[data copy];
                
                [self.collectionView reloadData];
            }
        }
    }];
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(WZwidth*0.5-15, WZwidth*0.5+130);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WZCollectionReusableModel *model = self.dataSource[indexPath.section];
    DGProductListModel *item = (DGProductListModel *)model.items[indexPath.row];
    DGProductDetailViewController *web = [[DGProductDetailViewController alloc] initWithId:item.prdtId];
    [self.navigationController pushViewController:web animated:YES];
}

@end
