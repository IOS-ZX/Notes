//
//  NotesSQLiteManager.m
//  Notes
//
//  Created by rimi on 2017/1/11.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "NotesSQLiteManager.h"

@interface NotesSQLiteManager()

/** FMDB **/
@property(nonatomic,strong)FMDatabase *database;

/** path **/
@property(nonatomic,strong)NSString *path;

/** 表 **/
@property(nonatomic,strong)NSString *tableName;


@end

@implementation NotesSQLiteManager

static NotesSQLiteManager *pointer = nil;

#pragma mark - 单例

+ (instancetype)sheardManager{
    if (!pointer) {
        pointer = [[NotesSQLiteManager alloc]init];
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
    NSString *str = [NSString stringWithFormat:@"create table if not exists record(nid integer primary key AUTOINCREMENT,title text,content text not null,imgs text,files text,type integer not null,temp integer not null,dates text not null);"];
    [self.database executeUpdate:str];
}

// 插入数据
- (BOOL)insertData:(RecordModel*)model{
    [self createTable];
    if (model.nid) {
        return [self updateData:model];
    }
    return [self.database executeUpdate:@"INSERT INTO record (title,content,imgs,files,type,temp,dates) VALUES (?,?,?,?,?,?,?)",model.title,model.content,model.images,model.files,@(model.type),@(model.isTemp),model.date];
}


// 修改数据
- (BOOL)updateData:(RecordModel*)model{
    [self createTable];
    return [self.database executeUpdate:@"UPDATE record SET title = ? , content = ? , imgs = ? , files = ? , type = ? , temp = ? , dates = ? WHERE nid = ? ",model.title,model.content,model.images,model.files,@(model.type),@(model.isTemp),model.date,@(model.nid)];
}


// 删除数据
- (BOOL)deleteData:(RecordModel*)model{
    [self createTable];
    return [self.database executeUpdate:@"DELETE FROM record WHERE nid = ?",@(model.nid)];
}

// 删除所有数据
- (BOOL)deleteAllData{
    [self createTable];
    return [self.database executeUpdate:@"DELETE FROM record"];
}

// 查询所有
- (NSArray *)selectAllData{
    [self createTable];
    FMResultSet *rs = [self.database executeQuery:@"SELECT * FROM record"];
    NSMutableArray *array = [NSMutableArray array];
    while ([rs next]) {
        RecordModel *model = [RecordModel new];
        model.nid = [rs intForColumn:@"nid"];
        model.title = [rs stringForColumn:@"title"];
        model.content = [rs stringForColumn:@"content"];
        model.images = [rs stringForColumn:@"imgs"];
        model.files = [rs stringForColumn:@"files"];
        model.type = [rs intForColumn:@"type"];
        model.isTemp = [rs intForColumn:@"temp"];
        model.date = [rs stringForColumn:@"dates"];
        [array addObject:model];
    }
    return array;
}

// 根据类型查询
- (NSArray *)selectByType:(RecordType)type{
    [self createTable];
    FMResultSet *rs = [self.database executeQuery:@"SELECT * FROM record WHERE type = ?",@(type)];
    NSMutableArray *array = [NSMutableArray array];
    while ([rs next]) {
        RecordModel *model = [RecordModel new];
        model.nid = [rs intForColumn:@"nid"];
        model.title = [rs stringForColumn:@"title"];
        model.content = [rs stringForColumn:@"content"];
        model.images = [rs stringForColumn:@"imgs"];
        model.files = [rs stringForColumn:@"files"];
        model.type = [rs intForColumn:@"type"];
        model.isTemp = [rs intForColumn:@"temp"];
        model.date = [rs stringForColumn:@"dates"];
        [array addObject:model];
    }
    return array;
}

// 查询是否存在
- (BOOL)selectByModel:(RecordModel*)model{
    [self createTable];
    FMResultSet *rs = [self.database executeQuery:@"SELECT * FROM record WHERE title = ? AND content = ? AND imgs = ? AND files = ? AND type = ? AND temp = ?",model.title,model.content,model.images,model.files,@(model.type),@(model.isTemp)];
    BOOL result = NO;
    while ([rs next]) {
        result = YES;
    }
    return result;
}

// 查询一条
- (RecordModel *)selectByTemp:(NSNumber*)temp type:(RecordType)type{
    [self createTable];
    FMResultSet *rs = [self.database executeQuery:@"SELECT * FROM record WHERE type = ? AND temp = ?",@(type),temp];
    RecordModel *model = [RecordModel new];
    while ([rs next]) {
        model.nid = [rs intForColumn:@"nid"];
        model.title = [rs stringForColumn:@"title"];
        model.content = [rs stringForColumn:@"content"];
        model.images = [rs stringForColumn:@"imgs"];
        model.files = [rs stringForColumn:@"files"];
        model.type = [rs intForColumn:@"type"];
        model.isTemp = [rs intForColumn:@"temp"];
        model.date = [rs stringForColumn:@"dates"];
    }
    return model;
}

// 查询一条
- (RecordModel *)selectById:(NSNumber*)nid{
    [self createTable];
    FMResultSet *rs = [self.database executeQuery:@"SELECT * FROM record WHERE nid = ?",nid];
    RecordModel *model = [RecordModel new];
    while ([rs next]) {
        model.nid = [rs intForColumn:@"nid"];
        model.title = [rs stringForColumn:@"title"];
        model.content = [rs stringForColumn:@"content"];
        model.images = [rs stringForColumn:@"imgs"];
        model.files = [rs stringForColumn:@"files"];
        model.type = [rs intForColumn:@"type"];
        model.isTemp = [rs intForColumn:@"temp"];
        model.date = [rs stringForColumn:@"dates"];
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
