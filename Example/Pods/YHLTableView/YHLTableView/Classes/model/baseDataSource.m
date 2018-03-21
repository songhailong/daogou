//
//  baseDataSource.m
//  Pods
//
//  Created by yang on 16/6/3.
//
//

#import "baseDataSource.h"
#import "CellUpdating.h"

@implementation baseDataSource

- (instancetype)initWithItems:(NSArray *)aItems sections:(NSArray *)aSections{
    NSAssert((aItems && aSections && [aItems count]==[aSections count]), nil);
    
    self = [super init];
    if (self) {
        _items = [[[self itemsClass] alloc] initWithArray:aItems];
        _sections = [[[self sectionsClass] alloc] initWithArray:aSections];
    }
    return self;
}

- (Class)sectionsClass
{
    return [NSArray class];
}

- (Class)itemsClass
{
    return [NSArray class];
}

- (NSArray *)itemsAtSection:(NSUInteger)section{
    if ((int)section>=0 && section<[_sections count])
    {
        return [_items objectAtIndex:section];
    }
    else
    {
        return nil;
    }
}

- (id<baseCellModelProtocal>)itemAtIndexPath:(NSIndexPath *)indexPath
{
    if([_items count] > indexPath.section)
    {
        NSArray *arr = [_items objectAtIndex:indexPath.section];
        if ([arr count] > indexPath.row)
        {
            return [arr objectAtIndex:indexPath.row];
        }
    }
    return nil;
}


- (BOOL)isEmpty
{
    
    
//    //下面的判断不准确 可以只有header 没有item ，
//    NSUInteger numberOfItems = 0;
//    for (int i = 0; i<[self.items count]; i++) {
//        NSArray *items = [self.items objectAtIndex:i];
//        numberOfItems += [items count];
//    }
//
//    NSUInteger numberOfSections = [self.sections count];
//    return numberOfItems == 0 || numberOfSections == 0;
    
    //
    return [self.sections count] == 0 || [self.items count] == 0;
}

- (NSUInteger)numberOfItemsAtSection:(NSUInteger)section
{
    if (section<[_sections count]) {
        NSArray *items = [_items objectAtIndex:section];
        return [items count];
    }
    
    return 0;
}

- (NSIndexPath *)indexPathOfItem:(id<baseCellModelProtocal>)cellModel {
    NSInteger section = -1;
    NSInteger row = -1;
    
    for(int s = 0 ; s < [_items count]; s++) {
        NSArray *arr = [_items objectAtIndex:s];
        for(int r = 0 ; r < [arr count]; r++) {
            id<baseCellModelProtocal>item = arr[r];
            if (item == cellModel) {
                section = s;
                row  = r;
                break;
            }
        }
    }
    
    if (section != -1 && row != -1) {
        return [NSIndexPath indexPathForRow:row inSection:section];
    } else {
        return nil;
    }
}

#pragma mark tableview datasource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([_sections count] > section)
    {
        NSObject *object = [_sections objectAtIndex:section];
        
        if ([object isKindOfClass:[NSString class]])
        {
            return (NSString *)object;
        }
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [_sections count];
//    return [_sections count] ? [_sections count] : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section >=0 && section < [_items count])
    {
        NSArray *items = [_items objectAtIndex:section];
        
        NSUInteger count = [items count];
        
        return count;
    }
    
    return 0;
}

/**创建indexpath对应的cell
 *获取对应的cellClass （由子类复写cellClass方法，返回对应生成cell的类型）
 *子类复写此方法时，需要调用配置cell的数据，并且根据cell配置
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<baseCellModelProtocal> item = [self itemAtIndexPath:indexPath];
    
    BOOL useXIB = [item isRegisterByClass] ? NO : YES;
    NSString *reuseIdentifier = item.reuseIdentify;
    
    //注册 cell 、identifier
    [self tableView:tableView registerClass:item.Class forCellReuseIdentifier:reuseIdentifier userNib:useXIB];
    
    //生成cell
    id cell = (id)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
//    if (cell == nil)
//    {
//        cell = [[item.Class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
//    }
    //更新cell的数据
    if ([cell respondsToSelector:@selector(update:indexPath:)]) {
        [cell update:item indexPath:indexPath];
    }
    else if ([cell respondsToSelector:@selector(update:)]) {
        [cell update:item];
    }


    return cell;
}

- (void)tableView:(UITableView *)tableView registerClass:(Class)cellClass forCellReuseIdentifier:(nonnull NSString *)identifier userNib:(BOOL)useNib
{
    if (useNib)
    {
        
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
        if (nib)
        {
            [tableView registerNib:nib forCellReuseIdentifier:identifier];
        }
        else
        {
            [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
        }
    }
    else
    {
        [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
    }
}
@end



@implementation baseDataSource(creation)

- (instancetype)initWithDatasource:(baseDataSource *)datasource
{
    self = [super init];
    if (self) {
        _items = [[self itemsClass] arrayWithArray:datasource.items];
        _sections = [[self sectionsClass] arrayWithArray:datasource.sections];
    }
    return self;
    
}

@end
