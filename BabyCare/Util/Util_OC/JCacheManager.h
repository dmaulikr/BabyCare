//
//  MBSCacheManager.h
//  MBS
//
//  Created by 蒋亮 on 15/8/11.
//  Copyright (c) 2015年 CSHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCacheManager : NSObject

+ (JCacheManager *)sharedInstance;

// 缓存的路径
+ (NSString *)dbPath;

/**
 @param cache <NSCoding> 带缓存数据 
 key 缓存时的key 
 */
- (void)setCache:(id<NSCoding>)cache forKey:(NSString *)key;
/**
 @param cache <NSCoding> 带缓存数据 
 key 缓存时的key 
 duration 缓存过期时间
 */
- (void)setCache:(id<NSCoding>)cache forKey:(NSString *)key duration:(NSInteger)duration;

/**
 @param key 缓存数据时的key
 @return    缓存的数据
 */
- (id)cacheForKey:(NSString *)key;

/**
 @return 是否存在缓存
 */

- (BOOL)containsCache:(NSString *)key;

//根据key删除缓存
- (void)removeCache:(NSString *)key;


- (void)clearCache;

@end
