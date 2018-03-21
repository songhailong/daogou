//
//  PINCacheHelper.m
//  Pods
//
//  Created by yanghonglei on 16/7/8.
//
//

#import "PINCacheHelper.h"
#import <PINCache/PINCache.h>

@implementation PINCacheHelper

//+ (BOOL)isExtistCacheWithKey:(NSString *)key{
//    return YES;
//}

+ (id)cacheObjectForKey:(NSString *)key{
    return [[PINCache sharedCache] objectForKey:key];
}

+ (void)setCacheObject:(id)obj forKey:(NSString *)key disk:(BOOL)disk{
    if (disk)
    {
        [[PINCache sharedCache] setObject:obj forKey:key];
    }
    else
    {
        [[PINCache sharedCache].memoryCache setObject:obj forKey:key];
    }

}

@end
