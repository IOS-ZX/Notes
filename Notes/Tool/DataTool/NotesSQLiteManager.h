//
//  NotesSQLiteManager.h
//  Notes
//
//  Created by rimi on 2017/1/11.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordModel.h"

@interface NotesSQLiteManager : NSObject

+ (instancetype)sheardManager;

// 插入数据
- (BOOL)insertData:(RecordModel*)model;

// 修改数据
- (BOOL)updateData:(RecordModel*)model;

// 删除数据
- (BOOL)deleteData:(RecordModel*)model;

// 删除所有数据
- (BOOL)deleteAllData;

// 查询所有
- (NSArray *)selectAllData;

// 根据类型查询
- (NSArray *)selectByType:(RecordType)type;

// 查询一条
- (RecordModel *)selectById:(NSNumber*)mid;

// 根据类型查询草稿
- (RecordModel *)selectByTemp:(NSNumber*)temp type:(RecordType)type;

@end
