//
//  FriendModel.m
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel


- (NSString *)description{
    return [NSString stringWithFormat:@"FriendModel:<fid:%@,uid:%@,uname:%@,img:%@",@(self.fid),self.uid,self.uname,self.img];
}

@end
