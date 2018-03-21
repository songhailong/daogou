//
//  RefreshTableViewController.h
//  Pods
//
//  Created by yanghonglei on 16/7/12.
//
//

#import "YHLTableViewController.h"
#import <MJRefresh/MJRefresh.h>

#import "YHLTableRequestModel.h"


@protocol MSRefreshProtocol <NSObject>

@required
/**
 *  viewwillappear\viewdidappear 的时候调用，供子类调用刷新数据
 *  @param animated animated description
 */
- (void)headerRefreshingWhenViewWillAppear:(BOOL)animated;
- (void)headerRefreshingWhenViewDidAppear:(BOOL)animated;

// 自定义refresh header & footer
- (MJRefreshHeader *)refreshHeaderOfTableView;
- (MJRefreshFooter *)refreshFooterOfTableView;

@end

typedef enum : NSUInteger {
    MSRefreshFooterStatusIdle,        // 闲置状态, 等待下次上拉
    MSRefreshFooterStatusNoMoreData,  // 没有更多
    MSRefreshFooterStatusHidden,      // 隐藏
    
} MSRefreshFooterStatus;

@interface RefreshTableViewController : YHLTableViewController<MSRefreshProtocol>
{
    YHLTableRequestModel *_model;
}
@property (nonatomic, strong, readonly) YHLTableRequestModel *model;

@property (nonatomic, assign) BOOL didSupportHeaderRefreshing;// default is yes
@property (nonatomic, assign) BOOL didSupportFooterRefreshing;//default is no

@property (nonatomic, strong, readonly) MJRefreshHeader *refreshHeader;
@property (nonatomic, strong, readonly) MJRefreshFooter *refreshFooter;

/**
 * 加载model，默认是 YHLTableRequestModel
 * 子类可通过复写方法生成自定义的model
 */
- (void)loadRequestModel;


- (void)beginHeaderRefreshing; // 手动调用 下拉刷新动作 有动画
- (void)endHeaderRefreshing; // 结束刷新状态

- (void)beginFooterRefreshing; // 上拉 有动画
- (void)endFooterRefreshing;

- (void)setRefreshFooterStatus:(MSRefreshFooterStatus)status; // 设置footer状态
- (MSRefreshFooterStatus)refreshFooterStatus;


/**
 * 获取第一页、下拉刷新时，不现实footer 没有更多状态
 */
- (void)updateHeaderWhenRequestFinished;
/**
 *  翻页请求时，没有更多数据不显示footer
 */
- (void)updateFooterWhenRequestFinished;

/*
 * 请求成功 处理函数
 */
- (void)responseWithModel:(id)model;
//如果model为空 使用cacheModel
//- (void)responseWithModelAndCacheModel:(id)model;

- (void)headerRefreshing;
@end
