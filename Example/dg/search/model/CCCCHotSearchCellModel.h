//
//  CCCCHotSearchCellModel.h
//  che_Example
//
//  Created by 杨红磊 on 2017/12/5.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import <YHLTableView/YHLTableView.h>

@interface CCCCHotSearchCellModel : baseCellModel

@property (nonatomic,strong) NSArray *hots;

@property (nonatomic,assign) CGFloat collectionHeight;
@end

@interface CCHistorySearchCellModel : baseCellModel

@property (nonatomic,strong) NSString *historyKey;

@end

@interface CCSearchItemCellModel : baseCellModel

@property (nonatomic,strong) NSString *searchKey;

@end




