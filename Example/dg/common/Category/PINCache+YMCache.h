//
//  PINCache+YMCache.h
//  YMInfo
//
//  Created by yangshiyu on 2017/2/13.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import <PINCache/PINCache.h>

@interface PINCache (YMCache)
//不可随意删除的缓存信息
+(instancetype)ymCache;
//可以随意清理
+(instancetype)commonCache;

+ (void)ym_setCacheObject:(id <NSCoding>)object forKey:(NSString *)key;
+ (id)ym_cachedObjectForKey:(NSString *)key;
+ (void)ym_removeCachedObjectForKey:(NSString *)key;
//+ (void)ym_removeAllCachedObjects;

- (void)ym_setCacheObject:(id <NSCoding>)object forKey:(NSString *)key;
- (id)ym_cachedObjectForKey:(NSString *)key;
- (void)ym_removeCachedObjectForKey:(NSString *)key;
- (void)ym_removeAllCachedObjects;

//获取app当前版本
+(NSString *)currentVersion;
@end
