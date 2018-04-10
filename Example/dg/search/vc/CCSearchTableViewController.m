//
//  CCSearchTableViewController.m
//  che_Example
//
//  Created by 杨红磊 on 2017/12/5.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "CCSearchTableViewController.h"
#import "CCCCHotSearchCellModel.h"
#import <commonLib/MSActiveControllerFinder.h>
#import "CCHistorySearchHeaderView.h"
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import <PINCache/PINCache.h>
#import "CCSearchHeaderView.h"
#import "DGSearchViewController.h"

@interface CCSearchTableViewController ()

@property (nonatomic,strong) CCSearchHeaderView *headerV;

@property (nonatomic,strong) NSURLSessionDataTask *task;

@property (nonatomic,strong) NSArray *hotData;
@end

@implementation CCSearchTableViewController

-(void)loadView{
    [super loadView];
    
    self.didSupportHeaderRefreshing=NO;
    
    UINib *nib =[UINib nibWithNibName:@"CCHotSearchTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CCHotSearchTableViewCell"];
    
    nib =[UINib nibWithNibName:@"CCHistorySearchTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CCHistorySearchTableViewCell"];
    
    nib =[UINib nibWithNibName:@"CCSearchItemTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CCSearchItemTableViewCell"];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.fd_prefersNavigationBarHidden=YES;
    
    
    
    CCSearchHeaderView *headerV = [CCSearchHeaderView initWithXib];
    headerV.block = ^(NSInteger index) {
        [self headerRefreshing];
    };
    self.headerV=headerV;
    
    self.tableView.frame=CGRectMake(0, 62, WZwidth, WZheight-62);
    headerV.frame=CGRectMake(0, 22, WZwidth, 40);
    if(IS_IPHONEX){
        headerV.frame=CGRectMake(0, 42, WZwidth, 40);
        self.tableView.frame=CGRectMake(0, 82, WZwidth, WZheight-62);
    }
    [self.view addSubview:headerV];
}



-(void)headerRefreshing{
    
    NSString *key = @"history_car";
    self.hotData=@[@"洗衣液",@"新鲜水果",@"防晒霜",@"袜子",@"抽纸",@"坚果",@"运动鞋",@"衣架",@"手机壳",@"口红",@"内衣",@"文胸",@"丝袜"];
    
    baseMutableDataSource *datasource =[[baseMutableDataSource alloc] init];
    NSMutableArray *cellModels =[[NSMutableArray alloc] init];
    CCCCHotSearchCellModel *bigimageModel =[[CCCCHotSearchCellModel alloc] init];
    bigimageModel.hots=self.hotData;
    [cellModels addObject:bigimageModel];
    [datasource addNewSection:@"" withItems:cellModels];
    
    NSArray *historys = [[PINCache sharedCache] objectForKey:key];
    if (historys!=nil) {
        NSMutableArray *hostoryModels =[[NSMutableArray alloc] init];
        for (NSString *key in historys) {
            CCHistorySearchCellModel *hisModel =[[CCHistorySearchCellModel alloc] init];
            hisModel.historyKey=key;
            [hostoryModels addObject:hisModel];
        }
        [datasource addNewSection:@"" withItems:hostoryModels];
    }
    
    [self reloadPages:datasource];
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else{
        return 44;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return  nil;
    }else{
        CCHistorySearchHeaderView *view =[CCHistorySearchHeaderView initWithXib];
        view.block = ^{
            NSString *key = @"history_car";
            [[PINCache sharedCache] removeObjectForKey:key];
            [self headerRefreshing];
        };
        view.frame=CGRectMake(0, 0, WZwidth, 44);
        return view;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id<baseCellModelProtocal> cellModel = [self.dataSource itemAtIndexPath:indexPath];
    if ([cellModel isKindOfClass:[CCHistorySearchCellModel class]]) {
        CCHistorySearchCellModel *hisModel = (CCHistorySearchCellModel *)cellModel;
        NSString *key = hisModel.historyKey;
        DGSearchViewController *vc =[[DGSearchViewController alloc] initWidthKey:key];
        [self.navigationController pushViewController:vc animated:YES];
    }else if([cellModel isKindOfClass:[CCSearchItemCellModel class]]){
        //
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(void)updateCell{
    NSIndexPath *path =[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadData];
}





@end
