//
//  WZTableViewController.m
//  12123_Example
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZTableViewController.h"

@interface WZTableViewController ()

@end

@implementation WZTableViewController

-(void)loadView{
    [super loadView];
    
    self.didSupportHeaderRefreshing=YES;
    self.didSupportFooterRefreshing=YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithHexString:@"f5f5f5"];
    self.tableView.backgroundColor=[UIColor colorWithHexString:@"f5f5f5"];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
    
    if (@available(iOS 11.0, *)) {
        [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
//        [[self.webView scrollView] setContentInsetAdjustmentBehavior: UIScrollViewContentInsetAdjustmentNever];
    }
    
    [self headerRefreshing];
}

- (void)footerRefreshing{
    [self reloadPageData];
}
-(void)reloadPageData{
    
}

- (void)headerRefreshing
{
    if (_model.URLString==nil) {
        NSLog(@"_model not init");
        return;
    }
    __weak __typeof(self)weakSelf = self;
    self.model.parameter[@"currentPage"]=@1;
    self.model.parameter[@"page"]=@1;//兼容 线索列表
    if (self.model.URLString && self.model.URLString.length)
    {
        [self.tableView setContentOffset:CGPointZero animated:NO];
        self.model.requestType=baseTableRequestTypeDefault;
        [self.model requestWithType:^(baseHTTPResponse *response, BOOL success) {
            //            if (success && (![weakSelf.model.dataSource isEmpty] || weakSelf.model.cacheDataSource!=nil )) {
            if (success) {
                [weakSelf responseWithModel:weakSelf.model];
            }else{
                [weakSelf updateEmptyViewWithErrorCode:response.error];
            }
            
            [weakSelf updateHeaderWhenRequestFinished];
        }];
    }
}

-(NSInteger)page{
    if (_page==0) {
        return 1;
    }else{
        return _page;
    }
}

@end
