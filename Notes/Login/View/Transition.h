//
//  Transition.h
//  Notes
//
//  Created by 王灿 on 2017/1/7.
//  Copyright © 2017年 MrJoker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, WCPresentOneTransitionType) {
    WCPresentOneTransitionTypePresent = 0,//管理present动画
    WCPresentOneTransitionTypeDismiss//管理dismiss动画
};

@interface Transition : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@property (nonatomic,assign) WCPresentOneTransitionType type;

+ (instancetype)transitionWithTransitionType:(WCPresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(WCPresentOneTransitionType)type;


@end


