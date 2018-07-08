//
//  XQTrackData.m
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/6.
//  Copyright © 2018年 小强. All rights reserved.
//

#import "XQTrackData.h"
#import "FMDB.h"

static XQTrackData * instance = nil;
static NSString * const kCachePath = @"xq_track";

@interface XQTrackData()
{
    FMDatabaseQueue * _dbQueue;
}
@end

@implementation XQTrackData
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance refreshPath];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return instance;
}

- (void)refreshPath
{
    // 1.打开数据库
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString * cachePath = [path stringByAppendingPathComponent:kCachePath];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:cachePath])
    {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
//    NSLog(@"+++++++++++++++++++cachePath %@",cachePath);
    NSString * docPath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"xq_track_%@.db",[XQTrackHandle getPhoneIdentifier]]];//这里可以拼接用户的id，数据库名和缓存路径名都可以根据自己取修改
    
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:docPath];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        // 2.创表:
        // xq_track_table
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS xq_track_table (id integer PRIMARY KEY, track_model blob NOT NULL);"];
    }];
}
#pragma mark --------------- xq_track_table
- (BOOL)queryTrackModel:(XQTrackModel *)trackModel
{
    __block  BOOL ret;
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:trackModel];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        ret = [db executeUpdateWithFormat:@"insert into xq_track_table (track_model) values (%@)",data];
    }];
    if(!ret)
    {
        XQLog(@"insert xq_track_table db error");
    }
    return ret;
}

- (NSArray *)trackModels
{
    __block NSMutableArray * track_models = [[NSMutableArray alloc] init];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * set = [db executeQueryWithFormat:@"select * from xq_track_table"];
        while (set.next) {
            NSData * data = [set objectForColumn:@"track_model"];
            XQTrackModel * model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [track_models addObject:model];
        }
        [set close];
    }];
    return track_models;
}

- (BOOL)deleteTrack
{
    __block BOOL ret;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        ret = [db executeUpdateWithFormat:@"delete from xq_track_table"];
    }];
    if(!ret)
    {
        NSLog(@"delete xq_track_table db error");
    }
    return ret;
}
@end
