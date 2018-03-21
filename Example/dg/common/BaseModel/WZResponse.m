//
//  WZResponse.m
//  12123_Example
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZResponse.h"

@implementation WZResponse

- (instancetype)parse:(NSDictionary *)info options:(NSUInteger)options
{
    [self ms_reflectDataRecursionFromOtherDictionary:info];
    return self;
}

-(BOOL)success{
    return self.code==0;
}

-(NSString *)msg{
    if (_msg!=nil) {
        return _msg;
    }else{
        return @"系统繁忙、请稍后重试!";
    }
}

@end
