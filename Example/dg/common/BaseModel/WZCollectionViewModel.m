//
//  WZCollectionViewModel.m
//  TVSearch_Example
//
//  Created by che on 2018/1/19.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZCollectionViewModel.h"
#import <commonLib/NSObject+Reflect.h>

@implementation WZCollectionViewModel

-(instancetype)parse:(NSDictionary *)info options:(NSUInteger)options{
    [self ms_reflectDataRecursionFromOtherDictionary:info];
    return self;
}

@end
