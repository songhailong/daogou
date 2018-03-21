//
//  DG99BaoyouViewController.m
//  dg_Example
//
//  Created by che on 2018/3/21.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DG99BaoyouViewController.h"
#import "DGListModel.h"
#import "WZWebViewController.h"
@interface DG99BaoyouViewController ()

@property (nonatomic,strong) NSString *cat;

@end

@implementation DG99BaoyouViewController

-(instancetype)initWithParam:(NSDictionary *)dict{
    self = [self init];
    if (self) {
        self.title=dict[@"title"];
        self.cat = dict[@"cat"];
    }
    return self;
}

-(NSArray<NSString *> *)xibNameOfCell{
    return @[@"DGHomeListTableViewCell"];
}

-(void)loadView{
    [super loadView];
    
    self.didSupportHeaderRefreshing=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
}

-(void)headerRefreshing{
    
    NSDictionary *param =@{@"module":@"m2",@"pager":@"2",@"cat":self.cat};
    
    [WZRequest GET:yhqcoupongetaction parameters:param headerFields:nil completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
        if (json!=nil) {
            NSArray *coupons = json[@"coupon"][@"coupons"];
            baseMutableDataSource *dataSource = [[baseMutableDataSource alloc] init];
            
            NSArray *array = [DGListModel parseArray:coupons];
            
            [dataSource addNewSection:@"" withItems:array];
            
            [self reloadPages:dataSource];
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DGListModel *model = (DGListModel *)[self.dataSource itemAtIndexPath:indexPath];
    if (model!=nil) {
        NSURL *url = [NSURL URLWithString:model.couponClickUrl];
        WZWebViewController *web = [[WZWebViewController alloc] initWithURL:url];
        [self.navigationController pushViewController:web animated:YES];
        
    }
    
}

@end
