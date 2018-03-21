//
//  baseTableViewController.h
//  Pods
//
//  Created by yangshiyu on 16/5/14.
//
//

#import "YHLViewController.h"
#import "YHLTableEmptyView.h"
@class baseMutableDataSource;

@interface YHLTableViewController : YHLViewController<UITableViewDelegate>
{
    UITableView *_tableView;
    YHLTableEmptyView *_emptyView;
}

/**
 *  是否采用layout计算cell高度
 */
@property (nonatomic, assign) BOOL isAutolayout;

/**
 *  tableview
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  数据源
 */
@property (nonatomic, strong) baseMutableDataSource *dataSource;

/**
 *  空视图, 默认会有一个空视图
 */
@property (nonatomic, strong) YHLTableEmptyView *emptyView;


/**
 *  重新加载列表界面
 *  @param dataSource 数据源
 */
- (void)reloadPages:(baseMutableDataSource *)dataSource;
/*
 * 点击页面刷新
 */
-(void)tapEmptyViewAction:(YHLTableEmptyView *)emptyView;

/*
 * 请求失败 处理函数
 */
-(void)updateEmptyViewWithErrorCode:(NSError *)error;

/*
 * cell的xib名称
 */
-(NSArray<NSString *> *)xibNameOfCell;

@end
