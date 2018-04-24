//
//  DGProductListTwoViewController.m
//  dg_Example
//
//  Created by che on 2018/4/19.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGProductListTwoViewController.h"
#import "DGProductListModel.h"
#import "WZWebViewController.h"
#import "DGProductDetailViewController.h"

@interface DGProductListTwoViewController ()

@property (nonatomic,strong) DGHomeBannerModel *bannerModel;

@end

@implementation DGProductListTwoViewController
static NSString * const headerClass = @"WZHomeHeaderCollectionReusableView";

-(instancetype)initWithModel:(DGHomeBannerModel *)model{
    self = [self init];
    if (self) {
        self.bannerModel=model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=self.bannerModel.bannerName;
    if ([self.bannerModel.linkShowType isEqualToString:@"one"]) {
        self.view.backgroundColor=[UIColor colorWithHexString:@"f5f5f5"];
        self.collectionView.backgroundColor=[UIColor clearColor];
    }else{
        self.collectionView.backgroundColor=[UIColor colorWithHexString:@"f5f5f5"];
        self.flowLayot.minimumLineSpacing=10;
        self.flowLayot.minimumInteritemSpacing=5;
    }
    
    self.collectionView.frame= CGRectInset(self.view.bounds, 10, 10);
   
    self.page=1;
    
    [self headerRefreshing];
}

-(void)footerRefreshing{
    self.page=self.page+1;
    [self headerRefreshing];
}

-(void)headerRefreshing{
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    param[@"module"]=self.bannerModel.linkParam;
    param[@"pager"]=@(self.page).stringValue;
    param[@"type"]=@"IOS";
    NSString *signString = [self signStringSearch:param];
    param[@"token"] = [signString md5String];
    [WZRequest GET:yhqactiongetaction parameters:param headerFields:nil completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
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
                if ([self.bannerModel.linkShowType isEqualToString:@"one"]) {
                    servers = [DGProductListOneModel parseArray:json[@"coupon"][@"coupons"]];
                }
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


-(NSString *)signStringSearch:(NSDictionary *)dict{
    NSString *paramString=@"";
    
    paramString=[paramString stringByAppendingString:dict[@"module"]];
    paramString=[paramString stringByAppendingString:dict[@"pager"]];
    paramString=[paramString stringByAppendingString:dict[@"type"]];
    paramString=[paramString stringByAppendingString:apptoken];
    
    return paramString;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.bannerModel.linkShowType isEqualToString:@"two"]) {
        return CGSizeMake(WZwidth*0.5-15, WZwidth*0.5+130);
    }else{
        return CGSizeMake(WZwidth, WZwidth*2/3.0+130);
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WZCollectionReusableModel *model = self.dataSource[indexPath.section];
    DGProductListModel *item = (DGProductListModel *)model.items[indexPath.row];
    DGProductDetailViewController *web = [[DGProductDetailViewController alloc] initWithId:item.prdtId];
    [self.navigationController pushViewController:web animated:YES];
}
@end
