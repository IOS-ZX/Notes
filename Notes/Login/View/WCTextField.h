//
//  WCTextField.h
//  Notes
//
//  Created by 王灿 on 2017/1/7.
//  Copyright © 2017年 MrJoker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCTextField : UIView

//文本框
@property (nonatomic,strong) UITextField *textField;

//注释信息
@property (nonatomic,copy) NSString *ly_placeholder;

//光标颜色
@property (nonatomic,strong) UIColor *cursorColor;

//注释普通状态下颜色
@property (nonatomic,strong) UIColor *placeholderNormalStateColor;

//注释选中状态下颜色
@property (nonatomic,strong) UIColor *placeholderSelectStateColor;
@end
