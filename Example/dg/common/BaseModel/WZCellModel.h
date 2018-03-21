//
//  WZCellModel.h
//  12123_Example
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import <YHLTableView/YHLTableView.h>
#import <commonLib/NSObject+Reflect.h>
@interface WZCellModel : baseCellModel

@property (nonatomic,assign) NSInteger Id;

/**
 *  根据JSON数据, 实例化对象
 *
 *  @param info JSON数据
 *
 *  @return 对象
 */
+ (instancetype)instanceWithData:(NSDictionary *)info;

/**
 *  传入JSON数组, 返回对应的对象数组
 *
 *  @param array JSON数组
 *
 *  @return 对应的对象数组
 */
+ (NSMutableArray *)parseArray:(NSArray *)array;

@end
