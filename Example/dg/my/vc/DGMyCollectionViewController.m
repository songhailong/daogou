//
//  DGMyCollectionViewController.m
//  dg_Example
//
//  Created by che on 2018/4/24.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGMyCollectionViewController.h"
#import <PINCache/PINCache.h>
#import "DGMyCollectionCellModel.h"

@interface DGMyCollectionViewController ()

@end

@implementation DGMyCollectionViewController

-(NSArray<NSString *> *)xibNameOfCell{
    return @[@"DGMycollectionTableViewCell"];
}

-(void)loadView{
    [super loadView];
    
    self.didSupportHeaderRefreshing=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"我的收藏";
    
}

-(void)headerRefreshing{
    NSMutableArray *items = [[PINCache sharedCache] objectForKey:@"collectionProductList"];
    
    NSArray *model = [DGMyCollectionCellModel parseArray:items];
    
    baseMutableDataSource *dataSource = [baseMutableDataSource new];
    [dataSource addNewSection:@"" withItems:model];
    
    [self reloadPages:dataSource];
}
@end
