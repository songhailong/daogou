//
//  WZCellModel.m
//  12123_Example
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZCellModel.h"

@implementation WZCellModel

-(instancetype)parse:(NSDictionary *)info options:(NSUInteger)options{
    [self ms_reflectDataRecursionFromOtherDictionary:info];
    return self;
}

+ (NSMutableArray *)parseArray:(NSArray *)array
{
    if (array==nil) {
        array=@[];
    }
    return [self parseArray:array options:0];
}

+ (NSMutableArray *)parseArray:(NSArray *)array options:(NSUInteger)options
{
    if (![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSMutableArray *objects = [NSMutableArray array];
    for (NSDictionary *e in array) {
        id<baseParser> m = nil;
        m = [[self class] instanceWithData:e options:options];
        [objects addObject:m];
    }
    return objects;
}

+ (instancetype)instanceWithData:(NSDictionary *)info
{
    return [self instanceWithData:info options:0];
}

+ (instancetype)instanceWithData:(NSDictionary *)info options:(NSUInteger)options
{
    return [[[self alloc] init] parse:info options:options];
}

@end
