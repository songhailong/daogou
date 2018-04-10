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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
}
-(void)headerRefreshing{
    self.page=1;
    self.dataSource=[[baseMutableDataSource alloc] init];
    [self reloadPageData];
}
-(void)reloadPageData{
    
    NSDictionary *param =@{@"module":@"m2",@"pager":@(self.page).stringValue,@"cat":self.cat};
    
    [WZRequest GET:yhqcoupongetaction parameters:param headerFields:nil completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
        [self endHeaderRefreshing];
        [self endFooterRefreshing];
        if (json!=nil) {
            NSInteger curPage = [json[@"coupon"][@"currentPage"] integerValue];
            NSInteger pageNum = [json[@"coupon"][@"pageNum"] integerValue];
            if (curPage>0&&curPage<pageNum) {
                self.page=curPage+1;
                [self setRefreshFooterStatus:MSRefreshFooterStatusIdle];
            }else{
                [self setRefreshFooterStatus:MSRefreshFooterStatusHidden];
            }
            
            
            NSArray *coupons = json[@"coupon"][@"coupons"];
            baseMutableDataSource *dataSource = self.dataSource;
            if (dataSource==nil) {
                dataSource =  [[baseMutableDataSource alloc] init];
            }
            NSArray *array = [DGListModel parseArray:coupons];
            [dataSource appendItems:array atSection:0];
            
            [self reloadPages:dataSource];
            
            
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DGListModel *model = (DGListModel *)[self.dataSource itemAtIndexPath:indexPath];
    if (model!=nil) {
        DGDetailViewController *vc = [[DGDetailViewController alloc] initWidthId:model.prdtId];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

@end
