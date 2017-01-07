//
//  Message.h
//  ChatLayout
//
//  Created by Iracle Zhang on 5/10/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

typedef NS_ENUM(NSInteger, MessageWho) {
    MessageWhoIsMe = 0,
    MessageWHoIsAnother
};

@interface Message : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) MessageWho type;
@property (nonatomic, assign) CGFloat height;

+(instancetype)messageWithDic:(NSDictionary *)info;

@end
