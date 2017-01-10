//
//  ImageDiscernment.h
//  Notes
//
//  Created by rimi on 2017/1/10.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

typedef void(^ImageToString)(NSString *text);

#import <Foundation/Foundation.h>

@interface ImageDiscernment : NSObject<G8TesseractDelegate>


/** 图片识别--获取图片内文字 **/
- (void)getStringForImage:(UIImage*)image result:(ImageToString)result;

@end
