//
//  MessageSQLiteManager.m
//  Notes
//
//  Created by rimi on 2017/1/9.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "MessageSQLiteManager.h"

@interface  MessageSQLiteManager()

/** FMDB **/
@property(nonatomic,strong)FMDatabase *database;

/** path **/
@property(nonatomic,strong)NSString *path;

/** 表 **/
@property(nonatomic,strong)NSString *tableName;


@end

@implementation MessageSQLiteManager

static MessageSQLiteManager *pointer = nil;

#pragma mark - 单例

+ (instancetype)sheardManager{
    if (!pointer) {
        pointer = [[MessageSQLiteManager alloc]init];
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
    NSString *str = [NSString stringWithFormat:@"create table if not exists msg(mid integer primary key AUTOINCREMENT,msg text not null ,uid text not null,isSelf integer);"];
    [self.database executeUpdate:str];
}

// 插入数据
- (BOOL)insertData:(Message*)model{
    [self createTable];
    if ([self selectByModel:model]) {
        return NO;
    }
    return [self.database executeUpdate:@"INSERT INTO msg (msg,uid,isSelf) VALUES (?,?,?)",model.text,model.uid,@(model.isSelf)];
}


// 删除数据
- (BOOL)deleteData:(Message*)model{
    [self createTable];
    return [self.database executeUpdate:@"DELETE FROM msg WHERE mid = ?",@(model.mid)];
}

// 删除所有数据
- (BOOL)deleteAllData{
    [self createTable];
    return [self.database executeUpdate:@"DELETE FROM msg"];
}

// 查询所有
- (NSArray *)selectAllData:(NSString*)uid{
    [self createTable];
    FMResultSet *rs = [self.database executeQuery:@"SELECT * FROM msg WHERE uid = ?",uid];
    NSMutableArray *array = [NSMutableArray array];
    while ([rs next]) {
        Message *model = [Message new];
        model.mid = [rs intForColumn:@"mid"];
        model.uid = [rs stringForColumn:@"uid"];
        model.text = [rs stringForColumn:@"msg"];
        NSInteger isSelf = [[rs stringForColumn:@"isSelf"] integerValue];
        model.isSelf = isSelf;
        if (isSelf == 1) {
            model.type = MessageWHoIsAnother;
        }else{
            model.type = MessageWhoIsMe;
        }
        [array addObject:model];
    }
    return array;
}

// 查询是否存在
- (BOOL)selectByModel:(Message*)model{
    [self createTable];
    FMResultSet *rs = [self.database executeQuery:@"SELECT * FROM msg WHERE mid = ?",model.mid];
    BOOL result = NO;
    while ([rs next]) {
        result = YES;
    }
    return result;
}

// 查询一条
- (Message *)selectById:(NSNumber*)mid{
    [self createTable];
    FMResultSet *rs = [self.database executeQuery:@"SELECT * FROM msg WHERE mid = ?",mid];
    Message *model = [Message new];
    while ([rs next]) {
        model.mid = [rs intForColumn:@"mid"];
        model.uid = [rs stringForColumn:@"uid"];
        model.text = [rs stringForColumn:@"msg"];
        NSInteger isSelf = [[rs stringForColumn:@"isSelf"] integerValue];
        model.isSelf = isSelf;
        if (isSelf == 1) {
            model.type = MessageWHoIsAnother;
        }else{
            model.type = MessageWhoIsMe;
        }
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
