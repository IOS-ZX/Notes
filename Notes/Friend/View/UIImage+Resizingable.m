//
//  UIImage+Resizingable.m
//  08-QQ聊天布局-1
//
//  Created by sixleaves on 15/6/7.
//  Copyright (c) 2015年 sixleaves. All rights reserved.
//

#import "UIImage+Resizingable.h"

@implementation UIImage (Resizingable)

+ (UIImage *)resizeWithImageName:(NSString *)imageName {
    
    UIImage * image = [UIImage imageNamed: imageName];
    
    int W = image.size.width * 0.5;
    int H = image.size.height * 0.5;
    return [image resizableImageWithCapInsets: UIEdgeInsetsMake(H, W, image.size.height - H - 1 , image.size.width - W - 1)];

}

@end
