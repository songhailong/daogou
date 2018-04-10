//
//  DGHotBandViewController.m
//  dg_Example
//
//  Created by che on 2018/4/8.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGHotBandViewController.h"
#import "DGListModel.h"
#import "WZWebViewController.h"
#import "DGHotBandCellModel.h"
#import "DGShopViewController.h"

@interface DGHotBandViewController ()

@end

@implementation DGHotBandViewController


static NSString * const headerClass = @"WZHomeHeaderCollectionReusableView";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"热卖品牌";
   [self headerRefreshing];
}

-(void)headerRefreshing{
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    NSString *imei=[[UIDevice currentDevice] identifierForVendor].UUIDString;
    param[@"imei"]=imei;
    param[@"type"]=@"IOS";
    NSString *signString = [self signStringSearch:param];
    param[@"token"] = [signString md5String];
    
    
    [WZRequest GET:yhqbrandgetaction parameters:param headerFields:nil completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
        [self loadFinished];
        [self.collectionView.mj_header endRefreshing];
        if (json!=nil) {
            NSMutableArray *data =[[NSMutableArray alloc] init];
            NSMutableArray *servers = [DGHotBandCellModel parseArray:json[@"brands"]];
            WZCollectionReusableModel *model = [[WZCollectionReusableModel alloc] initWithParam:headerClass headerModel:@{@"title":@"车务相关"} items:servers];
            [data addObject:model];
            
            self.dataSource=[data copy];
            [self.collectionView reloadData];
        }
    }];
    
    

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(WZwidth*0.5, WZwidth*0.25+62);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WZCollectionReusableModel *model = self.dataSource[indexPath.section];
    DGHotBandCellModel *item = (DGHotBandCellModel *)model.items[indexPath.row];
    NSURL *url = [NSURL URLWithString:item.clickUrl];
    WZWebViewController *web = [[WZWebViewController alloc] initWithURL:url];
    web.navigationItem.title=item.brandName;
//    DGShopViewController *vc = [[DGShopViewController alloc] initWidthShopId:item.brandId];
    [self.navigationController pushViewController:web animated:YES];
}

-(NSString *)signStringSearch:(NSDictionary *)dict{
    NSString *paramString=@"";
    paramString=[paramString stringByAppendingString:dict[@"imei"]];
    paramString=[paramString stringByAppendingString:apptoken];
    return paramString;
}

@end
