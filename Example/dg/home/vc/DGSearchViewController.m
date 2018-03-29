//
//  DGSearchViewController.m
//  dg_Example
//
//  Created by che on 2018/3/26.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGSearchViewController.h"
#import "DGListModel.h"
#import "WZWebViewController.h"
@interface DGSearchViewController ()
@property (nonatomic,strong) NSString *key;
@end

@implementation DGSearchViewController

-(instancetype)initWidthKey:(NSString *)key{
    self =[self init];
    if (self) {
        self.key=key;
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
    if (self.key!=nil) {
        self.navigationItem.title=self.key;
    }
}
-(void)headerRefreshing{
    self.page=1;
    self.dataSource=[[baseMutableDataSource alloc] init];
    [self reloadPageData];
}
-(void)reloadPageData{
    if (self.key==nil) {
        self.key=@"";
    }
    NSDictionary *param =@{@"keywords":self.key,@"pager":@(self.page).stringValue};
    
    [WZRequest GET:yhqcouponsearchaction parameters:param headerFields:nil completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
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
        NSURL *url = [NSURL URLWithString:model.couponClickUrl];
        WZWebViewController *web = [[WZWebViewController alloc] initWithURL:url];
        [self.navigationController pushViewController:web animated:YES];
        
    }
    
}

@end
