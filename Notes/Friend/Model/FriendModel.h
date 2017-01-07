//
//  FriendModel.h
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject

/** id **/
@property(nonatomic,assign)NSInteger fid;

/** 用户id **/
@property(nonatomic,strong)NSString *uid;

/** name **/
@property(nonatomic,strong)NSString *uname;

/** image **/
@property(nonatomic,strong)NSString *img;

@end
