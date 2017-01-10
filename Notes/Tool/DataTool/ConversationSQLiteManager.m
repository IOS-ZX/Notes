//
//  ConversationSQLiteManager.m
//  Notes
//
//  Created by rimi on 2017/1/9.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "ConversationSQLiteManager.h"

@interface ConversationSQLiteManager()

/** FMDB **/
@property(nonatomic,strong)FMDatabase *database;

/** path **/
@property(nonatomic,strong)NSString *path;

/** 表 **/
@property(nonatomic,strong)NSString *tableName;


@end

@implementation ConversationSQLiteManager

static ConversationSQLiteManager *pointer = nil;

#pragma mark - 单例

+ (instancetype)sheardManager{
    if (!pointer) {
        pointer = [[ConversationSQLiteManager alloc]init];
    }
    return pointer;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (!pointer) {
        pointer = [super allocWithZone:zone];
    }
    return pointer;
}

#pragma mark - 创建表

- (void)createTable{
    if (![self.database open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    NSString *str = [NSString stringWithFormat:@"create table if not exists conversation(cid integer primary key AUTOINCREMENT,uid text not null ,conversationid text not null);"];
    [self.database executeUpdate:str];
}

// 插入数据
- (BOOL)insertData:(ConversationModel*)model{
    [self createTable];
    if ([self selectByModel:model]) {
        return NO;
    }
    return [self.database executeUpdate:@"INSERT INTO conversation (uid,conversationid) VALUES (?,?)",model.uid,model.conversationid];
}


// 修改数据
- (BOOL)updateData:(ConversationModel*)model{
    [self createTable];
    return [self.database executeUpdate:@"UPDATE conversation SET uid = ? AND conversationid = ? WHERE cid = ? ",model.uid,model.conversationid,@(model.cid)];
}


// 删除数据
- (BOOL)deleteData:(ConversationModel*)model{
    [self createTable];
    return [self.database executeUpdate:@"DELETE FROM conversation WHERE cid = ?",@(model.cid)];
}

// 删除所有数据
- (BOOL)deleteAllData{
    [self createTable];
    return [self.database executeUpdate:@"DELETE FROM conversation"];
}

// 查询所有
- (NSArray *)selectAllData{
    [self createTable];
    FMResultSet *rs = [self.database executeQuery:@"SELECT * FROM conversation"];
    NSMutableArray *array = [NSMutableArray array];
    while ([rs next]) {
        ConversationModel *model = [ConversationModel new];
        model.cid = [rs intForColumn:@"cid"];
        model.uid = [rs stringForColumn:@"uid"];
        model.conversationid = [rs stringForColumn:@"conversationid"];
        [array addObject:model];
    }
    return array;
}

// 查询是否存在
- (BOOL)selectByModel:(ConversationModel*)model{
    [self createTable];
    FMResultSet *rs = [self.database executeQuery:@"SELECT * FROM conversation WHERE uid = ? AND conversationid = ?",model.uid,model.conversationid];
    BOOL result = NO;
    while ([rs next]) {
        result = YES;
    }
    return result;
}

// 查询一条
- (ConversationModel *)selectById:(NSNumber*)cid{
    [self createTable];
    FMResultSet *rs = [self.database executeQuery:@"SELECT * FROM conversation WHERE cid = ?",cid];
    ConversationModel *model = [ConversationModel new];
    while ([rs next]) {
        model.cid = [rs intForColumn:@"cid"];
        model.uid = [rs stringForColumn:@"uid"];
        model.conversationid = [rs stringForColumn:@"conversationid"];
    }
    return model;
}

#pragma mark - 懒加载

- (NSString *)path{
    if (!_path) {
        _path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        _path = [_path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",self.tableName]];
    }
    return _path;
}

- (FMDatabase *)database{
    if (!_database) {
        _database = [FMDatabase databaseWithPath:self.path];
    }
    return _database;
}

- (NSString *)tableName{
    return [AVUser currentUser].objectId;
}

@end
