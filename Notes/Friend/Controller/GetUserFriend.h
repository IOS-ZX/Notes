//
//  GetUserFriend.h
//  Notes
//
//  Created by rimi on 2017/1/9.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

typedef void(^ResultFriend)(NSArray* arr);

#import <Foundation/Foundation.h>

@interface GetUserFriend : NSObject

+ (void)requestFriendData:(ResultFriend)result;

@end
