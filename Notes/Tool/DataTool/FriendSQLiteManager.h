//
//  FriendSQLiteManager.h
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendModel.h"

@interface FriendSQLiteManager : NSObject

+ (instancetype)sheardManager;

// 插入数据
- (BOOL)insertData:(FriendModel*)model;

// 修改数据
- (BOOL)updateData:(FriendModel*)model;

// 删除数据
- (BOOL)deleteData:(FriendModel*)model;

// 查询所有
- (NSArray *)selectAllData;

// 查询一条
- (FriendModel *)selectById:(NSNumber*)fid;

@end
