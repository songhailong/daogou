//
//  RefreshTableViewController.m
//  Pods
//
//  Created by yanghonglei on 16/7/12.
//
//

#import "RefreshTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "SBRefreshNormalHeader.h"
@interface RefreshTableViewController ()

@property (nonatomic, strong, readwrite) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic, strong, readwrite) MJRefreshFooter *refreshFooter;

@end

@implementation RefreshTableViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.didSupportHeaderRefreshing = YES;
        self.didSupportFooterRefreshing = YES;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.didSupportHeaderRefreshing = YES;
        self.didSupportFooterRefreshing = YES;
    }
    return self;
}

- (void)loadRequestModel
{
    if (_model == nil) {
        _model = [[YHLTableRequestModel alloc] init];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
    [self loadRequestModel];
    [self refreshHeader];
    //开始加载数据
    //[self headerRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self headerRefreshingWhenViewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self headerRefreshingWhenViewDidAppear:animated];
}

- (void)headerRefreshingWhenViewWillAppear:(BOOL)animated
{
    //子类自己实现
}
- (void)headerRefreshingWhenViewDidAppear:(BOOL)animated
{
    //子类自己实现
}

//- (MJRefreshHeader *)refreshHeader
//{
//    if (!_refreshHeader && self.didSupportHeaderRefreshing)
//    {
//        _refreshHeader = [self refreshHeaderOfTableView];
//        [self applyEMRefreshStyle:(MJRefreshGifHeader *)_refreshHeader];
//    }
//
//
//    __weak __typeof(self)weakSelf = self;
//    _refreshHeader.refreshingBlock = ^(){
//        if ([weakSelf respondsToSelector:@selector(headerRefreshing)]) {
//            [weakSelf headerRefreshing];
//        }
//    };
//
//    if (self.tableView.mj_header != _refreshHeader)
//    {
//        self.tableView.mj_header = _refreshHeader;
//    }
//    return _refreshHeader;
//}

- (MJRefreshHeader *)refreshHeader
{
     __weak __typeof(self)weakSelf = self;
    if (!_refreshHeader && self.didSupportHeaderRefreshing)
    {
        _refreshHeader =[SBRefreshNormalHeader headerWithRefreshingBlock:^(){
            if ([weakSelf respondsToSelector:@selector(headerRefreshing)]) {
                [weakSelf headerRefreshing];
            }
        }];
        //_refreshHeader.stateLabel.textColor = [UIColor colorWithRed:0.99 green:0.76 blue:0.2 alpha:0.5];
        [_refreshHeader setTitle:@"下拉可以刷新..." forState:MJRefreshStateIdle];
        [_refreshHeader setTitle:@"松开即可刷新..." forState:MJRefreshStatePulling];
        [_refreshHeader setTitle:@"正在玩命加载中..." forState:MJRefreshStateRefreshing];
        
        _refreshHeader.lastUpdatedTimeLabel.hidden = YES;
        _refreshHeader.automaticallyChangeAlpha = YES;
    }
    if (self.tableView.mj_header != _refreshHeader)
    {
        self.tableView.mj_header = _refreshHeader;
    }
    return _refreshHeader;
}

- (MJRefreshHeader *)refreshHeaderOfTableView
{
    __weak __typeof(self)weakSelf = self;
    
    return [MJRefreshGifHeader headerWithRefreshingBlock:^(){
       [weakSelf headerRefreshing];
    }];
}

- (void)beginHeaderRefreshing
{
    [self.refreshHeader beginRefreshing];
}

- (void)endHeaderRefreshing
{
    [self.refreshHeader endRefreshing];
}

#pragma mark footer
- (MJRefreshFooter *)refreshFooter
{
    if (!_refreshFooter && self.didSupportFooterRefreshing){
        _refreshFooter = [self refreshFooterOfTableView];
    }
    
    if (self.tableView.mj_footer != _refreshFooter) {
        self.tableView.mj_footer = _refreshFooter;
    }
    return _refreshFooter;
}


- (MJRefreshFooter *)refreshFooterOfTableView
{
    __weak __typeof(self)weakSelf = self;
    //  MJRefreshBackNormalFooter
    return  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^(){
        [weakSelf footerRefreshing];
    }];
    
}

- (void)beginFooterRefreshing
{
    [self.refreshFooter beginRefreshing];
}


- (void)endFooterRefreshing
{
    [self.refreshFooter endRefreshing];
}

- (void)setRefreshFooterStatus:(MSRefreshFooterStatus)status
{
    if (status == MSRefreshFooterStatusIdle) {
        self.refreshFooter.hidden = NO;
        [self.refreshFooter resetNoMoreData];
    }
    else if (status == MSRefreshFooterStatusNoMoreData) {
        self.refreshFooter.hidden = NO;
        [self.refreshFooter endRefreshingWithNoMoreData];
    }
    else if (status == MSRefreshFooterStatusHidden) {
        [self.refreshFooter setHidden:YES];
    }
}

- (MSRefreshFooterStatus)refreshFooterStatus
{
    if (_refreshFooter.hidden) {
        return MSRefreshFooterStatusHidden;
    }
    else if (_refreshFooter.state == MJRefreshStateNoMoreData) {
        return MSRefreshFooterStatusNoMoreData;
    }
    
    return MSRefreshFooterStatusIdle;
}

- (void)applyEMRefreshStyle:(MJRefreshGifHeader *) MJheader{
    NSString *imageName1 = [NSString stringWithFormat:@"YHLTableView.bundle/%@",@"refreshHeader_img_1"];
    NSString *imageName2 = [NSString stringWithFormat:@"YHLTableView.bundle/%@",@"refreshHeader_img_2"];
    NSString *imageName3 = [NSString stringWithFormat:@"YHLTableView.bundle/%@",@"refreshHeader_img_3"];
    
    NSArray *imageNames = @[imageName1, imageName2, imageName3];
    NSMutableArray *images = [NSMutableArray array];
    
    for (NSString *name in imageNames) {
        UIImage *img = [UIImage imageNamed:name];
        [images addObject:img];
    }
    
    [MJheader setImages:images forState:MJRefreshStateIdle];
    [MJheader setImages:images forState:MJRefreshStatePulling];
    [MJheader setImages:images forState:MJRefreshStateRefreshing];
    [MJheader setImages:images forState:MJRefreshStateWillRefresh];
    
    MJheader.stateLabel.textColor = [UIColor colorWithRed:0.99 green:0.76 blue:0.2 alpha:1];
    [MJheader setTitle:@"下拉可以刷新..." forState:MJRefreshStateIdle];
    [MJheader setTitle:@"松开即可刷新..." forState:MJRefreshStatePulling];
    [MJheader setTitle:@"正在玩命加载中..." forState:MJRefreshStateRefreshing];
    
    MJheader.lastUpdatedTimeLabel.hidden = YES;
}

- (void)headerRefreshing
{
    __weak __typeof(self)weakSelf = self;
    if (self.model.URLString && self.model.URLString.length)
    {
        [self.tableView setContentOffset:CGPointZero animated:NO];
        self.model.requestType=baseTableRequestTypeDefault;
        [self.model requestWithType:^(baseHTTPResponse *response, BOOL success) {
                             if (success) {
                                 [weakSelf responseWithModel:weakSelf.model];
                             }else{
                                 [weakSelf updateEmptyViewWithErrorCode:response.error];
                             }
                             [weakSelf updateHeaderWhenRequestFinished];
                         }];
    }
}

- (void)footerRefreshing
{
    if (self.model.canPageDown) {
        __weak __typeof(self) weakSelf = self;
        self.model.requestType=baseTableRequestTypePageDown;
        [self.model requestWithType:^(baseHTTPResponse *response, BOOL success) {
                             if (success) {
                                 [weakSelf responseWithModel:weakSelf.model];
                             }else{
                                 [weakSelf updateEmptyViewWithErrorCode:response.error];
                             }
                             [weakSelf updateFooterWhenRequestFinished];
                         }];
        
    }
    else {
        [self setRefreshFooterStatus:MSRefreshFooterStatusNoMoreData];
    }
}



/**
 * 获取第一页、下拉刷新时，不现实footer 没有更多状态
 */
- (void)updateHeaderWhenRequestFinished
{
    [self endHeaderRefreshing];
    
    if (self.model.canPageDown) {
        [self setRefreshFooterStatus:MSRefreshFooterStatusIdle];
    }
    else {
        [self setRefreshFooterStatus:MSRefreshFooterStatusHidden];
    }
}

/**
 *  翻页请求时，没有更多数据不显示footer
 */
- (void)updateFooterWhenRequestFinished
{
    [self endFooterRefreshing];
    
    if (self.model.canPageDown) {
        [self setRefreshFooterStatus:MSRefreshFooterStatusIdle];
    }
    else {
        [self setRefreshFooterStatus:MSRefreshFooterStatusNoMoreData];
        //[self setRefreshFooterStatus:MSRefreshFooterStatusHidden];
    }
}

- (void)doRefresh
{
    if (self.isViewLoaded) {
        [self headerRefreshing];
    }
}


-(void)updateEmptyViewWithErrorCode:(NSError *)error{
    if (error==nil) {
    }else if(error.code==NSURLErrorNotConnectedToInternet){
        self.emptyView.textlabel.text=@"好像断网了\n您可以连接网络后刷新重试";
        self.emptyView.iconImageView.image=[UIImage imageNamed:@"default_notnetwork"];
    }else if(error.code==NSURLErrorTimedOut){
        self.emptyView.textlabel.text=@"网络超时\n请点击页面重试";
        self.emptyView.iconImageView.image=[UIImage imageNamed:@"default_notnetwork"];
    }else{
        self.emptyView.textlabel.text=@"服务器异常\n请点击页面重试";
        self.emptyView.iconImageView.image=[UIImage imageNamed:@"default_notnetwork"];
    }
}

-(void)tapEmptyViewAction:(YHLTableEmptyView *)emptyView{
    if ([emptyView.textlabel.text containsString:@"网络超时"]||[emptyView.textlabel.text containsString:@"服务器异常"]) {
        [self headerRefreshing];
    }
}

- (void)responseWithModel:(id)model
{
    YHLTableRequestModel *homeModel = model;
    baseMutableDataSource *dataSource = nil;
    
    if (homeModel.dataSource && ![homeModel.dataSource isEmpty])
    {
        dataSource = [[baseMutableDataSource alloc] initWithDatasource:homeModel.dataSource];
    }else{
        if (homeModel.cacheKey!=nil&& ![homeModel.cacheKey isEqualToString:@""]) {
            dataSource = [[baseMutableDataSource alloc] initWithDatasource:homeModel.cacheDataSource];
        }
    }
    
    if (dataSource)
    {
        [self reloadPages:dataSource];
    }else{
        [self reloadPages:nil];
    }
}

//- (void)responseWithModelAndCacheModel:(id)model
//{
//    YHLTableRequestModel *homeModel = model;
//    baseMutableDataSource *dataSource = nil;
//    
//    if (homeModel.dataSource && ![homeModel.dataSource isEmpty])
//    {
//        dataSource = [[baseMutableDataSource alloc] initWithDatasource:homeModel.dataSource];
//    }
//    else
//    {
//        dataSource = [[baseMutableDataSource alloc] initWithDatasource:homeModel.cacheDataSource];
//    }
//    
//    if (dataSource)
//    {
//        [self reloadPages:dataSource];
//    }else{
//        [self reloadPages:nil];
//    }
//}

@end
