//
//  DGMainViewController.m
//  dg_Example
//
//  Created by che on 2018/4/8.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGMainViewController.h"

#import "DGListModel.h"
#import <commonLib/YHLCarouselView.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "WZWebViewController.h"
#import "DG99BaoyouViewController.h"
#import "DGSpecialListViewController.h"
#import "DGListViewController.h"
#import "DGHotBandViewController.h"
#import "RankingView.h"
#import "UIView+WZXibView.h"
#import "DGTopCellView.h"
#import <MJRefresh/UIScrollView+MJRefresh.h>
#import <YHLTableView/SBRefreshNormalHeader.h>
@interface DGMainViewController ()<YHLCarouselViewDelegate>

@property (nonatomic, strong, readwrite) MJRefreshNormalHeader *refreshHeader;

@property (nonatomic,strong) NSArray *bannerData;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet YHLCarouselView *bannerView;

@property (weak, nonatomic) IBOutlet UIScrollView *rankingScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;


- (IBAction)firstClick:(id)sender;
- (IBAction)twoClick:(id)sender;
- (IBAction)threeClick:(id)sender;
- (IBAction)fourClick:(id)sender;

@end

@implementation DGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bannerView.delegate=self;
    self.bannerView.pagePosition=CarouselPositionBottomCenter;
    self.bannerView.pageControlOtherColor=[UIColor colorWithHexString:@"999999"];
    self.bannerView.pageControlCurrentColor=[UIColor colorWithHexString:@"FA4F18"];
    
    [self loadData];
    
    self.mainScrollView.mj_header = [self refreshHeader];
}

- (MJRefreshHeader *)refreshHeader
{
    __weak __typeof(self)weakSelf = self;
    if (!_refreshHeader)
    {
        _refreshHeader =[SBRefreshNormalHeader headerWithRefreshingBlock:^(){
            [weakSelf loadData];
        }];
        [_refreshHeader setTitle:@"下拉可以刷新..." forState:MJRefreshStateIdle];
        [_refreshHeader setTitle:@"松开即可刷新..." forState:MJRefreshStatePulling];
        [_refreshHeader setTitle:@"正在玩命加载中..." forState:MJRefreshStateRefreshing];
        
        _refreshHeader.lastUpdatedTimeLabel.hidden = YES;
        _refreshHeader.automaticallyChangeAlpha = YES;
    }
    return _refreshHeader;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}

-(void)loadData{
    NSMutableDictionary *param = [NSMutableDictionary new];
    NSString *imei=[[UIDevice currentDevice] identifierForVendor].UUIDString;
    param[@"imei"]=imei;
    param[@"type"]=@"IOS";
    NSString *signString = [self signStringSearch:param];
    param[@"token"] = [signString md5String];
    
    
    [WZRequest GET:yhqfirstpagergetaction parameters:param headerFields:nil completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
        [self.mainScrollView.mj_header endRefreshing];
        if (json!=nil) {
            self.bannerData=[DGHomeBannerModel parseArray:json[@"banners"]];
            [self.bannerView reloadData];
            self.bannerView.time=5;
            NSArray *rankings = [DGListModel parseArray:json[@"rankings"]];
            [self loadRanking:rankings];
            
            NSArray *tops = [DGListModel parseArray:json[@"coupon"][@"coupons"]];
            [self loadToping:tops];
            
            
        }else{
            
        }
    }];
}

#pragma mark banner
- (NSInteger)numberOfcarouselView:(YHLCarouselView *)carouselView{
    return self.bannerData.count;
}
- (UIView *)carouselView:(YHLCarouselView *)carouselView subViewForPageAtIndex:(NSInteger)index{
    UIImageView *imageView = [[UIImageView alloc] init];
    DGHomeBannerModel *model = self.bannerData[index];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:nil];
    return imageView;
}
- (void)carouselView:(YHLCarouselView *)carouselView didSelectViewAtIndex:(NSInteger)index{
    DGHomeBannerModel *model = self.bannerData[index];
    if (model!=nil) {
        NSURL *url = [NSURL URLWithString:model.clickUrl];
        WZWebViewController *web = [[WZWebViewController alloc] initWithURL:url];
        [self.navigationController pushViewController:web animated:YES];
        
    }
}


-(NSString *)signStringSearch:(NSDictionary *)dict{
    NSString *paramString=@"";
    paramString=[paramString stringByAppendingString:dict[@"imei"]];
    paramString=[paramString stringByAppendingString:apptoken];
    return paramString;
}

#pragma mark model
- (IBAction)firstClick:(id)sender {
    DG99BaoyouViewController *baoyou = [[DG99BaoyouViewController alloc] initWithParam:@{@"cat":@"",@"title":@"9.9包邮"}];
    [self.navigationController pushViewController:baoyou animated:YES];
}

- (IBAction)twoClick:(id)sender {
    DGSpecialListViewController *special = [[DGSpecialListViewController alloc] initWithParam:@{@"cat":@"",@"title":@"特价好货"}];
    [self.navigationController pushViewController:special animated:YES];
}

- (IBAction)threeClick:(id)sender {
    DGListViewController *vc = [[DGListViewController alloc] initWithParam:@{@"cat":@"c1",@"title":@"精选女装"}];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)fourClick:(id)sender {
    DGHotBandViewController *band = [[DGHotBandViewController alloc] init];
    [self.navigationController pushViewController:band animated:YES];
}

#pragma mark ranking
-(void)loadRanking:(NSArray *)array{
    NSInteger index=0;
    for (DGListModel *model in array) {
        CGRect frame =CGRectMake(index*(WZwidth*0.4), 0, WZwidth*0.4, 200);
        RankingView *rankingView = [RankingView initWithXibWithFrame:frame];
        [rankingView update:model];
        [self.rankingScrollView addSubview:rankingView];
        index++;
    }
    self.rankingScrollView.contentSize=CGSizeMake(index*(WZwidth*0.4), 200);
}
#pragma mark top
-(void)loadToping:(NSArray *)array{
    NSInteger index=0;
    for (DGListModel *model in array) {
        CGRect frame =CGRectMake(0, index*150, WZwidth-10, 150);
        DGTopCellView *rankingView = [DGTopCellView initWithXibWithFrame:frame];
        [rankingView update:model];
        [self.topScrollView addSubview:rankingView];
        index++;
    }
//    DGListModel *model = array.firstObject;
//    CGRect frame =CGRectMake(0, index*155, WZwidth, 150);
//    DGTopCellView *rankingView = [DGTopCellView initWithXibWithFrame:frame];
//    [rankingView update:model];
//    [self.topScrollView addSubview:rankingView];
//    index++;
    self.topHeight.constant=150*index;
}


@end
