//
//  PINCache+YMCache.m
//  YMInfo
//
//  Created by yangshiyu on 2017/2/13.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "PINCache+YMCache.h"

@implementation PINCache (YMCache)


+(instancetype)ymCache{
    static PINCache *__ymCache = nil;
    static NSString *__ymCacheName = @"xszs.cache";
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __ymCache = [[PINCache alloc] initWithName:__ymCacheName];
//        [self clearOldVersionData:__ymCache];
    });
    return __ymCache;
}


+(instancetype)commonCache{
    static PINCache *__baseCache = nil;
    static NSString *__baseCacheName = @"xszs.basecache";
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __baseCache = [[PINCache alloc] initWithName:__baseCacheName];
        [self clearOldVersionData:__baseCache];
    });
    return __baseCache;
}


//清空上个版本的数据
+(void)clearOldVersionData:(PINCache *)cache
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *buildVersion = infoDictionary[@"CFBundleVersion"];
    NSString *oldVersion = [cache objectForKey:@"__Version__"];
    
    if (![oldVersion isEqualToString:buildVersion]) {
        [cache removeAllObjects];
        [cache setObject:buildVersion forKey:@"__Version__"];
    }
}

+ (void)ym_setCacheObject:(id <NSCoding>)object forKey:(NSString *)key
{
    [[self ymCache] setObject:object forKey:key];
}

+ (id)ym_cachedObjectForKey:(NSString *)key
{
    return [[self ymCache] objectForKey:key];
}

+ (void)ym_removeCachedObjectForKey:(NSString *)key
{
    return [[self ymCache] removeObjectForKey:key];
}

//+ (void)ym_removeAllCachedObjects
//{
//    return [[self ymCache] removeAllObjects];
//}

- (void)ym_setCacheObject:(id <NSCoding>)object forKey:(NSString *)key
{
    [self setObject:object forKey:key];
}

- (id)ym_cachedObjectForKey:(NSString *)key
{
    return [self objectForKey:key];
}

- (void)ym_removeCachedObjectForKey:(NSString *)key
{
    return [self removeObjectForKey:key];
}

- (void)ym_removeAllCachedObjects
{
    return [self removeAllObjects];
}

+(NSString *)currentVersion{
    PINCache *cache =[PINCache ymCache];
    NSString *curremtVersion = [cache objectForKey:@"__Version__"];
    
    return curremtVersion;
}


@end
