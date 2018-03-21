//
//  PINCacheHelper.h
//  Pods
//
//  Created by yanghonglei on 16/7/8.
//
//

#import <Foundation/Foundation.h>

@interface PINCacheHelper : NSObject

//+ (BOOL)isExtistCacheWithKey:(NSString *)key;

+ (id)cacheObjectForKey:(NSString *)key;

+ (void)setCacheObject:(id)obj forKey:(NSString *)key disk:(BOOL)disk;

@end
