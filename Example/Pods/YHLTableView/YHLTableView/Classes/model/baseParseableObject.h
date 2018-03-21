//
//  EMParseableObject.h
//  F
//
//  Created by Ryan Wang on 4/14/15.
//  Copyright (c) 2015 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol baseParser <NSObject>

@required

/**
 *  解析JSON数据, 这个方法必须子类去实现
 *
 *  @param info JSON数据
 *  @param options 预留
 *
 *  @return 对象实例
 */
- (instancetype)parse:(NSDictionary *)info options:(NSUInteger)options;


@optional

/**
 *  根据JSON数据, 实例化对象
 *
 *  @param info JSON数据
 *  @param options 预留
 *
 *  @return 对象实例
 */
+ (instancetype)instanceWithData:(NSDictionary *)info options:(NSUInteger)options;


/**
 *  传入JSON数组, 返回对应的对象数组
 *
 *  @param array JSON数组
 *  @param options 预留
 *
 *  @return 对应的对象数组
 */
+ (NSMutableArray *)parseArray:(NSArray *)infos options:(NSUInteger)options;

@end


/**
 *  数据解析的对象
 */
@interface baseParseableObject : NSObject <baseParser>


/**
 *  传入JSON数组, 返回对应的对象数组
 *
 *  @param array JSON数组
 *
 *  @return 对应的对象数组
 */
+ (NSMutableArray *)parseArray:(NSArray *)array;


/**
 *  根据JSON数据, 实例化对象
 *
 *  @param info JSON数据
 *
 *  @return 对象
 */
+ (instancetype)instanceWithData:(NSDictionary *)info;


/**
 *  解析JSON数据,
 *
 *  @param info JSON数据
 *
 *  @return 对象
 */
- (instancetype)parse:(NSDictionary *)info;

/**
 *  解析JSON数据,
 *
 *  @param info JSON数据
 *  @param options 预留
 *
 *  @return 对象
 */
- (instancetype)parse:(NSDictionary *)info options:(NSUInteger)options;

@end

