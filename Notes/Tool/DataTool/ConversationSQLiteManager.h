//
//  ConversationSQLiteManager.h
//  Notes
//
//  Created by rimi on 2017/1/9.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationModel.h"

@interface ConversationSQLiteManager : NSObject

+ (instancetype)sheardManager;

// 插入数据
- (BOOL)insertData:(ConversationModel*)model;

// 删除数据
- (BOOL)deleteData:(ConversationModel*)model;

// 删除所有数据
- (BOOL)deleteAllData;

// 查询一条
- (ConversationModel *)selectById:(NSString*)uid;

@end
