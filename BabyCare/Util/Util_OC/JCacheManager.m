//
//  MBSCacheManager.m
//  MBS
//
//  Created by 蒋亮 on 15/8/11.
//  Copyright (c) 2015年 CSHL. All rights reserved.
//

#import "JCacheManager.h"
#import "FMDB.h"

@interface JCacheManager (){
    FMDatabaseQueue *_dbQueue;
}

@end

@implementation JCacheManager

+ (JCacheManager *)sharedInstance {
    static JCacheManager *manager;
    if (!manager) {
        manager = [[JCacheManager alloc] initWithCachePath:[[self dbPath] stringByAppendingString:@"/data.db"]];
    }
    return manager;
}

+ (NSString *)dbPath {
    NSString *rootPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *docDir = [rootPath stringByAppendingPathComponent:@"cache"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:docDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:docDir
                                  withIntermediateDirectories:YES 
                                                   attributes:nil 
                                                        error:NULL];
    }
    NSLog(@"dbPath ============ %@",docDir);
    return docDir;
}

- (id)initWithCachePath:(NSString *)cachePath {
    self = [super init];
    if (self) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:cachePath];
        [_dbQueue inDatabase:^(FMDatabase *db) {
            if (![db tableExists:@"cache"]) {
                [db executeUpdate:@"CREATE TABLE cache (key VARCHAR PRIMARY KEY NOT NULL, expiry TIMESTAMP NOT NULL, data BOLB)"];
            }
        }];
        [self clearExpiryCache];
    }
    return self;
}

- (void)clearExpiryCache {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_dbQueue inDatabase:^(FMDatabase *db) {
            [db executeUpdate:@"delete from cache where expiry<? and expiry!=0", [NSNumber numberWithFloat:[[NSDate date] timeIntervalSince1970]]];
        }];
    });
}

- (void)setCache:(id<NSCoding>)cache forKey:(NSString *)key {
    [self setCache:cache forKey:key duration:90*24*60*60];
}

- (void)setCache:(id<NSCoding>)cache forKey:(NSString *)key duration:(NSInteger)duration {
    if (cache==nil||key==nil) {
        return;
    }
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"replace into cache (key, expiry, data) values (?,?,?)", key, [NSNumber numberWithFloat:duration>0?[[NSDate date] timeIntervalSince1970]+duration:0], [NSKeyedArchiver archivedDataWithRootObject:cache]];
    }];
}

- (id)cacheForKey:(NSString *)key {
    __block id<NSCoding> result = nil;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select data from cache where key=? and (expiry>? or expiry=0)", key, [NSNumber numberWithFloat:[[NSDate date] timeIntervalSince1970]]];
        if ([rs next]) {
            result = [NSKeyedUnarchiver unarchiveObjectWithData:[rs dataForColumn:@"data"]];
        }
        [rs close];
    }];
    return result;
}

- (BOOL)containsCache:(NSString *)key {
    __block BOOL result = NO;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select key from cache where key=?", key];
        result = [rs next];
        [rs close];
    }];
    return result;
}

- (void)removeCache:(NSString *)key {
    [_dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"delete from cache where key=?", key];
    }];
}

- (void)clearCache {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_dbQueue inDatabase:^(FMDatabase *db) {
            [db executeUpdate:@"delete from cache", [NSNumber numberWithFloat:[[NSDate date] timeIntervalSince1970]]];
        }];
    });
}


@end
