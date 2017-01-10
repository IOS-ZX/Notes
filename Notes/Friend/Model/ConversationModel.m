//
//  ConversationModel.m
//  Notes
//
//  Created by rimi on 2017/1/9.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "ConversationModel.h"

@implementation ConversationModel

- (NSString *)description{
    return [NSString stringWithFormat:@"cid:%ld,Conversationid:%@,uid:%@",self.cid,self.conversationid,self.uid];
}

@end
