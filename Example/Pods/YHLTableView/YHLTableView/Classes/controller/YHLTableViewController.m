//
//  baseTableViewController.m
//  Pods
//
//  Created by yangshiyu on 16/5/14.
//
//

#import "YHLTableViewController.h"
#import "baseMutableDataSource.h"
#import "baseCellModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "CellUpdating.h"

@implementation YHLTableViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
    }
    return self;
}

- (UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (YHLTableEmptyView *)emptyView{
    if (_emptyView==nil) {
        _emptyView=[[YHLTableEmptyView alloc] initWithFrame:self.view.bounds];
        [_emptyView addTarget:self action:@selector(tapEmptyViewAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _emptyView;
}

-(void)loadView{
    [super loadView];
    
    [self.view addSubview:[self tableView]];
    
    NSArray *array = [self xibNameOfCell];
    for (NSString *xibName in array) {
        UINib *nib =[UINib nibWithNibName:xibName bundle:nil];
        if (nib!=nil) {
            [self.tableView registerNib:nib forCellReuseIdentifier:xibName];
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isAutolayout=YES;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    //默认显示空视图
    [self.view addSubview:self.emptyView];
    
}



- (void)reloadPages:(baseMutableDataSource *)dataSource
{
    if ([dataSource isEmpty]||dataSource==nil) {
        [self.view addSubview:self.emptyView];
        [self.view bringSubviewToFront:self.emptyView];
        [self updateEmptyViewWithErrorCode:nil];
    }else{
        [self.emptyView removeFromSuperview];
        self.dataSource = dataSource;
        self.tableView.dataSource = dataSource;
        [self.tableView reloadData];
    }
}

- (void)setEmptyView:(YHLTableEmptyView *)emptyView
{
    _emptyView = emptyView;
}


- (BOOL)isEmptyDatasource
{
    return [self.dataSource isEmpty];
}


- (void)didReceiveMemoryWarning
{
    if ( [self isViewLoaded] && nil == self.view.window)
    {
        self.tableView=nil;
        self.emptyView=nil;
        self.view = nil;
    }
    [super didReceiveMemoryWarning];
}

#pragma mark UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [self.dataSource.items objectAtIndex:indexPath.section];
    id<baseCellModelProtocal> item = [items objectAtIndex:indexPath.row];
    CGFloat height = item.cacheHeight;
    //存在
    if (height >0) {
        return height;
    }
    //不存在
    if (self.isAutolayout) {
        height = [tableView fd_heightForCellWithIdentifier:item.reuseIdentify cacheByIndexPath:indexPath configuration:^(id cell) {
            if ([cell respondsToSelector:@selector(update:indexPath:)]) {
                [cell update:item indexPath:indexPath];
            }
            else if ([cell respondsToSelector:@selector(update:)]) {
                [cell update:item];
            }
        }];
    }else{
        if ([item respondsToSelector:@selector(calculateHeight)]) {
            height = [item calculateHeight];
        }
    }
    //加入缓存 item内容改变时 应该情况该值-----------
    item.cacheHeight=height;
    
    return height;
}

-(void)tapEmptyViewAction:(YHLTableEmptyView *)emptyView{
   //-----子类自己去实现------
    //[self reloadPages:]
}

-(void)updateEmptyViewWithErrorCode:(NSError *)error{
    //-----子类自己去实现------
}

-(NSArray<NSString *> *)xibNameOfCell{
    return nil;
}

@end
