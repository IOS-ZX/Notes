//
//  WCalertView.m
//  Notes
//
//  Created by 王灿 on 2017/1/9.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "WCalertView.h"

@implementation WCalertView

+(UIAlertController *)title:(NSString *)title message:(NSString *)message type:(UIAlertControllerStyle)type{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:type];
    
    return alert;
}

@end
