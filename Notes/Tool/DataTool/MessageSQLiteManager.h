//
//  MessageSQLiteManager.h
//  Notes
//
//  Created by rimi on 2017/1/9.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface MessageSQLiteManager : NSObject

+ (instancetype)sheardManager;

// 插入数据
- (BOOL)insertData:(Message*)model;

// 删除数据
- (BOOL)deleteData:(Message*)model;

// 删除所有数据
- (BOOL)deleteAllData;

// 查询所有
- (NSArray *)selectAllData:(NSString*)uid;

// 查询一条
- (Message *)selectById:(NSNumber*)fid;

@end
