//
//  IracleConfig.h
//  UIPickerView、UIDatePicker
//
//  Created by Iracle Zhang on 2/18/16.
//  Copyright © 2016 Iracle Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CRM(x, y, width, height)    CGRectMake(x, y, width, height)
#define CPM(x, y)                   CGPointMake(x, y)
#define CSM(width, height)          CGSizeMake(width, height);
#define SCREEN_WIDTH                [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT               [UIScreen mainScreen].bounds.size.height
#define MID_X                       CGRectGetMidX([UIScreen mainScreen].bounds)
#define MID_Y                       CGRectGetMidY([UIScreen mainScreen].bounds)
