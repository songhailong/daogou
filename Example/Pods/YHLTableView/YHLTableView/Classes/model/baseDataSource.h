//
//  baseDataSource.h
//  Pods
//
//  Created by yang on 16/6/3.
//
//

#import <Foundation/Foundation.h>
#import "baseCellModel.h"

@interface baseDataSource : NSObject<UITableViewDataSource>{
    NSMutableArray *_sections;
    NSMutableArray *_items;
}
/**
 *  section 的数组，每个section是NSString
 */
@property (nonatomic, strong, readonly) NSArray *sections;

/**
 *  items 的数组, 每个item都是id<baseCellModelProtocal>的NSArray
 */
@property (nonatomic, strong, readonly) NSArray *items;


- (instancetype)initWithItems:(NSArray *)aItems sections:(NSArray *)aSections;

/**
 *  取section下的items
 */
- (NSArray *)itemsAtSection:(NSUInteger)section;

/**
 *  根据indexPath取某个item
 */
- (id <baseCellModelProtocal>)itemAtIndexPath:(NSIndexPath *)indexPath;


/**
 *  某个section下面items的个数
 */
- (NSUInteger)numberOfItemsAtSection:(NSUInteger)section;

/**
 *  cellModel所对应的 NSIndexPath
 */
- (NSIndexPath *)indexPathOfItem:(id<baseCellModelProtocal>)cellModel;

/**
 *  是否空的数据
 */
- (BOOL)isEmpty;

@end

@interface baseDataSource(creation)

- (instancetype)initWithDatasource:(baseDataSource *)datasource;

@end
