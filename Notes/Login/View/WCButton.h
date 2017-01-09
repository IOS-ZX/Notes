//
//  WCButton.h
//  Notes
//
//  Created by 王灿 on 2017/1/7.
//  Copyright © 2017年 MrJoker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^finishBlock)();

@interface WCButton : UIView

@property (nonatomic,copy) finishBlock translateBlock;


@end
