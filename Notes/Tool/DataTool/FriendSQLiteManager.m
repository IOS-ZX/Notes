//
//  FriendSQLiteManager.m
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "FriendSQLiteManager.h"

@interface FriendSQLiteManager()

/** FMDB **/
@property(nonatomic,strong)FMDatabase *database;

/** path **/
@property(nonatomic,strong)NSString *path;


@end

@implementation FriendSQLiteManager

static FriendSQLiteManager *pointer = nil;

#pragma mark - 单例

+ (instancetype)sheardManager{
    if (!pointer) {
        pointer = [[FriendSQLiteManager alloc]init];
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
    NSString *str = @"create table if not exists friend(fid integer primary key AUTOINCREMENT,uid text not null ,uname text not null,img text);";
    [self.database executeUpdate:str];
}

// 插入数据
- (BOOL)insertData:(FriendModel*)model{
    [self createTable];
    return [self.database executeUpdate:@"INSERT INTO friend (uid,uname,img) VALUES (?,?,?)",model.uid,model.uname,model.img];
}


// 修改数据
- (BOOL)updateData:(FriendModel*)model{
    [self createTable];
    return [self.database executeUpdate:@"UPDATE friend SET uid = ? AND uname = ? AND img = ? WHERE fid = ? ",model.uid,model.uname,model.img,@(model.fid)];
}


// 删除数据
- (BOOL)deleteData:(FriendModel*)model{
    [self createTable];
    return [self.database executeUpdate:@"DELETE FROM friend WHERE fid = ?",@(model.fid)];
}

// 查询所有
- (NSArray *)selectAllData{
    [self createTable];
    FMResultSet *rs = [self.database executeQuery:@"SELECT * friend"];
    NSMutableArray *array = [NSMutableArray array];
    while ([rs next]) {
        FriendModel *model = [FriendModel new];
        model.fid = [rs intForColumn:@"fid"];
        model.uid = [rs stringForColumn:@"uid"];
        model.uname = [rs stringForColumn:@"uname"];
        model.img = [rs stringForColumn:@"img"];
        [array addObject:model];
    }
    return array;
}

// 查询一条
- (FriendModel *)selectById:(NSNumber*)fid{
    FMResultSet *rs = [self.database executeQuery:@"SELECT * friend WHERE fid = ?",fid];
    FriendModel *model = [FriendModel new];
    while ([rs next]) {
        model.fid = [rs intForColumn:@"fid"];
        model.uid = [rs stringForColumn:@"uid"];
        model.uname = [rs stringForColumn:@"uname"];
        model.img = [rs stringForColumn:@"img"];
    }
    return model;
}

#pragma mark - 懒加载

- (NSString *)path{
    if (!_path) {
        _path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        _path = [_path stringByAppendingPathComponent:@"myDB.db"];
    }
    return _path;
}

- (FMDatabase *)database{
    if (!_database) {
        _database = [FMDatabase databaseWithPath:self.path];
    }
    return _database;
}

@end
