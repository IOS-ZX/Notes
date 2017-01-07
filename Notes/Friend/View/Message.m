//
//  Message.m
//  ChatLayout
//
//  Created by Iracle Zhang on 5/10/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

#import "Message.h"

@implementation Message

+ (instancetype)messageWithDic:(NSDictionary *)info {
    Message *model = [[Message alloc]init];
    [model setValuesForKeysWithDictionary:info];
    return model;
}

@end
