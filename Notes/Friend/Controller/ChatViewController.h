//
//  ChatViewController.h
//  Notes
//
//  Created by rimi on 2017/1/7.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendModel.h"

@interface ChatViewController : UIViewController

/** client **/
@property(nonatomic,strong)AVIMClient *client;

/** 用户 **/
@property(nonatomic,strong)FriendModel *model;

@end
