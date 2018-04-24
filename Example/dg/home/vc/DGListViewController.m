//
//  DGListViewController.m
//  dg_Example
//
//  Created by che on 2018/3/21.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGListViewController.h"
#import "DGListModel.h"
#import "WZWebViewController.h"
@interface DGListViewController ()
@property (nonatomic,strong) NSString *cat;

@end

@implementation DGListViewController

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

-(void)reloadPageData{
    NSDictionary *param =@{@"module":@"m1",@"pager":@(self.page).stringValue,@"cat":self.cat};
    
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
-(void)headerRefreshing{
    self.page=1;
    self.dataSource=[[baseMutableDataSource alloc] init];
    [self reloadPageData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DGListModel *model = (DGListModel *)[self.dataSource itemAtIndexPath:indexPath];
    if (model!=nil) {
//        NSURL *url = [NSURL URLWithString:model.prdtUrl];
//        WZWebViewController *web = [[WZWebViewController alloc] initWithURL:url];
//        DGDetailViewController *vc = [[DGDetailViewController alloc] initWidthId:model.prdtId];
        DGProductDetailViewController *web = [[DGProductDetailViewController alloc] initWithId:model.prdtId];
        [self.navigationController pushViewController:web animated:YES];
        
    }
    
}

@end
