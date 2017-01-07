//
//  FriendSQLiteManager.m
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "FriendSQLiteManager.h"
#import <sqlite3.h>

@interface FriendSQLiteManager()

/** sqlite **/
@property(nonatomic,assign)sqlite3 *sql;

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

+ (int)openDB{
//    return sqlite3_open(pointer.path.UTF8String, &_sql);
}

+ (void)createTable:(NSString*)tableName{
    NSString *str = @"create table if not exists friend(fid integer primary key AUTOINCREMENT,uid text not null ,uname text not null,img text);";
}

#pragma mark - 懒加载

- (NSString *)path{
    if (!_path) {
        _path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        _path = [_path stringByAppendingPathComponent:@"myDB.sqlite"];
    }
    return _path;
}

@end
