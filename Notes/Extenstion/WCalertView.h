//
//  WCalertView.h
//  Notes
//
//  Created by 王灿 on 2017/1/9.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCalertView : UIView

+(UIAlertController *)title:(NSString *)title message:(NSString *)message type:(UIAlertControllerStyle)type;

@end
