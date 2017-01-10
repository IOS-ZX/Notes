//
//  ConversationModel.h
//  Notes
//
//  Created by rimi on 2017/1/9.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConversationModel : NSObject

/** id **/
@property(nonatomic,assign)NSInteger cid;

/** 会话id **/
@property(nonatomic,strong)NSString *conversationid;

/** 会话用户 **/
@property(nonatomic,strong)NSString *uid;

@end
