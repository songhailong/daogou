//
//  baseMutableDataSource.h
//  Pods
//
//  Created by yang on 16/6/3.
//
//

#import "baseDataSource.h"
#import "baseCellModel.h"

@interface baseMutableDataSource : baseDataSource

/**
 *  添加一条新的section
 *
 *  @param section 标题
 *  @param items   列表内容数组
 */
- (void)addNewSection:(NSString *)section withItems:(NSArray *)items;


/**
 *  插入一条新的section
 *
 *  @param section      标题
 *  @param items        列表数据内容数组
 *  @param sectionIndex 插入的下标
 */
- (void)insertSection:(NSString *)section
                items:(NSArray *)items
       atSectionIndex:(NSUInteger)sectionIndex;


/**
 *  添加一条列表数据内容
 *
 *  @param item      列表数据内容
 *  @param indexPath 插入的下标
 */
- (void)insertItem:(id<baseCellModelProtocal>)item
         indexPath:(NSIndexPath *)indexPath;

/**
 *  删除一条列表数据内容
 *
 *  @param indexPath 插入的下标
 */
- (void)removeItem:(NSIndexPath *)indexPath;


/**
 *  删除一条section
 *
 *  @param section section
 */
- (void)removeSection:(NSUInteger)section;
- (void)removeItemsOfSection:(NSUInteger)section;


/**
 *  将列表数据内容添加到某个已存在的section后面
 *
 *  @param items   列表数据内容
 *  @param section section的下标
 */
- (void)appendItems:(NSArray *)items atSection:(NSUInteger)section;


/**
 *  根据section标题, 将列表数据内容添加到某个已存在的section后面
 *
 *  @param items 列表数据内容
 *  @param title 标题
 */
//- (void)appendItems:(NSArray *)items atSectionTitle:(NSString *)title;


/**
 *  取section下列表数据内容的个数
 *
 *  @param section section
 *
 *  @return 列表数据内容的个数
 */
//- (NSUInteger)numberOfItemsAtSection:(NSUInteger)section;

@end
