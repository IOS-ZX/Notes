//
//  GetUserFriend.m
//  Notes
//
//  Created by rimi on 2017/1/9.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "GetUserFriend.h"
#import "FriendModel.h"
#import "FriendSQLiteManager.h"

@implementation GetUserFriend

+ (void)requestFriendData:(ResultFriend)result{
    AVUser *user = [AVUser currentUser];
    AVQuery *query = [AVQuery queryWithClassName:@"myfriend"];
    [query includeKey:@"user"];
    [query includeKey:@"user.objectId"];
    [query whereKey:@"self" equalTo:user.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"friend query error:%@",error);
        }else{
//            NSLog(@"count:%ld",objects.count);
            NSArray *arr = [self objectsToModel:objects];
            result(arr);
        }
    }];
}

// 对象转模型
+ (NSArray *)objectsToModel:(NSArray*)obj{
    __block NSMutableArray *arr = [NSMutableArray array];
    [obj enumerateObjectsUsingBlock:^(AVObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AVUser *user = [obj objectForKey:@"user"];
        FriendModel *model = [FriendModel new];
        model.uname = user.username;
        model.img = user[@"image"];
        model.uid = user.objectId;
        [arr addObject:model];
    }];
    [self saveFriends:arr];
    return arr;
}

// 储存好友信息
+ (void)saveFriends:(NSArray*)array{
    [[FriendSQLiteManager sheardManager]deleteAllData];
    [array enumerateObjectsUsingBlock:^(FriendModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL ins = [[FriendSQLiteManager sheardManager]insertData:model];
        if (!ins) {
            NSLog(@"数据插入失败");
        }
    }];
}


@end
